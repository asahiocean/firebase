import Foundation
import UIKit

protocol EmailAuthPresenterProtocol: class {
    func email() -> String
    func password() -> String
    func configureView()
}

class EmailAuthPresenter: EmailAuthPresenterProtocol {
    
    weak var view: EmailAuthViewProtocol!
    var interactor: EmailAuthInteractorProtocol!
    var router: EmailAuthRouterProtocol!
    
    //MARK: - Registration Button
    @objc fileprivate func registerButtonClicked(_ sender: UIButton) {
        sender.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .curveEaseOut], animations: {
            sender.transform = CGAffineTransform.identity
        }, completion: { [router] _ in
            // After the animation, the button will call the method in the Presenter to go to the registration screen
            router?.presentRegisterScreen()
            Analytics.shared.report("USER", ["ACTION":#function])
        })
    }
    
    //MARK: - Login Button
    @objc fileprivate func loginButtonClicked() {
        router.pleaseWait(is: true)
        interactor.authorization({ [unowned self] success, error in
            router?.pleaseWait(is: false)
            if success {
                view.delegate?.newAuthorizedMethod(with: .email)
                router.successAuth()
            } else {
                router.alertDisplayError?(with: error)
            }
        })
    }
    
    //MARK: - Information Button
    @objc fileprivate func infoButtonClicked() {
        router.informationHint()
        Analytics.shared.report("USER", ["ACTION":#function])
    }
    
    //MARK: - Forgot password button
    @objc fileprivate func forgotPasswordButtonClicked() {
        let alert = UIAlertController(title: "Oops...",
                                      message: "The function is temporarily unavailable, for assistance you can contact support service or developer",
                                      preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel))
        view.alertIsNotAvailable(alert: alert)
    }
    
    func email() -> String { return view.email() }
    
    func password() -> String { return view.password() }
    
    //MARK: - Configuration View
    
    func configureView() {
        view.loginButton?.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
        view.forgotPasswordButton?.addTarget(self, action: #selector(forgotPasswordButtonClicked), for: .touchUpInside)
        view.registrationButton?.addTarget(self, action: #selector(registerButtonClicked(_:)), for: .touchUpInside)
        view.infoButton?.addTarget(self, action: #selector(infoButtonClicked), for: .touchUpInside)
    }
    
    // MARK: - Initialization
    
    init(view: EmailAuthViewProtocol) {
        self.view = view
    }
}
