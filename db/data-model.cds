namespace my.bookshop;

entity Books {
  key ID            : Integer @title: 'ID';
      title         : String  @title: 'Title';
      stock         : Integer @title: 'Stock';
      //
      category_code : String  @title: 'Category Code';
}

@assert.unique: {code: [code]}
entity Category {
  key ID          : Integer      @title: 'ID';
      code        : String(1)    @title: 'Code';
      description : String(1024) @title: 'Description';
}
