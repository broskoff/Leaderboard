import UIKit
import SnapKit

final class LeaderboardView: UIView {
    let leaderboardTableView = UITableView()
    var addResultButton = UIButton(type: .system)
    
    lazy var leaderboardSegmentControl = UISegmentedControl(items: [
        LeaderboardSegmentControlText.boys,
        LeaderboardSegmentControlText.girls
    ])
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension LeaderboardView {
    func configureUI() {
        backgroundColor = .white
        
        setupElements()
        addSubviews()
        setupConstraints()
    }
    
    func setupElements() {
        leaderboardSegmentControl.selectedSegmentIndex = 0
        
        leaderboardTableView.separatorStyle = .none
        leaderboardTableView.showsVerticalScrollIndicator = false
        
        addResultButton.setTitle("+", for: .normal)
        addResultButton.titleLabel?.font = .systemFont(ofSize: 32, weight: .bold)
        addResultButton.backgroundColor = .systemBlue
        addResultButton.tintColor = .white
        addResultButton.layer.cornerRadius = 28
        addResultButton.layer.shadowColor = UIColor.black.cgColor
        addResultButton.layer.shadowOpacity = 0.2
        addResultButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        addResultButton.layer.shadowRadius = 4
    }
    
    func addSubviews() {
        addSubview(leaderboardSegmentControl)
        addSubview(leaderboardTableView)
        addSubview(addResultButton)
    }
    
    func setupConstraints() {
        leaderboardSegmentControl.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(IndentsLeaderboardSC.top)
            $0.leading.trailing.equalToSuperview().inset(IndentsLeaderboardSC.leadingTrailing)
        }
        
        leaderboardTableView.snp.makeConstraints {
            $0.top.equalTo(leaderboardSegmentControl.snp.bottom).offset(IndentsLeaderboardTV.top)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        addResultButton.snp.makeConstraints {
            $0.width.height.equalTo(IndentsLeaderboardButton.widthHeight)
            $0.trailing.equalToSuperview().inset(IndentsLeaderboardButton.trailing)
            $0.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).inset(IndentsLeaderboardButton.bottom)
        }
    }
}
