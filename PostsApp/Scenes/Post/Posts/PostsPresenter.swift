protocol PostsPresenterInput: AnyObject {
    var view: PostsView? { get set }

    func getPosts()
}

final class PostsPresenter: PostsPresenterInput {
    typealias DisplayItem = PostsModel.DisplayItem
    typealias Post = PostsModel.Post

    private let coordinator: PostsCoordinatorInput
    private let interactor: PostsInteractorInput

    weak var view: PostsView?

    init(coordinator: PostsCoordinatorInput, interactor: PostsInteractorInput) {
        self.coordinator = coordinator
        self.interactor = interactor
    }

    func getPosts() {
        interactor.getPosts { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(posts):
                self.view?.showDisplayItems(items: self.map(posts: posts))

            case let .failure(error):
                self.view?.handleError(error: error)
            }
        }
    }

    private func map(posts: [Post]) -> [DisplayItem] {
        posts.map {
            .post($0)
        }
    }

}
