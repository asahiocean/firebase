import Foundation
import Firebase

protocol EmailAuthInteractorProtocol: class {
    func authorization(_ success: @escaping (Bool, Error?) -> ())
}

class EmailAuthInteractor: EmailAuthInteractorProtocol {
    
    private weak var presenter: EmailAuthPresenterProtocol!
    fileprivate let coredata = CoreData.shared
    
    func authorization(_ success: @escaping (Bool, Error?) -> ()) {
        let email = presenter.email()
        let password = presenter.password()
        Auth.auth().signIn(withEmail: email, password: password) { (result: AuthDataResult?, error: Error?) in
            guard error == nil else {
                success(false, error)
                return
            }
            if let result = result {
                self.coredata.save(m: .email, with: result)
                success(true, error)
            } else {
                fatalError("WTF???")
            }
        }
    }
    
    required init(p presenter: EmailAuthPresenterProtocol) {
        self.presenter = presenter
    }
}
