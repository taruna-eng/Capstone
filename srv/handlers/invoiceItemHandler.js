module.exports = function () {

    const { InvoiceItems, Invoices } = this.entities;

    //========================================
    // CREATE
    //========================================

    this.before("CREATE", InvoiceItems, async (req) => {

        const item = req.data;

        if (!item.description || item.description.trim() === "") {
            return req.error(400, "Line item description is required.");
        }

        if (item.quantity <= 0) {
            return req.error(400, "Quantity must be greater than zero.");
        }

        if (item.unitPrice <= 0) {
            return req.error(400, "Unit price must be greater than zero.");
        }

        item.totalAmount = Number(item.quantity) * Number(item.unitPrice);

    });

    this.after("CREATE", InvoiceItems, async (item) => {
        await updateInvoiceAmount(item.invoice_ID);
    });

    //========================================
    // UPDATE
    //========================================

    this.before("UPDATE", InvoiceItems, async (req) => {

        const item = req.data;

        if (
            item.quantity !== undefined &&
            item.unitPrice !== undefined
        ) {
            item.totalAmount =
                Number(item.quantity) * Number(item.unitPrice);
        }

    });

    this.after("UPDATE", InvoiceItems, async (item) => {
        await updateInvoiceAmount(item.invoice_ID);
    });

    //========================================
    // DELETE
    //========================================

    this.after("DELETE", InvoiceItems, async (item) => {
        await updateInvoiceAmount(item.invoice_ID);
    });

    //========================================
    // Helper Function
    //========================================

    async function updateInvoiceAmount(invoiceID) {

        const items = await SELECT.from(InvoiceItems)
            .where({ invoice_ID: invoiceID });

        let total = 0;

        for (const i of items) {
            total += Number(i.totalAmount);
        }

        await UPDATE(Invoices)
            .set({
                amount: total
            })
            .where({
                ID: invoiceID
            });

    }

};