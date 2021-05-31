protocol PostsCoordinatorSceneFactoryInput {
    func postsViewController(coordinator: PostsCoordinatorInput) -> PostsViewController
}

final class PostsCoordinatorSceneFactory: PostsCoordinatorSceneFactoryInput {

    func postsViewController(coordinator: PostsCoordinatorInput) -> PostsViewController {
        let presenter = DependencyContainer.resolver.resolve(
            PostsPresenterInput.self,
            argument: coordinator
        )!
        let viewController = PostsViewController(presenter: presenter)
        presenter.view = viewController
        return viewController
    }

}
