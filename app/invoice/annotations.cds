using VendorInvoiceService as service from '../../srv/service';

annotate service.Invoices with @(

    UI.HeaderInfo : {
    TypeName : 'Invoice',
    TypeNamePlural : 'Invoices',

    Title : {
        $Type : 'UI.DataField',
        Value : invoiceNumber
    },

    Description : {
        Value : vendor.vendorName
    }
},


UI.Identification : [

    {
        $Type : 'UI.DataField',
        Label : 'Invoice Number',
        Value : invoiceNumber
    },

    {
        $Type : 'UI.DataField',
        Label : 'Status',
        Value : status
    },

    {
        $Type : 'UI.DataField',
        Label : 'Created By',
        Value : createdBy
    },

    {
        $Type : 'UI.DataField',
        Label : 'Created At',
        Value : createdAt
    }

],







    UI.SelectionFields : [
        invoiceNumber,
             vendor,
          status,
          invoiceDate,
          amount
    ],

    UI.PresentationVariant : {
        SortOrder : [
            {
                Property : invoiceDate,
                Descending : true
            }
        ]
    },

    UI.FieldGroup #GeneralInformation : {
        $Type : 'UI.FieldGroupType',
        Data : [

            {
                $Type : 'UI.DataField',
                Label : 'Invoice Number',
                Value : invoiceNumber
            },

            {
                $Type : 'UI.DataField',
                Label : 'Vendor',
                Value : vendor.vendorName
            },

            {
                $Type : 'UI.DataField',
                Label : 'Invoice Date',
                Value : invoiceDate
            },

            {
                $Type : 'UI.DataField',
                Label : 'Due Date',
                Value : dueDate
            },

            {
                $Type : 'UI.DataField',
                Label : 'Amount',
                Value : amount
            },

            {
                $Type : 'UI.DataField',
                Label : 'Currency',
                Value : currency
            },

            {
               $Type : 'UI.DataField',
                  Label : 'Status',
                  Value : status,
                 Criticality : criticality
            },

            {
                $Type : 'UI.DataField',
                Label : 'Created By',
                Value : createdBy
            },

            {
                $Type : 'UI.DataField',
                Label : 'Created At',
                Value : createdAt
            },

            {
                $Type : 'UI.DataField',
                Label : 'Approved By',
                Value : approvedBy
            },

            {
                $Type : 'UI.DataField',
                Label : 'Approved At',
                Value : approvedAt
            },

            {
                $Type : 'UI.DataField',
                Label : 'Approval Comments',
                Value : approvalComments
            },

            {
                $Type : 'UI.DataField',
                Label : 'Rejected By',
                Value : rejectedBy
            },

            {
                $Type : 'UI.DataField',
                Label : 'Rejected At',
                Value : rejectedAt
            },

            {
                $Type : 'UI.DataField',
                Label : 'Rejection Reason',
                Value : rejectionReason
            }

        ]
    },

    

    UI.HeaderFacets : [

    {
        $Type : 'UI.ReferenceFacet',
        Label : 'Invoice Summary',
        Target : '@UI.FieldGroup#GeneralInformation'
    }

],






    UI.Facets : [

        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneralInformation'
        },

        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Line Items',
            Target : 'items/@UI.LineItem'
        },

        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Attachments',
            Target : 'attachments/@UI.LineItem'
        },

        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Approval History',
            Target : 'approvalHistory/@UI.LineItem'
        }

    ],

  UI.LineItem : [

    {
        $Type : 'UI.DataField',
        Label : 'Invoice Number',
        Value : invoiceNumber
    },

    {
        $Type : 'UI.DataField',
        Label : 'Vendor',
        Value : vendor.vendorName
    },

    {
        $Type : 'UI.DataField',
        Label : 'Invoice Date',
        Value : invoiceDate
    },

    {
        $Type : 'UI.DataField',
        Label : 'Due Date',
        Value : dueDate
    },

    {
        $Type : 'UI.DataField',
        Label : 'Amount',
        Value : amount
    },

    {
        $Type : 'UI.DataField',
        Label : 'Currency',
        Value : currency
    },

    {
        $Type : 'UI.DataField',
    Label : 'Status',
    Value : status,
    Criticality : criticality
    }

],
);

annotate service.Invoices with {

    vendor @Common.ValueList : {

        $Type : 'Common.ValueListType',

        CollectionPath : 'Vendors',

        Parameters : [

            {
                $Type : 'Common.ValueListParameterInOut',
                LocalDataProperty : vendor_ID,
                ValueListProperty : 'ID'
            },

            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'vendorCode'
            },

            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'vendorName'
            },

            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'country'
            },

            {
                $Type : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty : 'currency'
            }

        ]
    };

};

annotate service.InvoiceItems with @(

    UI.LineItem : [

        {
            $Type : 'UI.DataField',
            Label : 'Description',
            Value : description
        },

        {
            $Type : 'UI.DataField',
            Label : 'Quantity',
            Value : quantity
        },

        {
            $Type : 'UI.DataField',
            Label : 'Unit Price',
            Value : unitPrice
        },

        {
            $Type : 'UI.DataField',
            Label : 'Total Amount',
            Value : totalAmount
        }

    ]

);

annotate service.Attachments with @(

    UI.LineItem : [

        {
            $Type : 'UI.DataField',
            Label : 'File Name',
            Value : fileName
        },

        {
            $Type : 'UI.DataField',
            Label : 'File Size',
            Value : fileSize
        },

        {
            $Type : 'UI.DataField',
            Label : 'Uploaded By',
            Value : uploadedBy
        },

        {
            $Type : 'UI.DataField',
            Label : 'Uploaded At',
            Value : uploadedAt
        }

    ]

);
annotate service.ApprovalHistory with @(

    UI.LineItem : [

        {
            $Type : 'UI.DataField',
            Label : 'Action',
            Value : action
        },

        {
            $Type : 'UI.DataField',
            Label : 'Actor',
            Value : actor
        },

        {
            $Type : 'UI.DataField',
            Label : 'Action Date',
            Value : actionDate
        },

        {
            $Type : 'UI.DataField',
            Label : 'Comments',
            Value : comments
        }

    ]

);

