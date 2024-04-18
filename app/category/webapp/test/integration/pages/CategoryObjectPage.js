sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'category',
            componentId: 'CategoryObjectPage',
            entitySet: 'Category'
        },
        CustomPageDefinitions
    );
});