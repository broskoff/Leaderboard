import UIKit
import SnapKit

protocol IWorkoutsListView: AnyObject {
    
    var workoutsCollectionView: UICollectionView { get }
}

final class WorkoutsListView: UIView, IWorkoutsListView {
    
    lazy var workoutsLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 12
        
        return layout
    }()
    
    lazy var workoutsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: workoutsLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension WorkoutsListView {
    func configView() {
        backgroundColor = .white
        
        addSubviews()
        addConstraints()
    }
    
    func addSubviews() {
        addSubview(self.workoutsCollectionView)
    }
    
    func addConstraints() {
        workoutsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalTo(safeAreaLayoutGuide)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
