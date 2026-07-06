using VendorInvoiceService as service from '../../srv/service';
annotate service.Vendors with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'vendorCode',
                Value : vendorCode,
            },
            {
                $Type : 'UI.DataField',
                Label : 'vendorName',
                Value : vendorName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'email',
                Value : email,
            },
            {
                $Type : 'UI.DataField',
                Label : 'phone',
                Value : phone,
            },
            {
                $Type : 'UI.DataField',
                Label : 'address',
                Value : address,
            },
            {
                $Type : 'UI.DataField',
                Label : 'city',
                Value : city,
            },
            {
                $Type : 'UI.DataField',
                Label : 'state',
                Value : state,
            },
            {
                $Type : 'UI.DataField',
                Label : 'country',
                Value : country,
            },
            {
                $Type : 'UI.DataField',
                Label : 'postalCode',
                Value : postalCode,
            },
            {
                $Type : 'UI.DataField',
                Label : 'currency',
                Value : currency,
            },
            {
                $Type : 'UI.DataField',
                Label : 'taxId',
                Value : taxId,
            },
            {
                $Type : 'UI.DataField',
                Label : 'externalVendorId',
                Value : externalVendorId,
            },
            {
                $Type : 'UI.DataField',
                Label : 'assignedManager',
                Value : assignedManager,
            },
            {
                $Type : 'UI.DataField',
                Label : 'status',
                Value : status,
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
            Label : 'email',
            Value : email,
        },
        {
            $Type : 'UI.DataField',
            Label : 'phone',
            Value : phone,
        },
         {
        $Type : 'UI.DataField',
        Label : 'Tax ID',
        Value : taxId
    },

     {
        $Type : 'UI.DataField',
        Label : 'Country',
        Value : country
    },

    {
        $Type : 'UI.DataField',
        Label : 'Currency',
        Value : currency
    },
     {
        $Type : 'UI.DataField',
        Label : 'Status',
        Value : status
    }


       
    ],


    

    UI.PresentationVariant #Default: {
    SortOrder : [
        {
            Property : vendorName,
            Descending : false
        }
    ]
},

UI.SelectionPresentationVariant : {
    PresentationVariant : '@UI.PresentationVariant#Default'
}









);

