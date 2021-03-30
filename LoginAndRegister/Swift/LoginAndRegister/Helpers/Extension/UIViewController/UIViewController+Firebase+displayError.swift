import UIKit

public extension UIViewController {
    // https://github.com/firebase/quickstart-ios/tree/master/authentication
    /// Error Alert Controller from Firebase Quickstarts for iOS
    /// - Tag: FirebaseErrorAlert
    func displayError(_ error: Error?, from function: StaticString = #function) {
        guard let error = error else { return }
        print("▸ ERROR IN: \(function): \(error.localizedDescription)")
        let alert = UIAlertController(
            title: "Firebase Error",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(.init(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
