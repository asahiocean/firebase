import Foundation
import Firebase

protocol EmailRegistrationInteractorProtocol {
    var entity: EmailRegistrationEntityProtocol! { get }
    func registration(_ success: @escaping (Bool, Error?) -> ())
}

class EmailRegistrationInteractor: EmailRegistrationInteractorProtocol {
    
    weak var entity: EmailRegistrationEntityProtocol!
    fileprivate weak var presenter: EmailRegistrationPresenterProtocol!
    
    func registration(_ success: @escaping (Bool, Error?) -> ()) {
        do {
            let email = try presenter.registerEmail()
            let password = try presenter.registerPassword()
            Auth.auth().createUser(withEmail: email, password: password) { (result: AuthDataResult?, error: Error?) in
                guard error == nil else { success(false, error); return }
                
                if let _ = result {
                    success(true, error)
                    Keychain.shared.save(password, key: email)
                    self.presenter.delegate?.emailDelegate(email)
                } else {
                    fatalError()
                }
            }
        } catch {
            #warning("TODO: PRESENTER ALERT")
            print("▸ \(#function):", error.localizedDescription)
        }
    }
    
    // MARK: - Initialization
    
    required init(p presenter: EmailRegistrationPresenterProtocol) {
        self.presenter = presenter
        self.entity = EmailRegistrationEntity.shared
    }
}
