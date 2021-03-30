import Foundation
import UIKit

protocol EmailAuthRouterProtocol: class, Alertmanager {
    func presentRegisterScreen()
    /// Display tell me what's what
    func informationHint()
    /// Successful authentication notification
    func successAuth()
}

class EmailAuthRouter: EmailAuthRouterProtocol {
    
    // MARK: - View Controllers
    
    fileprivate let authorization: EmailAuthViewController
    fileprivate let registration: EmailRegistrationViewController
    
    func presentRegisterScreen() {
        if let nav = authorization.navigationController {
            nav.pushViewController(registration, animated: true)
        } else {
            authorization.present(registration, animated: true)
        }
    }
    
    // MARK: - Alert Controllers
    fileprivate let alertPleaseWait: UIAlertController
    func pleaseWait(is visible: Bool) {
        presentAlert(visible, alertPleaseWait, for: authorization)
    }
    
    fileprivate let alertIncorrectEmailPass: UIAlertController?
    func alertIncorrectEmailPassManager(made visible: Bool) {
        presentAlert(visible, alertIncorrectEmailPass, for: authorization)
    }
    
    fileprivate let alertInformationHint: UIAlertController?
    func informationHint() {
        presentAlert(true, alertInformationHint, for: authorization)
    }
    
    fileprivate let alertSuccessAuth: UIAlertController?
    func successAuth() {
        presentAlert(true, alertSuccessAuth, for: authorization, {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
                alertSuccessAuth?.dismiss(animated: true, completion: {
                    authorization.dismiss(animated: true)
                })
            }
        })
    }
    
    // MARK: - Helpers
    // Optional function to display error alert
    func alertDisplayError(with error: Error?) {
        authorization.displayError(error)
    }
    
    // MARK: - Initialization
    
    init(vc viewController: EmailAuthViewController) {
        self.authorization = viewController
        registration = EmailRegistrationViewController()
        registration.presenter.delegate = viewController
                
        alertPleaseWait = .alertPleaseWait
        
        alertInformationHint = UIAlertController(title: "Information", message: "In the \"Email\" field, enter the email address to which you previously registered and enter your password in the \"Password\" field, otherwise register by clicking the \"Registration\" button on the top right", preferredStyle: .alert)
        alertInformationHint?.addAction(.init(title: "OK", style: .cancel))
        
        alertSuccessAuth = UIAlertController(title: "Success", message: "You are successfully logged in!", preferredStyle: .alert)

        alertIncorrectEmailPass = .incorrectEmailPass
        alertIncorrectEmailPass?.addAction(.init(title: "OK", style: .cancel))
        
    }
}
