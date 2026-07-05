module.exports = function () {

    const entities = [
        this.entities.Vendors,
        this.entities.Invoices,
        this.entities.InvoiceItems,
        this.entities.Attachments,
        this.entities.ApprovalHistory
    ];

    for (const entity of entities) {

        this.before("CREATE", entity, req => {

            req.data.createdAt = new Date();
            req.data.createdBy = req.user.id;

            req.data.modifiedAt = new Date();
            req.data.modifiedBy = req.user.id;

        });

        this.before("UPDATE", entity, req => {

            req.data.modifiedAt = new Date();
            req.data.modifiedBy = req.user.id;

        });

    }

};