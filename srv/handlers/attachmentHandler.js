module.exports = function () {

    const { Attachments, Invoices } = this.entities;

    this.before("CREATE", Attachments, async (req) => {

        const attachment = req.data;

        // Allowed file types
        const allowedTypes = [
            "application/pdf",
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
            "image/png",
            "image/jpeg"
        ];

        if (!allowedTypes.includes(attachment.mediaType)) {
            return req.error(
                400,
                "Only PDF, DOCX, XLSX, PNG and JPG files are allowed."
            );
        }

        // Maximum 5 MB
        if (attachment.fileSize > 5 * 1024 * 1024) {
            return req.error(
                400,
                "Maximum file size allowed is 5 MB."
            );
        }

        // Invoice must exist
        const invoice = await SELECT.one
            .from(Invoices)
            .where({
                ID: attachment.invoice_ID
            });

        if (!invoice) {
            return req.error(
                404,
                "Invoice not found."
            );
        }

        // Upload allowed only in DRAFT and SUBMITTED
        if (
            invoice.status !== "DRAFT" &&
            invoice.status !== "SUBMITTED"
        ) {
            return req.error(
                400,
                "Attachments can only be uploaded for Draft or Submitted invoices."
            );
        }

    });



        this.before("DELETE", Attachments, async (req) => {

        const attachment = await SELECT.one
            .from(Attachments)
            .where({
                ID: req.data.ID
            });

            if (!attachment) {
    return req.error(404, "Attachment not found.");
}

            const invoice = await SELECT.one
    .from(Invoices)
    .where({
        ID: attachment.invoice_ID
    });

if (invoice.status !== "DRAFT") {
    return req.error(
        400,
        "Attachments can only be deleted while invoice is in Draft status."
    );
}

        if (!attachment) {
            return req.error(404, "Attachment not found.");
        }

        if (attachment.uploadedBy !== req.user.id) {
            return req.error(
                403,
                "Only uploader can delete attachment."
            );
        }

    });

    







};