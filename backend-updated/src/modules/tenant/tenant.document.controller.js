const prisma = require('../../config/prisma');

// GET /api/tenant/documents
exports.getDocuments = async (req, res) => {
    try {
        const userId = req.user.id;
        const documents = await prisma.document.findMany({
            where: { userId }
        });

        const formatted = documents.map(d => ({
            id: d.id,
            name: d.name,
            type: d.type,
            date: d.createdAt.toISOString().split('T')[0]
        }));

        res.json(formatted);
    } catch (e) {
        console.error(e);
        res.status(500).json({ message: 'Server error' });
    }
};

// POST /api/tenant/documents
exports.uploadDocument = async (req, res) => {
    try {
        const userId = req.user.id;
        const { name, type } = req.body;

        // Mock file upload handling (in real app, use multer/S3)
        // We just create the record
        const newDoc = await prisma.document.create({
            data: {
                userId,
                name,
                type,
                fileUrl: 'https://example.com/mock-doc.pdf', // Mock URL
                expiryDate: null // Optional
            }
        });

        res.status(201).json({
            id: newDoc.id,
            name: newDoc.name,
            type: newDoc.type,
            date: newDoc.createdAt.toISOString().split('T')[0]
        });

    } catch (e) {
        console.error(e);
        res.status(500).json({ message: 'Error' });
    }
};
