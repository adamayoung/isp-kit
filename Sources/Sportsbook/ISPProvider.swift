import AsyncHTTPClient
import CMS
import Foundation
import Logging
import SCA
import SCAN
import SIB
import SMP

public struct ISPProvider {

    let scan: CatalogueDataSource
    let smp: MarketPricesDataSource
    let sib: SportsbookImplyBetsDataSource
    let sca: SportsContentDataSource
    let cms: ContentManagementDataSource

    public init(dataSourceProvider: DataSourceProvider, logger: Logger = Logger(label: "isp.sportsbook")) {
        switch dataSourceProvider {
        case .shared(let scan, let smp, let sib, let sca, let cms):
            self.scan = scan
            self.smp = smp
            self.sib = sib
            self.sca = sca
            self.cms = cms

        case .createNew(let site, let environment, let gbpApplicationID, let gbpAPIKey, let cmsApplicationID,
                        let cmsAPIKey, let httpClientProvider):

            let gbpClient = GBPHTTPClient(
                applicationID: gbpApplicationID,
                apiKey: gbpAPIKey,
                site: site,
                environment: environment,
                httpClientProvider: httpClientProvider,
                logger: logger
            )

            let cmsClient = CMSHTTPClient(
                applicationID: cmsApplicationID,
                apiKey: cmsAPIKey,
                site: site,
                environment: environment,
                httpClientProvider: httpClientProvider,
                logger: logger
            )

            self.scan = SCAN(client: gbpClient, logger: logger)
            self.smp = SMP(client: gbpClient, logger: logger)
            self.sib = SIB(client: gbpClient, logger: logger)
            self.sca = SCA(client: gbpClient, logger: logger)
            self.cms = CMS(client: cmsClient, logger: logger)
        }
    }

}
