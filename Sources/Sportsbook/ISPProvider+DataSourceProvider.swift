import CMS
import Foundation
import SCA
import SCAN
import SIB
import SMP

extension ISPProvider {

    public enum DataSourceProvider {

        case shared(scan: CatalogueDataSource, smp: MarketPricesDataSource, sib: SportsbookImplyBetsDataSource,
                    sca: SportsContentDataSource, cms: ContentManagementDataSource)
        case createNew(site: StarsSite, environment: Environment, gbpApplicationID: String, gbpAPIKey: String,
                       cmsApplicationID: String, cmsAPIKey: String)

    }

}
