import Foundation

struct FootballResult: Decodable {

    let fixture: [FootballScoreboard]

    init(fixture: [FootballScoreboard]) {
        self.fixture = fixture
    }

}
