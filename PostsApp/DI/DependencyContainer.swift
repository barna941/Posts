import Swinject

final class DependencyContainer {

    private static let container = Container()
    static var resolver: Resolver {
        container
    }

    static func registerDependencies() {
        // Posts
        container.register(PostsCoordinatorInput.self) { r, navigationController in
            PostsCoordinator(
                navigationController: navigationController,
                sceneFactory: r.resolve(PostsCoordinatorSceneFactoryInput.self)!
            )
        }
        container.register(PostsCoordinatorSceneFactoryInput.self) { _ in
            PostsCoordinatorSceneFactory()
        }
        container.register(PostsPresenterInput.self) { r, coordinator in
            PostsPresenter(
                coordinator: coordinator,
                interactor: r.resolve(PostsInteractorInput.self)!
            )
        }
        container.register(PostsInteractorInput.self) { _ in
            PostsInteractor()
        }
    }
}
