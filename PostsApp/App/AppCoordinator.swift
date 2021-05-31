import UIKit

final class AppCoordinator {

    private let window: UIWindow

    private lazy var navigationController: UINavigationController = {
        let navController = UINavigationController()
        navController.setNavigationBarHidden(true, animated: false)
        return navController
    }()

    init(window: UIWindow?) {
        self.window = window!
    }

    func start() {
        DependencyContainer.resolver.resolve(
            PostsCoordinatorInput.self,
            argument: (navigationController as UINavigationController)
        )?.start()

        window.makeKeyAndVisible()
        window.rootViewController = navigationController
    }

}
