protocol PostsCoordinatorSceneFactoryInput {
    func postsViewController(coordinator: PostsCoordinatorInput) -> PostsViewController
}

final class PostsCoordinatorSceneFactory: PostsCoordinatorSceneFactoryInput {

    func postsViewController(coordinator: PostsCoordinatorInput) -> PostsViewController {
        let presenter = DependencyContainer.resolver.resolve(
            PostsPresenterInput.self,
            argument: coordinator
        )!
        return PostsViewController(presenter: presenter)
    }

}
