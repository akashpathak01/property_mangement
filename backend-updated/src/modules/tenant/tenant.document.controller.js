const prisma = require('../../config/prisma');

const path = require('path');
const fs = require('fs');

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

// GET /api/tenant/documents/:id/file
exports.getDocumentFile = async (req, res) => {
    try {
        const userId = req.user.id;
        const userRole = req.user.role;
        const docId = parseInt(req.params.id);

        const doc = await prisma.document.findUnique({
            where: { id: docId }
        });

        if (!doc) {
            return res.status(404).json({ message: 'Document not found' });
        }

        // Security Check: Only Owner or Admin
        if (doc.userId !== userId && userRole !== 'ADMIN') {
            return res.status(403).json({ message: 'Unauthorized access' });
        }

        // Construct absolute path
        // Database stores '/uploads/filename', we need system path
        // Assume fileUrl starts with '/uploads/'
        const relativePath = doc.fileUrl.startsWith('/') ? doc.fileUrl.slice(1) : doc.fileUrl; // removes leading slash
        const filePath = path.resolve(__dirname, '../../../../', relativePath);

        if (!fs.existsSync(filePath)) {
            return res.status(404).json({ message: 'File not found on server' });
        }

        // Action: View or Download
        const action = req.query.action || 'view';
        if (action === 'download') {
            res.download(filePath, doc.name); // Send with original friendly name
        } else {
            res.sendFile(filePath);
        }

    } catch (e) {
        console.error('File Access Error:', e);
        res.status(500).json({ message: 'Error retrieving file' });
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
