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
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.1
        container.layer.shadowOffset = CGSize(width: 0, height: 2)
        container.layer.shadowRadius = 4
    }
    
    func addSubviews() {
        contentView.addSubview(container)
        container.addSubview(rankLabel)
        container.addSubview(nameLabel)
        container.addSubview(resultLabel)
    }
    
    func setupConstraints() {
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        rankLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(30)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
            make.width.equalTo(60)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(rankLabel.snp.trailing).offset(8)
            make.trailing.equalTo(resultLabel.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
        }
    }
}
