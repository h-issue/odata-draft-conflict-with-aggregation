using my.bookshop as my from '../db/data-model';

service CatalogService {
    @readonly
    @Aggregation.ApplySupported
    @Aggregation.CustomAggregate #stock: 'Edm.Int32'
    entity Books    as
        projection on my.Books {
            *,
            @Analytics.Measure  : true
            @Aggregation.default: #SUM
            stock
        };

    @odata.draft.enabled
    entity Category as projection on my.Category;
}
