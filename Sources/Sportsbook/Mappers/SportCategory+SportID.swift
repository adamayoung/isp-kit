import Foundation

extension Sport.Category {

    init?(sportID: Sport.ID) {
        guard
            let category = (Sport.Category.allCases.first { $0.sports.contains(sportID) })
        else {
            return nil
        }

        self = category
    }

}

private extension Sport.Category {

    private var sports: [Sport.ID] {
        switch self {
        case .avb:
            return [
                1477, 6422, 1938544, 2872194, 5412697, 2, 678378, 606611, 627555, 28578623, 26420387, 998920, 1, 7511,
                998917, 7522, 5, 2901849, 4, 136332, 468328, 998916, 27105927, 27454571, 15826206, 2152880, 61420,
                998919, 7524, 982477, 6231, 4609466, 6, 12, 72382, 998918, 451485, 6423, 2593174, 3503, 27589895, 7523
            ]

        case .outright:
            return [
                2378961, 28361982, 315220, 4726642, 27065662, 620576, 3088925, 3988, 10, 27388198, 28347302, 8, 300000,
                28609007, 27485048, 11, 3, 28608996, 28361978, 29125756
            ]

        case .racingNew:
            return [7]

        case .racingOld:
            return [4339]
        }
    }

}
