import CMS
import Foundation
import SCAN
import SMP

extension ISPProvider {

    public enum DataSourceProvider {

        case shared(scan: CatalogueDataSource, smp: MarketPricesDataSource, cms: ContentManagementDataSource)
        case createNew(site: StarsSite, environment: Environment, gbpApplicationID: String, gbpAPIKey: String,
                       cmsApplicationID: String, cmsAPIKey: String)

    }

}
