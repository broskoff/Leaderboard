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
        let imageURL = URL(string: workout)
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            guard let url = imageURL, let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.workoutImage.image = UIImage(data: imageData)
            }
        }
        workoutDataLabel.text = date
    }

    
    private func configCell() {
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
