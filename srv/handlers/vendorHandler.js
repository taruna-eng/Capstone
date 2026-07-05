module.exports = function () {

    const { Vendors,Invoices} = this.entities;

    //========================================
    // CREATE Vendor
    //========================================




      this.before("READ", Vendors, async (req) => {

        // Admin can see all vendors
        if (req.user.is("Admin")) {
            return;
        }

        // Vendor Manager can only see assigned vendors
        if (req.user.is("VendorManager")) {

            req.query.where({
                assignedManager: req.user.id
            });

        }

    });














    this.before("CREATE", Vendors, async (req) => {

        const data = req.data;
        // Duplicate Vendor Code
const existing = await SELECT.one
    .from(Vendors)
    .where({
        vendorCode: data.vendorCode
    });

if (existing) {
    return req.error(
        400,
        "Vendor code already exists."
    );
}


    // Email Validation
const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

if (data.email && !emailRegex.test(data.email)) {
    return req.error(
        400,
        "Invalid email address."
    );
}

// Phone Validation
if (data.phone && data.phone.length < 8) {
    return req.error(
        400,
        "Invalid phone number."
    );
}

        









        // Vendor Name Mandatory
        if (!data.vendorName || data.vendorName.trim() === "") {
            return req.error(400, "Vendor name is required.");
        }

        // Currency Mandatory
        if (!data.currency) {
            return req.error(400, "Currency is required.");
        }

        // Country Mandatory
        if (!data.country) {
            return req.error(400, "Country is required.");
        }

        // Default Status
        if (!data.status) {
            data.status = "PENDING";
        }

    });

    //========================================
    // UPDATE Vendor
    //========================================

    this.before("UPDATE", Vendors, async (req) => {
      const vendor = await SELECT.one
        .from(Vendors)
        .where({ ID: req.data.ID });

    if (!vendor) {
        return req.error(404, "Vendor not found.");
    }

    if (vendor.status === "DELETED") {
        return req.error(
            400,
            "Deleted vendors cannot be modified."
        );
    }

});

    //========================================
    // DELETE Vendor (Soft Delete)
    //========================================

    this.on("DELETE", Vendors, async (req) => {

        const { ID } = req.data;

        const vendor = await SELECT.one
            .from(Vendors)
            .where({ ID });

            const invoices = await SELECT
    .from(Invoices)
    .where({
        vendor_ID: ID
    });

if (invoices.length > 0) {
    return req.error(
        400,
        "Vendor has invoices and cannot be deleted."
    );
}

        if (!vendor) {
            return req.error(404, "Vendor not found.");
        }

        await UPDATE(Vendors)
            .set({
                status: "DELETED"
            })
            .where({ ID });

        return {
            message: "Vendor deleted successfully."
        };

    });

};