const prisma = require('../../config/prisma');

// GET /api/tenant/invoices
exports.getInvoices = async (req, res) => {
    try {
        const userId = req.user.id;

        // Find invoices where tenantId matches
        // Also ensure status is 'sent' or 'paid' (Tenant shouldn't see 'draft')
        const invoices = await prisma.invoice.findMany({
            where: {
                tenantId: userId,
                status: { not: 'draft' }
            },
            orderBy: { createdAt: 'desc' },
            include: { unit: true }
        });

        const formatted = invoices.map(inv => ({
            id: inv.invoiceNo,
            dbId: inv.id,
            month: inv.month,
            amount: parseFloat(inv.amount),
            rent: parseFloat(inv.rent),
            serviceFees: parseFloat(inv.serviceFees),
            status: inv.status === 'sent' ? 'Due' : 'Paid', // Map 'sent' -> 'Due' for frontend display
            date: inv.createdAt.toISOString().split('T')[0],
            unit: inv.unit ? inv.unit.name : 'N/A'
        }));

        res.json(formatted);
    } catch (e) {
        console.error(e);
        res.status(500).json({ message: 'Server error' });
    }
};
