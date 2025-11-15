import UIKit
import SnapKit

protocol IWorkoutsListView: AnyObject {
    
    var workoutsCollectionView: UICollectionView { get }
}

final class WorkoutsListView: UIView, IWorkoutsListView {
    
    lazy var workoutsLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        layout.minimumLineSpacing = 8
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
            make.leading.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
