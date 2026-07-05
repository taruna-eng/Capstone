module.exports = function () {

    const {
        Invoices,
        InvoiceItems,
        ApprovalHistory
    } = this.entities;

    this.on("submitForApproval", Invoices, async (req) => {
        // Only Admin or Vendor Manager can submit
if (!req.user.is("Admin") && !req.user.is("VendorManager")) {
    return req.error(
        403,
        "You are not authorized to submit invoices."
    );
}

        const { ID } = req.params[0];

        // Read Invoice
        const invoice = await SELECT.one
            .from(Invoices)
            .where({ ID });

        if (!invoice.invoiceNumber ||
    !invoice.invoiceDate ||
    !invoice.dueDate ||
    !invoice.amount ||
    !invoice.vendor_ID) {
           return req.error(
        400,
        "Please fill all mandatory fields before submission."
    );
        }

        // Only Draft invoices
        if (invoice.status !== "DRAFT") {
            return req.error(400, "Only draft invoices can be submitted.");
        }

        // Fetch Line Items
        const items = await SELECT.from(InvoiceItems)
            .where({ invoice_ID: ID });

        if (items.length === 0) {
            return req.error(400, "Invoice must have at least one line item.");
        }

        // Calculate Total
        let total = 0;

        for (const item of items) {
            total += Number(item.totalAmount);
        }

        if (total !== Number(invoice.amount)) {
            return req.error(
                400,
                `Line items total (${total}) does not match invoice amount (${invoice.amount}).`
            );
        }

        // Update Invoice
        await UPDATE(Invoices)
            .set({
                status: "SUBMITTED",
                submittedBy: req.user.id,
                submittedAt: new Date()
            })
            .where({ ID });

        // Approval History
        await INSERT.into(ApprovalHistory).entries({

            invoice_ID: ID,

            action: "SUBMITTED",

            actor: req.user.id,

            comments: "Invoice submitted for approval",

            actionDate: new Date()

        });

        return "Invoice submitted successfully.";

    });


    //=====================================================
// Approve Invoice
//=====================================================

this.on("approveInvoice", Invoices, async (req) => {
    // Only Approver can approve
if (!req.user.is("Approver")) {
    return req.error(
        403,
        "Only Approvers can approve invoices."
    );
}

    const { ID } = req.params[0];
    const { comments } = req.data;

    const invoice = await SELECT.one
        .from(Invoices)
        .where({ ID });

    if (!invoice) {
        return req.error(404, "Invoice not found.");
    }

    // Only submitted invoices
    if (invoice.status !== "SUBMITTED") {
        return req.error(
            400,
            "Only submitted invoices can be approved."
        );
    }

    // User cannot approve own invoice
    if (invoice.submittedBy === req.user.id) {
        return req.error(
            400,
            "You cannot approve your own submitted invoice."
        );
    }

    await UPDATE(Invoices)
        .set({

            status: "APPROVED",

            approvedBy: req.user.id,

            approvedAt: new Date(),

            approvalComments: comments || "Invoice approved"

        })
        .where({ ID });

    await INSERT.into(ApprovalHistory).entries({

        invoice_ID: ID,

        action: "APPROVED",

        actor: req.user.id,

        comments: comments || "Invoice approved",

        actionDate: new Date()

    });

    return "Invoice approved successfully.";

});


//=============================================

//=====================================================
// Reject Invoice
//=====================================================

this.on("rejectInvoice", Invoices, async (req) => {
    // Only Approver can reject
if (!req.user.is("Approver")) {
    return req.error(
        403,
        "Only Approvers can reject invoices."
    );
}

    const { ID } = req.params[0];

    const { reason } = req.data;

    const invoice = await SELECT.one
        .from(Invoices)
        .where({ ID });

    if (!invoice) {
        return req.error(404, "Invoice not found.");
    }

    if (invoice.status !== "SUBMITTED") {
        return req.error(
            400,
            "Only submitted invoices can be rejected."
        );
    }

    if (!reason || reason.trim() === "") {

        return req.error(
            400,
            "Rejection reason is mandatory."
        );

    }

    await UPDATE(Invoices)
        .set({

            status: "REJECTED",

            rejectedBy: req.user.id,

            rejectedAt: new Date(),

            rejectionReason: reason

        })
        .where({ ID });

    await INSERT.into(ApprovalHistory).entries({

        invoice_ID: ID,

        action: "REJECTED",

        actor: req.user.id,

        comments: reason,

        actionDate: new Date()

    });

    return "Invoice rejected successfully.";

});














};