using VendorInvoiceService as service from '../../srv/service';
annotate service.InvoiceAnalytics with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'vendorName',
                Value : vendorName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'totalInvoices',
                Value : totalInvoices,
            },
            {
                $Type : 'UI.DataField',
                Label : 'draftCount',
                Value : draftCount,
            },
            {
                $Type : 'UI.DataField',
                Label : 'submittedCount',
                Value : submittedCount,
            },
            {
                $Type : 'UI.DataField',
                Label : 'approvedCount',
                Value : approvedCount,
            },
            {
                $Type : 'UI.DataField',
                Label : 'rejectedCount',
                Value : rejectedCount,
            },
            {
                $Type : 'UI.DataField',
                Label : 'totalAmount',
                Value : totalAmount,
            },
            {
                $Type : 'UI.DataField',
                Label : 'currency',
                Value : currency,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneratedFacet1',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneratedGroup',
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'vendorName',
            Value : vendorName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'totalInvoices',
            Value : totalInvoices,
        },
        {
            $Type : 'UI.DataField',
            Label : 'draftCount',
            Value : draftCount,
        },
        {
            $Type : 'UI.DataField',
            Label : 'submittedCount',
            Value : submittedCount,
        },
        {
            $Type : 'UI.DataField',
            Label : 'approvedCount',
            Value : approvedCount,
        },
    ],
);

