import Foundation
import Firebase

protocol EmailProfileInteractorProtocol {
    /// Method to install or update authorization data
    func setAuthData(with data: AuthDataResult)
    /// Method for getting user configuration
    func getUserConfig(_ completion: @escaping ((User?) -> Void))
}

class EmailProfileInteractor: EmailProfileInteractorProtocol {
    
    private weak var presenter: EmailProfilePresenterProtocol!
    fileprivate var entity: EmailProfileEntityProtocol?
        
    func setAuthData(with data: AuthDataResult) {
        entity?.saveAuthData(with: data)
    }
    
    func getUserConfig(_ completion: @escaping ((User?) -> Void)) {
        let user = entity?.getUser()
        completion(user)
    }
        
    // MARK: - Initialization
    
    required init(p presenter: EmailProfilePresenterProtocol) {
        self.presenter = presenter
        self.entity = EmailProfileEntity(interactor: self)
    }
}
