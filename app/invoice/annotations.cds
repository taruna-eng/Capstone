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
    },

    {
        $Type : 'UI.DataFieldForAction',
        Action : 'VendorInvoiceService.submitForApproval',
        Label : 'Submit for Approval',
        InvocationGrouping : #Isolated
    },

    {
        $Type : 'UI.DataFieldForAction',
        Action : 'VendorInvoiceService.approveInvoice',
        Label : 'Approve',
        InvocationGrouping : #Isolated
    },

    {
        $Type : 'UI.DataFieldForAction',
        Action : 'VendorInvoiceService.rejectInvoice',
        Label : 'Reject',
        InvocationGrouping : #Isolated
    }


],







    UI.SelectionFields : [
        invoiceNumber,
          status,
          invoiceDate,
          amount,
        vendor.vendorName,
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
                Value : amount,
                Label : 'amount',
            },
            {
                $Type : 'UI.DataField',
                Value : dueDate,
                Label : 'dueDate',
            },
            {
                $Type : 'UI.DataField',
                Value : invoiceDate,
                Label : 'invoiceDate',
            },
            {
                $Type : 'UI.DataField',
                Value : currency,
                Label : 'currency',
            },
            {
                $Type : 'UI.DataField',
                Value : status,
                Label : 'status',
            },

        ]
    },

    

    UI.HeaderFacets : [

    {
        $Type : 'UI.ReferenceFacet',
        Label : 'Invoice Summary',
        Target : '@UI.FieldGroup#GeneralInformation'
    },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Status',
            ID : 'Status',
            Target : '@UI.FieldGroup#Status1',
        },

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
    UI.FieldGroup #Status : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : vendor.status,
                Label : 'status',
                Criticality : criticality,
            },
        ],
    },
    UI.FieldGroup #Status1 : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : status,
                Label : 'status',
                Criticality : criticality,
            },
        ],
    },
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

annotate service.Invoices with {
    status @(
        Common.FieldControl : #ReadOnly,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Vendors',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : status,
                    ValueListProperty : 'status',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Invoices with {
    currency @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Vendors',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : currency,
                    ValueListProperty : 'currency',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
)};

annotate service.Vendors with {
    vendorName @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Vendors',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : vendorName,
                    ValueListProperty : 'vendorName',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
        Common.Label : 'Vendor',
)};

