using my.bookshop as my from '../db/data-model';

service CatalogService {
    @odata.draft.enabled
    entity Category as projection on my.Category;
}
