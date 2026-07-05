using { vendor.invoice.management as db } from '../db/schema';

service IntegrationService {

    entity Vendors as projection on db.Vendors;

    action SyncVendors() returns String;

}