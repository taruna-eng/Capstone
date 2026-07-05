namespace vendor.invoice.management;

using { cuid, managed } from '@sap/cds/common';

type VendorStatus : String enum {
    PENDING;
    APPROVED;
    SUSPENDED;
    DELETED;
}

type InvoiceStatus : String enum {
    DRAFT;
    SUBMITTED;
    APPROVED;
    REJECTED;
    PAID;
}

type ApprovalAction : String enum {
    SUBMITTED;
    APPROVED;
    REJECTED;
}


entity Vendors :  managed {
    Key ID: String(20);

    vendorCode       : String(20);

    vendorName       : String(100);

    email            : String(100);

    phone            : String(20);

    address          : String(255);

    city             : String(50);

    state            : String(50);

    country          : String(50);

    postalCode       : String(15);

    currency         : String(3);

    taxId            : String(30);

    externalVendorId : String(50);

    assignedManager  : String(100);

    status           : VendorStatus default #PENDING;

    invoices         : Association to many Invoices
                           on invoices.vendor = $self;

}


entity Invoices :managed {
    key ID: String(36);

    invoiceNumber      : String(30);

    vendor             : Association to Vendors;

    invoiceDate        : Date;

    dueDate            : Date;

    amount             : Decimal(15,2);

    currency           : String(3);

    status             : InvoiceStatus default #DRAFT;

    submittedBy        : String(100);

    criticality        : Integer @Core.Computed;

    submittedAt        : Timestamp;

    approvedBy         : String(100);

    approvedAt         : Timestamp;

    approvalComments   : String(500);

    rejectedBy         : String(100);

    rejectedAt         : Timestamp;

    rejectionReason    : String(500);

    items              : Composition of many InvoiceItems
                             on items.invoice = $self;

    attachments        : Composition of many Attachments
                             on attachments.invoice = $self;

    approvalHistory    : Composition of many ApprovalHistory
                             on approvalHistory.invoice = $self;

}


entity InvoiceItems : cuid, managed {

    invoice       : Association to Invoices;

    lineNumber    : Integer;

    description   : String(255);

    quantity      : Decimal(13,2);

    unitPrice     : Decimal(15,2);

    totalAmount   : Decimal(15,2);

}

entity Attachments : cuid, managed {

    invoice      : Association to Invoices;

    fileName     : String(255);

    mediaType    : String(100);

    fileSize     : Integer;

    uploadedBy   : String(100);

    uploadedAt   : Timestamp;

}

entity ApprovalHistory : cuid, managed {

    invoice      : Association to Invoices;

    action       : ApprovalAction;

    actor        : String(100);

    comments     : String(500);

    actionDate   : Timestamp;
}


  @cds.persistence.skip
entity InvoiceAnalytics {

    key ID             : UUID;

    vendorName         : String(100);

    totalInvoices      : Integer;

    draftCount         : Integer;

    submittedCount     : Integer;

    approvedCount      : Integer;

    rejectedCount      : Integer;

    totalAmount        : Decimal(15,2);

    currency           : String(3);

}


    
