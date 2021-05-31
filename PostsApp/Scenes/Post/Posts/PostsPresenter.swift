protocol PostsPresenterInput: AnyObject {}

final class PostsPresenter: PostsPresenterInput {

    private let coordinator: PostsCoordinatorInput
    private let interactor: PostsInteractorInput
    weak var view: PostsView?

    init(coordinator: PostsCoordinatorInput, interactor: PostsInteractorInput) {
        self.coordinator = coordinator
        self.interactor = interactor
    }
}
