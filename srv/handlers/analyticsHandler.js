const cds = require('@sap/cds');

module.exports = function () {

    const { Invoices, Vendors } = this.entities;

    this.on("READ", "InvoiceAnalytics", async () => {

        const invoices = await SELECT.from(Invoices);
        const vendors = await SELECT.from(Vendors);

        const analytics = [];

        for (const vendor of vendors) {

            const vendorInvoices = invoices.filter(
                i => i.vendor_ID === vendor.ID
            );

            analytics.push({

                ID: cds.utils.uuid(),

                vendorName: vendor.vendorName,

                totalInvoices: vendorInvoices.length,

                draftCount:
                    vendorInvoices.filter(i => i.status === "DRAFT").length,

                submittedCount:
                    vendorInvoices.filter(i => i.status === "SUBMITTED").length,

                approvedCount:
                    vendorInvoices.filter(i => i.status === "APPROVED").length,

                rejectedCount:
                    vendorInvoices.filter(i => i.status === "REJECTED").length,

                totalAmount:
                    vendorInvoices.reduce(
                        (sum, i) => sum + Number(i.amount),
                        0
                    ),

                currency: vendor.currency

            });

        }

        return analytics;

    });



this.on("READ", "DashboardKPIs", async () => {

    const invoices = await SELECT.from(Invoices);

    const totalInvoices = invoices.length;

    const totalAmount = invoices.reduce(
        (sum, i) => sum + Number(i.amount),
        0
    );

    const pendingApprovals = invoices.filter(
        i => i.status === "SUBMITTED"
    ).length;

    const rejectedInvoices = invoices.filter(
        i => i.status === "REJECTED"
    ).length;

    return [{
        ID: cds.utils.uuid(),

        totalInvoices,

        totalAmount,

        pendingApprovals,

        rejectedInvoices,

        invoiceTrend: 12.5,

        defaultCurrency: "INR"
    }];

});










};