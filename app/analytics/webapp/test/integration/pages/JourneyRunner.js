sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"analytics/test/integration/pages/InvoiceAnalyticsList",
	"analytics/test/integration/pages/InvoiceAnalyticsObjectPage"
], function (JourneyRunner, InvoiceAnalyticsList, InvoiceAnalyticsObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('analytics') + '/test/flp.html#app-preview',
        pages: {
			onTheInvoiceAnalyticsList: InvoiceAnalyticsList,
			onTheInvoiceAnalyticsObjectPage: InvoiceAnalyticsObjectPage
        },
        async: true
    });

    return runner;
});

