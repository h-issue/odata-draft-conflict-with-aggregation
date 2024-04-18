using CatalogService as service from '../../srv/cat-service';

annotate service.Category with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : ID,
        },
        {
            $Type : 'UI.DataField',
            Value : code,
        },
        {
            $Type : 'UI.DataField',
            Value : description,
        },
    ]
);
annotate service.Category with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General',
            ID : 'General',
            Target : '@UI.FieldGroup#General',
        },
    ],
    UI.FieldGroup #General : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : ID,
            },{
                $Type : 'UI.DataField',
                Value : code,
            },{
                $Type : 'UI.DataField',
                Value : description,
            },],
    }
);
