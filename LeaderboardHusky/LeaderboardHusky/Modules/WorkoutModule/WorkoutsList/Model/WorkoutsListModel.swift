import Foundation

protocol IWorkoutsListModel {
    var id: Int { get set }
    var date: String { get set }
    var image: String { get set }
}

struct WorkoutsListModel: Decodable, IWorkoutsListModel {
    var id: Int
    var date: String
    var image: String
}
