import CMS
import Foundation
import Logging
import SCAN

public final class MenuItemService {

    private let cms: ContentManagementDataSource
    private let scan: CatalogueDataSource
    private let logger: Logger

    public convenience init(provider: ISPProvider) {
        self.init(
            cms: provider.cms,
            scan: provider.scan,
            logger: Logger(label: "isp-kit.sportsbook.menu-item-service")
        )
    }

    init(cms: ContentManagementDataSource, scan: CatalogueDataSource, logger: Logger) {
        self.cms = cms
        self.scan = scan
        self.logger = logger
    }

    public func featured(locale: Locale = .current) async throws -> [MenuItem] {
        logger.debug("Fetching featured Menu Items.")

        let nodes = try await cms.nodes(.featuredMenuItems(locale: locale))

        return try await mapToMenuItems(nodes, locale: locale)
    }

    public func popular(locale: Locale = .current) async throws -> [MenuItem] {
        logger.debug("Fetching popular Menu Items.")

        let nodes = try await cms.nodes(.popularMenuItems(locale: locale))

        return try await mapToMenuItems(nodes, locale: locale)
    }

    public func aToZ(locale: Locale = .current) async throws -> [MenuItem] {
        logger.debug("Fetching A to Z Menu Items.")

        let nodes = try await cms.nodes(.aToZMenuItems(locale: locale))

        return try await mapToMenuItems(nodes, locale: locale)
    }

    public func menuItemCollection(locale: Locale = .current) async throws -> [MenuItemGroup] {
        logger.debug("Fetching Menu Item collection.")

        async let featured = self.featured(locale: locale)
        async let popular = self.popular(locale: locale)
        async let aToZ = self.aToZ(locale: locale)

        let menuItemGroups = [
            MenuItemGroup(type: .featured, menuItems: try await featured),
            MenuItemGroup(type: .popular, menuItems: try await popular),
            MenuItemGroup(type: .aToZ, menuItems: try await aToZ)
        ]

        return menuItemGroups
    }

}

extension MenuItemService {

    private func mapToMenuItems(_ nodes: [Node], locale: Locale) async throws -> [MenuItem] {
        let sportIDs = nodes.compactMap { node -> Int? in
            guard node.type == .sport, let id = node.sportID else {
                return nil
            }

            return Int(id)
        }

        let competitionIDs = nodes.compactMap { node -> Int? in
            guard node.type == .competition, let id = node.competitionID else {
                return nil
            }

            return Int(id)
        }

        let result = try await scan.search(
            .sports(withIDs: sportIDs, andCompetitionsWithIDs: competitionIDs, locale: locale)
        )

        let sports = result.attachments.sports
        let competitions = result.attachments.competitions

        return nodes.compactMap { node -> MenuItem? in
            switch node.type {
            case .sport:
                guard
                    let id = Sport.ID(node.id),
                    let sportAttachment = sports?[String(id)],
                    let sport = Sport(attachment: sportAttachment)
                else {
                    return nil
                }

                return .sport(sport)

            case .competition:
                guard
                    let id = Competition.ID(node.competitionID ?? ""),
                    let competitionAttachment = competitions?[String(id)],
                    let competition = Competition(attachment: competitionAttachment)
                else {
                    return nil
                }

                return .competition(competition)

            default:
                return nil
            }
        }
    }

}
