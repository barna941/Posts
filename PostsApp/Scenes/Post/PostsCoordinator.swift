import UIKit

protocol PostsCoordinatorInput: AnyObject {
    func start()
}

final class PostsCoordinatorCoordinator: PostsCoordinatorInput {

    private let navigationController: UINavigationController
    private let sceneFactory: PostsCoordinatorSceneFactoryInput

    init(navigationController: UINavigationController, sceneFactory: PostsCoordinatorSceneFactoryInput) {
        self.navigationController = navigationController
        self.sceneFactory = sceneFactory
    }

    func start() {
    }

}
