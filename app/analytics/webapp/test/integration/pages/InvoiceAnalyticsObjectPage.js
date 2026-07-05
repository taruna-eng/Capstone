sap.ui.define(['sap/fe/test/ObjectPage', 'sap/ui/test/actions/Press'], function(ObjectPage, Press) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {
            iPressSectionIconTabFilterButton: function (section) {
                return this.waitFor({
                    id: new RegExp(`.*--fe::FacetSection::${section}-anchor$`),
                    actions: new Press()
                });
            }
        },
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'analytics',
            componentId: 'InvoiceAnalyticsObjectPage',
            contextPath: '/InvoiceAnalytics'
        },
        CustomPageDefinitions
    );
});