import Alamofire
import Swinject

final class DependencyContainer {

    private static let container = Container()
    static var resolver: Resolver {
        container
    }

    static func registerDependencies() {
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
        container.register(PostsInteractorInput.self) { r in
            PostsInteractor(postApi: r.resolve(PostApiInput.self)!)
        }
        container.register(Alamofire.RequestAdapter.self, name: PostsRequestAdapter.injectionKey) { _ in
            PostsRequestAdapter()
        }
        container.register(EnvironmentProviderInput.self) { _ in
            EnvironmentProvider()
        }
        container.register(PostApiInput.self) { r in
            PostApi(
                environmentProvider: r.resolve(EnvironmentProviderInput.self)!,
                requestBuilderFactory: PostsRequestBuilderFactory()
            )
        }
    }
}
