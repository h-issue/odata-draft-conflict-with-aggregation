using CatalogServiceRo as service from '../../srv/cat-service-ro';

annotate service.Books with @(UI.LineItem: [
    {
        $Type: 'UI.DataField',
        Value: ID,
    },
    {
        $Type: 'UI.DataField',
        Value: category_code,
    },
    {
        $Type: 'UI.DataField',
        Value: title,
    },
    {
        $Type: 'UI.DataField',
        Value: stock,
    },
]);
