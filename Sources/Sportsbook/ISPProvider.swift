import AsyncHTTPClient
import CMS
import Foundation
import Logging
import SCAN
import SMP

public struct ISPProvider {

    let scan: CatalogueDataSource
    let smp: MarketPricesDataSource
    let cms: ContentManagementDataSource

    public init(dataSourceProvider: DataSourceProvider) {
        switch dataSourceProvider {
        case .shared(let scan, let smp, let cms):
            self.scan = scan
            self.smp = smp
            self.cms = cms

        case .createNew(let site, let environment, let gbpApplicationID, let gbpAPIKey, let cmsApplicationID,
                        let cmsAPIKey):
            let httpClient = HTTPClient(
                eventLoopGroupProvider: .createNew,
                configuration: .init(
                    timeout: .init(connect: .seconds(10))
                )
            )

            let logger = Logger(label: "isp.Sportsbook")

            let gbpClient = GBPHTTPClient(
                applicationID: gbpApplicationID,
                apiKey: gbpAPIKey,
                site: site,
                environment: environment,
                httpClientProvider: .shared(httpClient),
                logger: logger
            )

            let cmsClient = CMSHTTPClient(
                applicationID: cmsApplicationID,
                apiKey: cmsAPIKey,
                site: site,
                environment: environment,
                httpClientProvider: .shared(httpClient),
                logger: logger
            )

            self.scan = SCAN(client: gbpClient, logger: logger)
            self.smp = SMP(client: gbpClient, logger: logger)
            self.cms = CMS(client: cmsClient, logger: logger)
        }
    }

}
