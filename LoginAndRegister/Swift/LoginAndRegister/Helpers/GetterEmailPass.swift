import Foundation

public protocol GetterEmailPass {
    /// Sends the contents of the **e-mail** field to the desired location on further call
    func email() -> String
    /// Sends the contents of the **password** field to the desired location on further call
    func password() -> String
    /// Will transfer the number of characters contained in the password field
    func passwordLength() -> Int
    
    // func getEmail(_ completion: @escaping (String) -> ()) throws
    // func getPassword(_ completion: @escaping () -> ()) throws
}
