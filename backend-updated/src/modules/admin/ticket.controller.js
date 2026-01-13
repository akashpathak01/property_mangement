const prisma = require('../../config/prisma');

// GET /api/admin/tickets
exports.getAllTickets = async (req, res) => {
    try {
        const tickets = await prisma.ticket.findMany({
            include: {
                user: {
                    include: {
                        leases: {
                            where: { status: 'Active' },
                            include: { unit: { include: { property: true } } }
                        }
                    }
                }
            },
            orderBy: { createdAt: 'desc' }
        });

        const formatted = tickets.map(t => {
            // Find active unit for context
            const activeLease = t.user.leases[0];
            const unitInfo = activeLease
                ? `${activeLease.unit.property.name} - ${activeLease.unit.name}`
                : 'No Active Unit';

            return {
                id: `T-${t.id + 1000}`,
                dbId: t.id,
                tenant: t.user.name || 'Unknown',
                unit: unitInfo,
                subject: t.subject,
                priority: t.priority,
                status: t.status,
                desc: t.description,
                createdAt: t.createdAt.toLocaleString(),
                // Attachments mock
                attachments: [],
                tenantDetails: {
                    name: t.user.name,
                    property: activeLease ? activeLease.unit.property.name : 'N/A',
                    unit: activeLease ? activeLease.unit.name : 'N/A',
                    leaseStatus: activeLease ? activeLease.status : 'No Active Lease',
                    email: t.user.email,
                    phone: t.user.phone,
                }
            };
        });

        res.json(formatted);
    } catch (e) {
        console.error(e);
        res.status(500).json({ message: 'Server error' });
    }
};

// PUT /api/admin/tickets/:id/status
exports.updateTicketStatus = async (req, res) => {
    try {
        const { id } = req.params;
        const { status } = req.body;

        // Parse ID (T-1005 -> 5) if needed, but we passed dbId in list
        // If frontend passes "T-1005", we need to split. 
        // Let's assume frontend passes raw int ID or we handle it.
        // Actually the format in list is T-XXXX. Let's rely on receiving INT ID or parsing it.

        // Simpler: frontend sends the numeric ID if we provide it.
        // I provided `dbId` in the response above.

        const ticketId = parseInt(id);

        const updated = await prisma.ticket.update({
            where: { id: ticketId },
            data: { status }
        });

        res.json(updated);
    } catch (e) {
        console.error(e);
        res.status(500).json({ message: 'Server error' });
    }
};

// POST /api/admin/tickets (Admin creating ticket for tenant)
exports.createTicket = async (req, res) => {
    try {
        const { tenantId, subject, description, priority, propertyId, unitId } = req.body;

        // tenantId is user.id
        const newTicket = await prisma.ticket.create({
            data: {
                userId: parseInt(tenantId),
                subject,
                description,
                priority,
                status: 'Open',
                propertyId: propertyId ? parseInt(propertyId) : null,
                unitId: unitId ? parseInt(unitId) : null
            }
        });

        res.status(201).json(newTicket);
    } catch (e) {
        console.error(e);
        res.status(500).json({ message: 'Error creating ticket' });
    }
};
