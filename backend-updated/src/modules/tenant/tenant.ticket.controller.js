const prisma = require('../../config/prisma');

// GET /api/tenant/tickets
exports.getTickets = async (req, res) => {
    try {
        const userId = req.user.id;
        const tickets = await prisma.ticket.findMany({
            where: { userId },
            orderBy: { createdAt: 'desc' }
        });

        const formatted = tickets.map(t => ({
            id: `T-${t.id + 1000}`,
            subject: t.subject,
            desc: t.description,
            status: t.status,
            priority: t.priority,
            date: t.createdAt.toISOString().split('T')[0]
        }));

        res.json(formatted);
    } catch (e) {
        console.error(e);
        res.status(500).json({ message: 'Server error' });
    }
};

// POST /api/tenant/tickets
exports.createTicket = async (req, res) => {
    try {
        const userId = req.user.id;
        const { subject, desc, priority } = req.body;

        const newTicket = await prisma.ticket.create({
            data: {
                userId,
                subject,
                description: desc,
                priority: priority || 'Low',
                status: 'Open'
            }
        });

        res.status(201).json({
            id: `T-${newTicket.id + 1000}`,
            subject: newTicket.subject,
            desc: newTicket.description,
            status: newTicket.status,
            priority: newTicket.priority,
            date: newTicket.createdAt.toISOString().split('T')[0]
        });

    } catch (e) {
        console.error(e);
        res.status(500).json({ message: 'Error creating ticket' });
    }
};
