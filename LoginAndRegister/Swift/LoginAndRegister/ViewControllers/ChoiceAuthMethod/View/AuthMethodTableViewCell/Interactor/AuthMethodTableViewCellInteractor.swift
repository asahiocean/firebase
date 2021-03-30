import Foundation

protocol AuthMethodTableViewCellInteractorProtocol: class {
    
}

class AuthMethodTableViewCellInteractor: AuthMethodTableViewCellInteractorProtocol {
    
    weak var presenter: AuthMethodTableViewCellPresenterProtocol!
    
    required init(p presenter: AuthMethodTableViewCellPresenterProtocol) {
        self.presenter = presenter
    }
}
