using { vendor.invoice.management as db } from '../db/schema';
@requires: 'authenticated-user'
service VendorInvoiceService {

    

  
    entity Vendors as projection on db.Vendors;
     
    

    entity Invoices as projection on db.Invoices

     actions {

     
action submitForApproval() returns String;

action approveInvoice(
    comments : String
) returns String;


action rejectInvoice(
    reason : String
) returns String;
     };

     
    





    entity InvoiceItems as projection on db.InvoiceItems;
    
    

    entity Attachments as projection on db.Attachments;




    entity ApprovalHistory as projection on db.ApprovalHistory;
      @readonly
    
    entity InvoiceAnalytics as projection on db.InvoiceAnalytics;
     @requires: 'Admin'
    action SyncVendors() returns String;
    


}