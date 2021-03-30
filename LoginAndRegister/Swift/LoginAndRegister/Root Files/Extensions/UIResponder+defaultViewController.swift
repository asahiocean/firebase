import UIKit.UIResponder

extension UIResponder {
    static func defaultViewController(for window: UIWindow?) {
        guard let window = window else { fatalError() }
        let root = ChoiceAuthMethodViewController(nibName: nil, bundle: nil)
        window.rootViewController = UINavigationController(rootViewController: root)
        if #available(iOS 13.0, *) {
            window.backgroundColor = .systemBackground
        } else {
            window.backgroundColor = .white
        }
        window.makeKeyAndVisible()
    }
}
