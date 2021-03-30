import Foundation
import UIKit

protocol EmailRegistrationRouterProtocol: class, Alertmanager {
    var viewController: EmailRegistrationViewController { get }
    func alertWithCongrats(visible: Bool)
    func presentTermsOfUse()
}

class EmailRegistrationRouter: EmailRegistrationRouterProtocol {
    
    // MARK: - View Controllers
    
    let viewController: EmailRegistrationViewController
    
    // MARK: - Alerts
    
    fileprivate var alertWithCongrats: UIAlertController?
    func alertWithCongrats(visible: Bool) {
        presentAlert(visible, alertWithCongrats, for: viewController)
    }
    
    fileprivate var alertPleaseWait: UIAlertController?
    func pleaseWait(is visible: Bool) {
        presentAlert(visible, alertPleaseWait, for: viewController)
    }
    
    fileprivate var incorrectEmailPass: UIAlertController?
    func alertIncorrectEmailPassManager(made visible: Bool) {
        presentAlert(visible, incorrectEmailPass, for: viewController)
    }
    
    func presentTermsOfUse() {
        let termsOfUseVC = TermsOfUseViewController.shared
        viewController.present(termsOfUseVC, animated: true)
    }
    
    // MARK: - Helpers
    
    func alertDisplayError(with error: Error?) {
        viewController.displayError(error)
    }
    
    // MARK: - Initialization
    
    init(vc controller: EmailRegistrationViewController) {
        viewController = controller
        
        self.alertPleaseWait = .alertPleaseWait
        
        // When the button is pressed, user will be redirected to the authorization screen
        /// Upon successful registration, an alert will be displayed with the text about successful registration
        self.alertWithCongrats = UIAlertController(title: "You are gorgeous! 🎉", message: "Now you can log in using your username and password!", preferredStyle: .alert)
        alertWithCongrats?.addAction(.init(title: "Go to login page", style: .cancel, handler: { _ in
            controller.navigationController?.popToRootViewController(animated: true)
        }))
    }
}
