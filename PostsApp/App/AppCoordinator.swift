import UIKit

final class AppCoordinator {

    private let window: UIWindow

    private lazy var navigationController: UINavigationController = {
        UINavigationController()
    }()

    init(window: UIWindow?) {
        self.window = window!
    }

    func start() {
        window.makeKeyAndVisible()
        window.rootViewController = DependencyContainer.resolver.resolve(
            PostsCoordinatorInput.self,
            argument: (navigationController as UINavigationController)
        )?.start()
    }

}
