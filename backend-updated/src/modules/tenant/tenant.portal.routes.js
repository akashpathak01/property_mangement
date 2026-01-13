const express = require("express");
const router = express.Router();
const tenantPortalController = require("./tenant.portal.controller");
const tenantLeaseController = require("./tenant.lease.controller");
const tenantDocumentController = require("./tenant.document.controller");
const tenantTicketController = require("./tenant.ticket.controller");
const tenantInvoiceController = require("./tenant.invoice.controller");
const tenantPaymentController = require("./tenant.payment.controller");
const upload = require("../../middlewares/upload.middleware");
const {
  authenticate,
  authorize,
} = require("../../middlewares/auth.middleware");

// Protect all tenant portal routes
router.use(authenticate);
router.use(authorize("TENANT"));

router.get("/dashboard", tenantPortalController.getDashboard);
router.get("/lease", tenantLeaseController.getLeaseDetails);
router.get("/documents", tenantDocumentController.getDocuments);
router.get("/documents/:id/file", tenantDocumentController.getDocumentFile);
router.post("/documents", upload.single('file'), tenantDocumentController.uploadDocument);

router.get("/tickets", tenantTicketController.getTickets);
router.post("/tickets", tenantTicketController.createTicket);

router.get("/invoices", tenantInvoiceController.getInvoices);
router.post("/pay", tenantPaymentController.processPayment);

module.exports = router;
