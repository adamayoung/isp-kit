import Foundation

public struct MenuItemGroup: Identifiable, Equatable, Encodable {

    public var id: String { type.rawValue }
    public let type: MenuItemGroupType
    public let menuItems: [MenuItem]

    public  init(type: MenuItemGroup.MenuItemGroupType, menuItems: [MenuItem]) {
        self.type = type
        self.menuItems = menuItems
    }

}

extension MenuItemGroup {

    public enum MenuItemGroupType: String, Equatable, Encodable {
        case featured = "FEATURED"
        case popular = "POPULAR"
        case aToZ = "A_TO_Z"
    }

}
