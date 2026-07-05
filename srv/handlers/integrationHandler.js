module.exports = function () {

    const { Vendors } = this.entities;

    this.on("SyncVendors", async (req) => {

        if (!req.user.is("Admin")) {
    return req.error(
        403,
        "Only Admin can synchronize vendors."
    );
}

 let created = 0;

        let updated = 0;
            let vendors = [];
        // This is mock data.
        // Later we'll replace this with S/4HANA API.
        try{

         vendors = [

            {
                vendorCode: "S4001",
                vendorName: "SAP Supplier One",
                email: "supplier1@sap.com",
                phone: "+91-900000001",
                country: "India",
                currency: "INR",
                taxId: "GST10001",
                status: "PENDING"
            },

            {
                vendorCode: "S4002",
                vendorName: "SAP Supplier Two",
                email: "supplier2@sap.com",
                phone: "+91-900000002",
                country: "Germany",
                currency: "EUR",
                taxId: "GST10002",
                status: "PENDING"
            }

        ];

       
    }catch (error) {
        return req.error(
            500,
            `Error fetching vendors from S/4HANA: ${error.message}`
        );
    }

for (const vendor of vendors) {

    const existing = await SELECT.one
        .from(Vendors)
        .where({
            vendorCode: vendor.vendorCode
        });

    if (existing) {

        await UPDATE(Vendors)
            .set({
                vendorName: vendor.vendorName,
                email: vendor.email,
                phone: vendor.phone,
                country: vendor.country,
                currency: vendor.currency,
                taxId: vendor.taxId,
                status: vendor.status
            })
            .where({
                ID: existing.ID
            });

        updated++;

    } else {

        await INSERT.into(Vendors).entries(vendor);

        created++;

    }

}






        return `Vendor Sync Completed.
Created: ${created}
Updated: ${updated}`;

    });

};