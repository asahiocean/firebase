import Foundation

protocol AuthMethodTableViewCellPresenterProtocol: class {
    func config(with method: AuthMethod?)
}

class AuthMethodTableViewCellPresenter: AuthMethodTableViewCellPresenterProtocol {
        
    weak var view: AuthMethodTableViewCellViewProtocol!
    var interactor: AuthMethodTableViewCellInteractorProtocol!

    // MARK: - Config setup
    
    func config(with method: AuthMethod?) {
        view.method(with: method)
        view.setImage(image: method?.image)
        view.setTitle(with: method?.title)
        view.availability(with: method?.available)
    }
        
    // MARK: - Initialization
    
    init(view: AuthMethodTableViewCellViewProtocol) {
        self.view = view
    }
}
