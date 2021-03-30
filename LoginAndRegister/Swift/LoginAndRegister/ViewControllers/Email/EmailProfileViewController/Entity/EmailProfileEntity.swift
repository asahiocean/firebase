import Foundation
import Firebase

protocol EmailProfileEntityProtocol {
    /// Saving the updated user configuration
    func saveAuthData(with data: AuthDataResult)
    /// Getting user configuration
    func getUser() -> User?
}

class EmailProfileEntity: EmailProfileEntityProtocol {
    
    fileprivate weak var interactor: EmailProfileInteractor?

    fileprivate var user: User?

    func getUser() -> User? {
        return user
    }

    func saveAuthData(with data: AuthDataResult) {
        self.user = data.user
    }
        
    // MARK: - Initialization
    
    init(interactor: EmailProfileInteractor) {
        self.interactor = interactor
    }
}
