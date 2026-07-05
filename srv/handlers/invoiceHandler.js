module.exports = function () {

    const { Vendors, Invoices } = this.entities;




    this.after("READ", "Invoices", (data) => {
         if (!data) return;


    const invoices = Array.isArray(data) ? data : [data];

    for (const invoice of invoices) {

        switch (invoice.status) {

            case "DRAFT":
                invoice.criticality = 0;
                break;

            case "SUBMITTED":
                invoice.criticality = 2;
                break;

            case "APPROVED":
                invoice.criticality = 3;
                break;

            case "REJECTED":
                invoice.criticality = 1;
                break;

            case "PAID":
                invoice.criticality = 5;
                break;

            default:
                invoice.criticality = 0;
        }

    }

});





















    this.before("READ", Invoices, async (req) => {

        // Admin can see all invoices
        if (req.user.is("Admin")) {
            return;
        }

        // Vendor Manager can only see invoices of assigned vendors
        if (req.user.is("VendorManager")) {

            const vendors = await SELECT.from(Vendors)
                .columns("ID")
                .where({
                    assignedManager: req.user.id
                });

            const vendorIds = vendors.map(v => v.ID);

            if (vendorIds.length === 0) {
                req.query.where({ ID: null });
                return;
            }

            req.query.where({
                vendor_ID: { in: vendorIds }
            });

        }

    });










    this.before("CREATE", Invoices, async (req) => {

        const data = req.data;

        // Vendor must exist
        const vendor = await SELECT.one.from(Vendors).where({
            ID: data.vendor_ID
        });

        if (!vendor) {
            return req.error(400, "Vendor does not exist.");
        }

        // Vendor must be approved
        if (vendor.status !== "APPROVED") {
            return req.error(400, "Please select an approved vendor.");
        }

        // Deleted vendor cannot create invoices
        if (vendor.status === "DELETED") {
            return req.error(400, "Deleted vendors cannot have new invoices created.");
        }

        // Amount validation
        if (data.amount <= 0 || data.amount > 1000000) {
            return req.error(
                400,
                "Amount must be between 0.01 and 1000000."
            );
        }

        // Invoice date validation
        const today = new Date();
        const invoiceDate = new Date(data.invoiceDate);

        if (invoiceDate > today) {
            return req.error(
                400,
                "Invoice date cannot be in the future."
            );
        }

        // Due date validation
        const dueDate = new Date(data.dueDate);

        if (dueDate < invoiceDate) {
            return req.error(
                400,
                "Due date must be on or after invoice date."
            );
        }

        // Invoice number unique per vendor
        const invoice = await SELECT.one.from(Invoices).where({
            invoiceNumber: data.invoiceNumber,
            vendor_ID: data.vendor_ID
        });

        if (invoice) {
            return req.error(
                400,
                `Invoice number ${data.invoiceNumber} already exists for this vendor.`
            );
        }

    });






    // ================================
    // UPDATE
    // ================================
    this.before("UPDATE", Invoices, async (req) => {

         // Fetch existing invoice
    const invoice = await SELECT.one
        .from(Invoices)
        .where({
            ID: req.data.ID
        });

    if (!invoice) {
        return req.error(404, "Invoice not found.");
    }

    // Only Draft invoices can be edited
    if (invoice.status !== "DRAFT") {
        return req.error(
            400,
            "Only Draft invoices can be edited."
        );
    }







        const data = req.data;

        if (data.invoiceDate && data.dueDate) {

            if (new Date(data.dueDate) < new Date(data.invoiceDate)) {
                return req.error(
                    400,
                    "Due date cannot be before invoice date."
                );
            }

        }

    });

    // ================================
    // DELETE
    // ================================
    this.before("DELETE", Invoices, async (req) => {

        const invoice = await SELECT.one
            .from(Invoices)
            .where({
                ID: req.data.ID
            });

        if (!invoice) {
            return req.error(404, "Invoice not found.");
        }

        if (invoice.status === "APPROVED") {
            return req.error(
                400,
                "Approved invoices cannot be deleted."
            );
        }

    });









};