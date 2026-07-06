using { vendor.invoice.management as db } from '../db/schema';

@requires: 'authenticated-user'
service VendorInvoiceService {

   
    entity Vendors as projection on db.Vendors;


   



@odata.draft.enabled
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


   
    entity InvoiceItems as projection on db.InvoiceItems;


   
    entity Attachments as projection on db.Attachments;

    @readonly
entity DashboardKPIs as projection on db.DashboardKPIs;


    @readonly
   
    entity ApprovalHistory as projection on db.ApprovalHistory;


    @readonly
    
    entity InvoiceAnalytics as projection on db.InvoiceAnalytics;


    @requires: 'Admin'
    action SyncVendors() returns String;

}