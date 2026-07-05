sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"vendor/test/integration/pages/VendorsList",
	"vendor/test/integration/pages/VendorsObjectPage"
], function (JourneyRunner, VendorsList, VendorsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('vendor') + '/test/flp.html#app-preview',
        pages: {
			onTheVendorsList: VendorsList,
			onTheVendorsObjectPage: VendorsObjectPage
        },
        async: true
    });

    return runner;
});

