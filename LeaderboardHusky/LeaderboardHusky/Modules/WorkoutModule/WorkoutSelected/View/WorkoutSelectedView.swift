import UIKit
import SnapKit

final class WorkoutSelectedView: UIView {
    var workoutImageView = UIImageView()
    var workoutDescriptionTV = UITextView()
    
    private var scrollView = UIScrollView()
    private var stackView = UIStackView()
    private var leaderboardButton = UIButton(type: .system)
//    private var activityIndicatorView = UIActivityIndicatorView()
    
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
        
        leaderboardButton.backgroundColor = .black
        leaderboardButton.setTitle("Лидерборд", for: .normal)
        leaderboardButton.titleLabel?.font = .systemFont(ofSize: 22, weight: .regular)
        leaderboardButton.setTitleColor(.systemBlue, for: .normal)
        leaderboardButton.layer.cornerRadius = 8
        
        workoutDescriptionTV.font = .systemFont(ofSize: 16, weight: .medium)
        workoutDescriptionTV.textColor = .black
        workoutDescriptionTV.isEditable = false
        workoutDescriptionTV.isScrollEnabled = false
    }
    
    func addSubviews() {
        addSubview(scrollView)
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
    }
}
