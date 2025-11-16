import UIKit
import SnapKit

final class WorkoutsListCollectionViewCell: UICollectionViewCell {
    
    static let id = "workoutCell"
    
    private var workoutImage = UIImageView()
    private var workoutDataLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(workout: String, date: String) {
        workoutImage.image = UIImage(named: workout)
        workoutDataLabel.text = date
    }

    
    private func configCell() {
//        backgroundColor = .purple
        
        setupElements()
        addSubviews()
        addConstraint()
    }
    
    private func setupElements() {
        workoutImage.contentMode = .scaleAspectFill
        workoutImage.layer.cornerRadius = 12
        workoutImage.clipsToBounds = true
        
        workoutDataLabel.textAlignment = .center
        workoutDataLabel.backgroundColor = .white
        workoutDataLabel.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
    private func addSubviews() {
        contentView.addSubview(workoutImage)
        contentView.addSubview(workoutDataLabel)
    }
    
    private func addConstraint() {
        workoutImage.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.height.equalTo(workoutImage.snp.width)
        }
        
        workoutDataLabel.snp.makeConstraints {
            $0.top.equalTo(workoutImage.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
    }
}
