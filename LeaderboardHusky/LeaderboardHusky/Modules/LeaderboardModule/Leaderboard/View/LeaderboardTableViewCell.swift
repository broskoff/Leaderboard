import UIKit

final class LeaderboardTableViewCell: UITableViewCell {
    
    static let id = "LeaderboardCell"
    
    private var container = UIView()
    private var rankLabel = UILabel()
    private var nameLabel = UILabel()
    private var resultLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: LeaderboardTableViewCellModel) {
        rankLabel.text = "\(model.rank)"
        nameLabel.text = model.name
        resultLabel.text = model.resultText
    }
}

private extension LeaderboardTableViewCell {
    func configureUI() {
        setupContainer()
        addSubviews()
        setupConstraints()
    }
    
    func setupContainer() {
        container.backgroundColor = .lightGray
        container.layer.cornerRadius = 8
    }
    
    func addSubviews() {
        contentView.addSubview(container)
        container.addSubview(rankLabel)
        container.addSubview(nameLabel)
        container.addSubview(resultLabel)
    }
    
    func setupConstraints() {
        container.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(IndentsLeaderboardTVCconteiner.leadingTrailing)
            $0.top.bottom.equalToSuperview().inset(IndentsLeaderboardTVCconteiner.topBottom)
        }
        
        rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(IndentsLeaderboardTVCRankLabel.leading)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(IndentsLeaderboardTVCRankLabel.width)
        }
        
        resultLabel.snp.makeConstraints { 
            $0.trailing.equalToSuperview().inset(IndentsLeaderboardTVCResultLabel.trailing)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(IndentsLeaderboardTVCResultLabel.width)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(rankLabel.snp.trailing).offset(IndentsLeaderboardTVCNameLabel.leading)
            $0.trailing.equalTo(resultLabel.snp.leading).offset(IndentsLeaderboardTVCNameLabel.trailing)
            $0.centerY.equalToSuperview()
        }
    }
}
