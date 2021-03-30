import Foundation
import UIKit

protocol EmailRegistrationDelegate: class {
    /// Delegate method to get email to the appropriate location when requested
    func emailDelegate(_ email: String)
}

protocol EmailRegistrationPresenterProtocol: class {
    var interactor: EmailRegistrationInteractorProtocol! { get set }
    var router: EmailRegistrationRouterProtocol! { get set }
    func registerEmail() throws -> String
    func registerPassword() throws -> String
    var delegate: EmailRegistrationDelegate? { get set }
    func viewWillAppear()
    func viewDidDisappear()
    func configureView()
}

class EmailRegistrationPresenter: EmailRegistrationPresenterProtocol {
    
    weak var view: EmailRegistrationViewProtocol!
    var interactor: EmailRegistrationInteractorProtocol!
    var router: EmailRegistrationRouterProtocol!
    
    /// delegate to notify that the user has completed registration
    weak var delegate: EmailRegistrationDelegate?
    
    /// Requests a email from `view` and will pass it when clicking on the "Registration" button to the form to create a request to Firebase
    func registerEmail() throws -> String {
        let email = view.email()
        // some actions with the email
        return email
    }
    /// Requests a password from `view` and will pass it when clicking on the "Registration" button to the form to create a request to Firebase
    func registerPassword() throws -> String {
        let password = view.password()
        // some actions with the password
        return password
    }
    
    // MARK: - Targets
    /// Responsible for the actions that will be performed when you click on the "Registration" button.
    @objc fileprivate func registrationClicked(_ sender: UIButton) {
        // show an alert with a request to wait
        router.pleaseWait(is: true)
        /// inform the `Interactor` that the user has pressed the button, after that the `Interactor` will try to request fields with the login and password
        interactor.registration({ [unowned self] (success,error) in
            // closing an alert asking to wait
            router.pleaseWait(is: false)
            if success {
                /// with a positive response from `Interactor`, a message about successful registration will be issued and a record will be made that the user agrees with the rules
                router.alertWithCongrats(visible: true)
                interactor.entity.setAgreeStatusForEmail(agree: true)
            } else {
                // if the answer is negative, an error alert will be displayed
                router.alertDisplayError?(with: error)
            }
        })
    }
    
    /// To notify `Router` to show the rules screen
    @objc fileprivate func presentTermsOfUse(_ sender: UIButton) {
        router.presentTermsOfUse()
    }
    
    // Target performed when the state of the switch changes
    @objc fileprivate func switchValueChanged(_ sender: UISwitch) {
        view.registrationButton.isEnabled = sender.isOn ? true : false
    }
    
    /// A method that performs certain actions when called `viewWillAppear`
    func viewWillAppear() {
        if view.rulesSwitch?.isOn == true {
            let status = interactor.entity.getAgreeStatusForEmail()
            view.registrationButton?.isEnabled = status
            view.rulesSwitch?.isOn = status
        }
    }
    
    /// A method that performs certain actions when called `viewDidDisappear`
    func viewDidDisappear() {
        view.rulesSwitch.isOn = false
        view.registrationButton.isEnabled = false
    }
    
    // MARK: - Configurator View
    /// Creates specific configurations for `View`
    func configureView() {
        view.rulesSwitch?.addTarget(self, action: #selector(switchValueChanged(_:)), for: .valueChanged)
        view.showRulesButton?.addTarget(self, action: #selector(presentTermsOfUse(_:)), for: .touchUpInside)
        view.registrationButton?.addTarget(self, action: #selector(registrationClicked(_:)), for: .touchUpInside)
    }
    
    // MARK: - Initialization
    
    init(view: EmailRegistrationViewProtocol) {
        self.view = view
    }
}
