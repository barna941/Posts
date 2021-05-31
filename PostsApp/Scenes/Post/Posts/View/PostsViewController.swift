import UIKit

protocol PostsView: AnyObject, ErrorHandlingView {
    func showDisplayItems(items: [PostsModel.DisplayItem])
}

final class PostsViewController: UIViewController {
    typealias DisplayItem = PostsModel.DisplayItem

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: PostsLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: PostCollectionViewCell.reuseIdentifier)
        return collectionView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .darkGray
        return label
    }()

    private var displayItems: [DisplayItem] = []

    private let presenter: PostsPresenterInput

    init(presenter: PostsPresenterInput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        customizeViews()
        localizeViews()

        presenter.getPosts()
    }

    private func customizeViews() {
        view.backgroundColor = .backgroundGray
        view.addSubview(collectionView)
    }

    private func localizeViews() {
    }

    private func setupConstraints() {
        let constraints = collectionViewConstraints()
        NSLayoutConstraint.activate(constraints)
    }

    private func collectionViewConstraints() -> [NSLayoutConstraint] {
        [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
    }
}

extension PostsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        displayItems.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let displayItem = displayItems[indexPath.row]
        switch displayItem {
        case let .post(model):
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.reuseIdentifier, for: indexPath) as! PostCollectionViewCell
            cell.configure(with: model)
            return cell
        }
    }

}

extension PostsViewController: PostsView {

    func showDisplayItems(items: [PostsModel.DisplayItem]) {
        collectionView.reloadData()
    }

}
