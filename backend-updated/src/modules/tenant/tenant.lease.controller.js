const prisma = require('../../config/prisma');

// GET /api/tenant/lease
exports.getLeaseDetails = async (req, res) => {
    try {
        const userId = req.user.id;

        const tenant = await prisma.user.findUnique({
            where: { id: userId },
            include: {
                leases: {
                    where: { status: 'Active' },
                    include: {
                        unit: {
                            include: { property: true }
                        }
                    }
                }
            }
        });

        if (!tenant || tenant.leases.length === 0) {
            return res.status(404).json({ message: 'No active lease found' });
        }

        const lease = tenant.leases[0];

        res.json({
            id: `LEASE-${new Date(lease.startDate).getFullYear()}-${lease.id}`,
            property: lease.unit.property.name,
            unit: lease.unit.name,
            address: lease.unit.property.address,
            monthlyRent: parseFloat(lease.monthlyRent),
            startDate: lease.startDate,
            endDate: lease.endDate,
            status: lease.status,
            deposit: parseFloat(lease.monthlyRent), // Mock assumption
        });

    } catch (e) {
        console.error(e);
        res.status(500).json({ message: 'Server error' });
    }
};
