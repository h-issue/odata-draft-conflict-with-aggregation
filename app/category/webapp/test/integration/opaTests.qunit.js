sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'category/test/integration/FirstJourney',
		'category/test/integration/pages/CategoryList',
		'category/test/integration/pages/CategoryObjectPage'
    ],
    function(JourneyRunner, opaJourney, CategoryList, CategoryObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('category') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheCategoryList: CategoryList,
					onTheCategoryObjectPage: CategoryObjectPage
                }
            },
            opaJourney.run
        );
    }
);