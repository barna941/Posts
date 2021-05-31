import UIKit

extension UIColor {

    static var backgroundGray: UIColor {
        rgb(226, 226, 226)
    }

}

private func rgb(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1) -> UIColor {
    UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
}
