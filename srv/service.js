const cds = require('@sap/cds');

const invoiceHandler = require('./handlers/invoiceHandler');
const invoiceItemHandler = require('./handlers/invoiceItemHandler');
const approvalHandler = require('./handlers/approvalHandler');
const analyticsHandler = require('./handlers/analyticsHandler');
const vendorHandler = require('./handlers/vendorHandler');
const integrationHandler = require('./handlers/integrationHandler');
const attachmentHandler = require('./handlers/attachmentHandler');
const auditHandler = require('./handlers/auditHandler');

module.exports = cds.service.impl(async function () {

    invoiceHandler.call(this);
    invoiceItemHandler.call(this);
    approvalHandler.call(this);
    analyticsHandler.call(this);
    vendorHandler.call(this);
    integrationHandler.call(this);
    attachmentHandler.call(this);
    auditHandler.call(this);

});















