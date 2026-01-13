const prisma = require('../../config/prisma');

// GET /api/admin/insurance/alerts
exports.getInsuranceAlerts = async (req, res) => {
    try {
        const today = new Date();
        const insurances = await prisma.insurance.findMany({
            include: { user: true }
        });

        // We need Unit info. Insurance is linked to User. User has Leases. Leases have Units.
        // Let's fetch leases to map User -> Unit
        const leases = await prisma.lease.findMany({
            where: { status: 'Active' },
            include: { unit: { include: { property: true } } }
        });

        const userLeaseMap = {};
        leases.forEach(l => {
            userLeaseMap[l.tenantId] = l.unit;
        });

        const formatted = insurances.map(ins => {
            const unit = userLeaseMap[ins.userId];
            return {
                id: ins.id,
                tenantName: ins.user.name,
                property: unit ? unit.property.name : 'Unknown',
                unit: unit ? unit.name : 'N/A',
                provider: ins.provider,
                policyNumber: ins.policyNumber,
                startDate: ins.startDate.toISOString().substring(0, 10),
                endDate: ins.endDate.toISOString().substring(0, 10)
            };
        });

        res.json(formatted);
    } catch (e) {
        console.error(e);
        res.status(500).json({ message: 'Server error' });
    }
};
