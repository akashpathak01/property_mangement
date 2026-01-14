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
            fileUrl: d.fileUrl,
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

        if (!req.file) {
            return res.status(400).json({ message: 'No file uploaded' });
        }

        // Create document record with real file path
        // We store the relative path: /uploads/filename
        const fileUrl = `/uploads/${req.file.filename}`;

        const newDoc = await prisma.document.create({
            data: {
                userId,
                name: name || req.file.originalname,
                type: type || 'Other',
                fileUrl: fileUrl,
                expiryDate: null
            }
        });

        res.status(201).json({
            id: newDoc.id,
            name: newDoc.name,
            type: newDoc.type,
            fileUrl: newDoc.fileUrl,
            date: newDoc.createdAt.toISOString().split('T')[0]
        });

    } catch (e) {
        console.error(e);
        res.status(500).json({ message: 'Error uploading document' });
    }
};
