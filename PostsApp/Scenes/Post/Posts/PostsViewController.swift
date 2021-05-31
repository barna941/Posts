import UIKit

protocol PostsView: AnyObject {}

final class PostsViewController: UIViewController {

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
    }

    private func customizeViews() {}

    private func localizeViews() {}
}

extension PostsViewController: PostsView {}
