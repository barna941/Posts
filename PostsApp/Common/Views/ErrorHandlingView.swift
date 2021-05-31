import UIKit

protocol ErrorHandlingView {
    func handleError(error: Error)
}

extension ErrorHandlingView where Self: UIViewController {
    func handleError(error: Error) {
    }
}
