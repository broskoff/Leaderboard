import UIKit
import SnapKit

final class WorkoutsListCollectionViewCell: UICollectionViewCell {
    static let id = "workoutCell"
    
    private let activityIndicatorImage: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .medium
        activityIndicatorView.color = .systemBlue
        return activityIndicatorView
    }()
    
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
        workoutImage.image = nil
        activityIndicatorImage.startAnimating()
        
        if let imageURL = URL(string: workout) {
          
            URLSession.shared.dataTask(with: imageURL) { [weak self] data, _,_ in
                guard let self = self else { return }
                
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.workoutImage.image = image
                        self.activityIndicatorImage.stopAnimating()
                    }
                } else {
                    print("Oшибка загрузки картинки в ячейку")
                }
            }.resume()
        }
        workoutDataLabel.text = date
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        workoutImage.image = nil
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
        contentView.addSubview(activityIndicatorImage)
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
        
        activityIndicatorImage.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
