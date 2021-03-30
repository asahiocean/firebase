import Foundation
import Firebase
import UIKit

protocol AuthDataDelegate: class {
    func authData(with authdata: AuthDataResult)
}

protocol DismissDelegate: class {
    func dismissed()
}

protocol ChoiceAuthMethodRouterProtocol: class {
    func methodViewController(for method: AuthMethod)
}

class ChoiceAuthMethodRouter: ChoiceAuthMethodRouterProtocol, DismissDelegate {    
    // MARK: Main View Controller
    fileprivate weak var viewController: ChoiceAuthMethodViewController!
    
    // MARK: Child View Controllers
    // = = = E-Mail = = =
    fileprivate let emailNotAuthorized: EmailAuthViewController
    fileprivate let emailAuthorized: EmailProfileViewController
    fileprivate var emailDelegate: AuthDataDelegate?
    
    func dismissed() {
        viewController.reloadList()
        // some actions when closing the screen...
    }
    
    func methodViewController(for method: AuthMethod) {
        func TODO_METHOD() {
            #warning("TODO SCREENS")
            let alertWait: UIAlertController = .alertPleaseWait
            viewController.present(alertWait, animated: true)
            let alert = UIAlertController(title: "This method is not yet available.", message: "We apologize for the inconvenience!\nDevelopers are working hard to make authorization via this method available!", preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .cancel))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                alertWait.dismiss(animated: true, completion: {
                    self.viewController?.present(alert, animated: true)
                })
            }
        }
        
        switch method {
        case .email:
            if viewController.isAuthorized(with: method) {
                emailDelegate = emailAuthorized
                viewController.authData(for: method, { data in
                    guard let data = data else { fatalError() }
                    self.emailDelegate?.authData(with: data)
                })
                if let nav = viewController.navigationController {
                    nav.pushViewController(emailAuthorized, animated: true)
                } else {
                    viewController.present(emailAuthorized, animated: true)
                }
            } else {
                emailNotAuthorized.delegate = viewController.presenter.interactor
                let navigation = EmailAuthNavigationController(root: emailNotAuthorized)
                navigation.notify = self
                viewController.present(navigation, animated: true)
            }
        case .phone:
            TODO_METHOD()
        case .google:
            TODO_METHOD()
        case .playGames:
            TODO_METHOD()
        case .gameCenter:
            TODO_METHOD()
        case .facebook:
            TODO_METHOD()
        case .twitter:
            TODO_METHOD()
        case .gitHub:
            TODO_METHOD()
        case .yahoo:
            TODO_METHOD()
        case .microsoft:
            TODO_METHOD()
        case .apple:
            TODO_METHOD()
        case .anonymous:
            TODO_METHOD()
        }
    }
    
    // MARK: - Initialization
    
    init(vc viewController: ChoiceAuthMethodViewController) {
        self.viewController = viewController
        emailNotAuthorized = .init()
        emailAuthorized = .init()
    }
}
