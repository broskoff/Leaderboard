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
    
    private func configCell() {
        backgroundColor = .purple
        layer.cornerRadius = 12
        
        setupElements()
        addSubviews()
        addConstraint()
    }
    
    private func setupElements() {
        workoutImage.image = UIImage(named: "1")
        workoutImage.contentMode = .scaleAspectFill
        workoutImage.layer.cornerRadius = 12
        workoutImage.clipsToBounds = true
        
        workoutDataLabel.textAlignment = .center
        workoutDataLabel.text = "12.11.2025"
    }
    
    private func addSubviews() {
        contentView.addSubview(workoutImage)
        contentView.addSubview(workoutDataLabel)
    }
    
    private func addConstraint() {
        workoutImage.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()// отступы от границ
            make.height.equalTo(contentView.snp.height).multipliedBy(0.95)
        }
        
        workoutDataLabel.snp.makeConstraints { make in
            make.top.equalTo(workoutImage.snp.bottom)
            make.centerX.equalTo(workoutImage)
        }
    }
}
