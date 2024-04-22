using my.bookshop as my from '../db/data-model';

/**
 * for readonly entities.
 */
service CatalogServiceRo {
    @readonly
    @Aggregation.ApplySupported
    @Aggregation.CustomAggregate #stock: 'Edm.Int32'
    entity Books as
        projection on my.Books {
            *,
            @Analytics.Measure  : true
            @Aggregation.default: #SUM
            stock
        };
}
