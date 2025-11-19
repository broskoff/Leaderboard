import Foundation

class MockData {
    static var boysLeaderboard: [(rank: Int, name: String, result: Int)] = [
        (1, "Олег", 123),
        (2, "Иван", 115),
        (3, "Дима", 110),
        (4, "Сергей", 108),
        (5, "Алексей", 105),
        (6, "Никита", 102),
        (7, "Владимир", 100),
        (8, "Павел", 98),
        (9, "Егор", 95),
        (10, "Михаил", 92),
        (11, "Роман", 90),
        (12, "Денис", 88)
    ]
    
    static var girlsLeaderboard: [(rank: Int, name: String, result: Int)] = [
        (1, "Мария", 130),
        (2, "Елена", 125),
        (3, "Анна", 120),
        (4, "Ольга", 118),
        (5, "Ирина", 115),
        (6, "Светлана", 112),
        (7, "Наталья", 110),
        (8, "Татьяна", 108),
//        (9, "Анастасия", 105),
//        (10, "Юлия", 102),
//        (11, "Ксения", 100),
//        (12, "Виктория", 98)
    ]
    
    static var currentLeaderboard: [(rank: Int, name: String, result: Int)] = []
}



struct LeaderboardTableViewCellModel {
    let rank: Int
    let name: String
    let result: String
}
