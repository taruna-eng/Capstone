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
        Value : status,
        Criticality : criticality,
    }


       
    ],
    UI.SelectionFields : [
        status,
        country,
        currency,
        vendorName,
    ],




);


// Add this below the above block
annotate service.Vendors with @(
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Label : 'Sync from S/4HANA',
            Action : 'VendorInvoiceService.SyncVendors'
        }
    ]
);








annotate service.Vendors with {
    status @(
        Common.Label : 'status',
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

annotate service.Vendors with {
    country @(
        Common.Label : 'country',
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Vendors',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : country,
                    ValueListProperty : 'country',
                },
            ],
        },
        Common.ValueListWithFixedValues : true,
    )
};

annotate service.Vendors with {
    currency @(
        Common.Label : 'currency',
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
    )
};

