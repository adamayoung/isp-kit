import Foundation
import Logging
import SCAN
import SIB

public final class OpportunityService {

    private let sib: SportsbookImplyBetsDataSource
    private let scan: CatalogueDataSource
    private let logger: Logger

    public convenience init(provider: ISPProvider) {
        self.init(
            sib: provider.sib,
            scan: provider.scan,
            logger: Logger(label: "isp-kit.sportsbook.opportunity-service")
        )
    }

    init(sib: SportsbookImplyBetsDataSource, scan: CatalogueDataSource, logger: Logger) {
        self.sib = sib
        self.scan = scan
        self.logger = logger
    }

    public func opportunities(for selections: [Selection], authToken: String, currencyCode: String,
                              locale: Locale = .current) async throws -> String {
        logger.debug("Fetching Opportunities.", metadata: ["selections": .stringConvertible(selections.map(\.id))])

//        let betLegs = selections.uniqueMap(BetLeg.init)
//        let request = ImplyBetsRequest(
//            betLegs: betLegs,
//            authToken: authToken,
//            locale: locale,
//            currencyCode: currencyCode
//        )
//
//        let implyBetsResult = try await sib.implyBets(request)
//        let marketIDs: [Market.ID] = implyBetsResult.betCombinations.flatMap { betCombination in
//            betCombination.legCombinations.flatMap { legCombination in
//                legCombination.runners.map(\.marketID)
//            }
//        }
//
//        let scanResult = try await scan.search(.opportunityMarkets(withIDs: marketIDs, locale: locale))

        return ""
    }

}
