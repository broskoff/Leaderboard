import UIKit
import SnapKit

final class WorkoutSelectedView: UIView {
    var workoutImageView = UIImageView()
    var workoutDescriptionTV = UITextView()
    var leaderboardButton = UIButton()
    var activityIndicatorView = UIActivityIndicatorView()
    
    private var scrollView = UIScrollView()
    private var stackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension WorkoutSelectedView {
    func configureUI() {
        backgroundColor = .white
        
        setupElements()
        addSubviews()
        setupConstraints()
    }
    
    func setupElements() {
        stackView.axis = .vertical
        stackView.spacing = 16
        
        workoutImageView.contentMode = .scaleAspectFill
        workoutImageView.layer.cornerRadius = 12
        workoutImageView.clipsToBounds = true
        
        leaderboardButton = UIButton(type: .system)
        leaderboardButton.backgroundColor = .black
        leaderboardButton.setTitle(LeaderboardButtonText.leaderboard.rawValue, for: .normal)
        leaderboardButton.titleLabel?.font = .systemFont(ofSize: 22, weight: .regular)
        leaderboardButton.setTitleColor(.systemBlue, for: .normal)
        leaderboardButton.layer.cornerRadius = 8
        
        workoutDescriptionTV.font = .systemFont(ofSize: 16, weight: .medium)
        workoutDescriptionTV.textColor = .black
        workoutDescriptionTV.isEditable = false
        workoutDescriptionTV.isScrollEnabled = false
        
        activityIndicatorView.style = .large
        activityIndicatorView.color = .systemBlue
    }
    
    func addSubviews() {
        addSubview(scrollView)
        addSubview(activityIndicatorView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(workoutImageView)
        stackView.addArrangedSubview(leaderboardButton)
        stackView.addArrangedSubview(workoutDescriptionTV)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide).inset(16)
            $0.width.equalTo(scrollView.frameLayoutGuide).inset(16)
        }
        
        workoutImageView.snp.makeConstraints {
            $0.height.equalTo(550)
        }
        
        activityIndicatorView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
