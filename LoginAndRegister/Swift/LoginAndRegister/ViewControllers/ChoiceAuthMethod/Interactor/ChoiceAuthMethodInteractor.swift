import Foundation
import Firebase

// Interactor is a facade for other services and knows nothing about how the data will be displayed. It contains the business logic necessary for the application to work, for example, it is responsible for getting data from the Model(network or local requests) and its implementation is not related to the user interface in any way.

protocol AuthMethodDelegate {
    /// Delegate function accepting information about a new authorized method
    func newAuthorizedMethod(with method: AuthMethod)
}

protocol ChoiceAuthMethodInteractorProtocol: class, AuthMethodDelegate {
    /// This feature will give all available methods
    func methods() -> [AuthMethod]
    /// Will pass the method with the appropriate index
    func method(i index: Int) -> AuthMethod?
    /// Function passing the number of all methods
    func methodsCount() -> Int
    /// Transmits information on the selected method
    func selected(_ method: AuthMethod)
    /// Returns all available authorized methods
    func authorizedMethods() -> [AuthMethod]
    /// Check if the method is authorized
    func isAuthorized(with method: AuthMethod) -> Bool
    /// Attempting to get session data for the specified method
    func session(for method: AuthMethod) throws -> AuthDataResult?
}

class ChoiceAuthMethodInteractor: ChoiceAuthMethodInteractorProtocol {
    
    fileprivate let coredata: CoreData = .shared
    
    weak var presenter: ChoiceAuthMethodPresenterProtocol!
    
    // MARK: - Working with global methods
    
    fileprivate let allMethods: [AuthMethod]
    
    func methods() -> [AuthMethod] { allMethods }
    
    func methodsCount() -> Int { allMethods.count }
    
    func method(i: Int) -> AuthMethod? { allMethods[i] }
    
    func selected(_ method: AuthMethod) {
        print("▸ \(#function) ==>", method.title)
        Analytics.shared.report("USER", ["SELECTED METHOD":method.title])
    }
    
    // MARK: - Working with authorized methods
    
    fileprivate var authorized: [AuthMethod]
    
    func authorizedMethods() -> [AuthMethod] {
        return authorized
    }
    
    func isAuthorized(with method: AuthMethod) -> Bool {
        return authorized.contains(method)
    }
    
    func newAuthorizedMethod(with method: AuthMethod) {
        sessionUpdater()
        Analytics.shared.report("USER", ["NEW METHOD": method.title])
    }
    
    // MARK: - Sessions
    
    fileprivate var sessions: [AuthMethod:AuthDataResult?] = [:]
    
    func session(for method: AuthMethod) throws -> AuthDataResult? {
        guard let session = sessions[method] else { return nil }
        return session
    }
    
    // MARK: - Initialization
    
    fileprivate func sessionUpdater() {
        coredata.load({ [self] (firebases: [Firebase]) in
            for method in allMethods where firebases.count > 0 {
                guard let data = firebases[0][method] else { return }
                print("▸ FIREBASE_SESSION =>:", data.user.email ?? "")
                sessions.updateValue(data, forKey: method)
                if !authorized.contains(method) { authorized.append(method) }
            }
        })
    }
    
    required init(p presenter: ChoiceAuthMethodPresenterProtocol) {
        self.presenter = presenter
        allMethods = AuthMethod.allCases
        authorized = []
        sessionUpdater()
    }
}
