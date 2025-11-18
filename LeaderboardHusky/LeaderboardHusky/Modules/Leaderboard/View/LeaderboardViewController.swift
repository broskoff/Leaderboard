import UIKit

protocol ILeaderboardView {
    
}

final class LeaderboardViewController: UIViewController, ILeaderboardView {
    
    private let leaderboardView = LeaderboardView()
    
    override func loadView() {
        super.loadView()
        
        view = leaderboardView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Лидерборд 18.11.2025"
    }
}
