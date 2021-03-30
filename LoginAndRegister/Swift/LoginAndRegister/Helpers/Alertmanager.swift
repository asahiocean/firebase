import Foundation
import UIKit

@objc protocol Alertmanager {
    /// To display progress visibility
    func pleaseWait(is visible: Bool)
    /// To display an error when entering data incorrectly
    func alertIncorrectEmailPassManager(made visible: Bool)
    /// By default, this method is needed to output an [error from Firebase](x-source-tag://FirebaseErrorAlert)
    /// - Parameter error: description :D
    @objc optional func alertDisplayError(with error: Error?)
}

extension Alertmanager {
    func presentAlert(_ visible: Bool, // visibility status
                      _ alert: UIAlertController?, // alert itself
                      for viewController: UIViewController,
                      _ completion: (() -> Void)? = nil) {
        if visible, let alert = alert {
            viewController.present(alert, animated: true)
        } else {
            alert?.dismiss(animated: true)
        }
        completion?()
    }
}

extension UIAlertController {
    static var alertPleaseWait: UIAlertController {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let indicator = UIActivityIndicatorView(frame: .init(x: 10, y: 5, width: 50, height: 50))
        indicator.hidesWhenStopped = true
        indicator.style = .gray
        indicator.startAnimating()
        alert.view.addSubview(indicator)
        return alert
    }
    
    static var incorrectEmailPass: UIAlertController {
        let alert = UIAlertController(title: "Email or password entered incorrectly!",
                                      message: "Please make sure the entered data is correct, otherwise contact support!",
                                      preferredStyle: .alert)
        return alert
    }    
}
