using { vendor.invoice.management as db } from '../db/schema';

@requires: 'authenticated-user'
service VendorInvoiceService {

    @restrict: [
        { grant: ['READ','CREATE','UPDATE','DELETE'], to: 'Admin' },
        { grant: ['READ','CREATE','UPDATE'], to: 'VendorManager' },
        { grant: ['READ'], to: ['Approver','Viewer'] }
    ]
    entity Vendors as projection on db.Vendors;


    @restrict: [
        { grant: ['READ','CREATE','UPDATE','DELETE'], to: 'Admin' },
    { grant: ['READ','CREATE','UPDATE'], to: 'VendorManager' },
    { grant: ['READ'], to: ['Approver','Viewer'] },
    { grant: 'approveInvoice', to: 'Approver' },
    { grant: 'rejectInvoice', to: 'Approver' }
    ]



    @Capabilities.InsertRestrictions.Insertable : true
@Capabilities.UpdateRestrictions.Updatable : true
@Capabilities.DeleteRestrictions.Deletable : true
    entity Invoices as projection on db.Invoices

    actions {

        @requires: ['Admin','VendorManager']
        action submitForApproval() returns String;

        @requires: ['Admin','Approver']
        action approveInvoice(
            comments : String
        ) returns String;

        @requires: ['Admin','Approver']
        action rejectInvoice(
            reason : String
        ) returns String;
    };


    @restrict: [
        { grant: ['READ','CREATE','UPDATE','DELETE'], to: 'Admin' },
        { grant: ['READ','CREATE','UPDATE'], to: 'VendorManager' },
        { grant: ['READ'], to: ['Approver','Viewer'] }
    ]
    entity InvoiceItems as projection on db.InvoiceItems;


    @restrict: [
        { grant: ['READ','CREATE','UPDATE','DELETE'], to: 'Admin' },
        { grant: ['READ','CREATE','UPDATE'], to: 'VendorManager' },
        { grant: ['READ'], to: ['Approver','Viewer'] }
    ]
    entity Attachments as projection on db.Attachments;


    @readonly
    @restrict: [
        { grant: ['READ'], to: ['Admin','VendorManager','Approver','Viewer'] }
    ]
    entity ApprovalHistory as projection on db.ApprovalHistory;


    @readonly
    @restrict: [
        { grant: ['READ'], to: ['Admin','VendorManager','Approver','Viewer'] }
    ]
    entity InvoiceAnalytics as projection on db.InvoiceAnalytics;


    @requires: 'Admin'
    action SyncVendors() returns String;

}