import Foundation

protocol EmailRegistrationEntityProtocol: class {
    var defaults: UserDefaults { get }
    func getAgreeStatusForEmail() -> Bool
    func setAgreeStatusForEmail(agree: Bool)
}

class EmailRegistrationEntity: EmailRegistrationEntityProtocol {
    
    static let shared = EmailRegistrationEntity()
    
    var defaults: UserDefaults
    
    //MARK: - Agree Status For Email
    
    fileprivate var agreeStatusForEmail = "agreeStatusForEmail"
    
    /// To request from the `UserDefaults` state about the user's agreement with the rules
    func getAgreeStatusForEmail() -> Bool {
        let status = UserDefaults.standard.bool(forKey: agreeStatusForEmail)
        return status
    }
    /// To save the state in `UserDefaults` that the user has agreed to the rules
    func setAgreeStatusForEmail(agree: Bool) {
        UserDefaults.standard.set(agree, forKey: agreeStatusForEmail)
        UserDefaults.standard.synchronize()
    }
    
    // MARK: - Initialization
    
    init() {
        self.defaults = UserDefaults.standard
    }
}
