import Foundation
import Firebase

protocol EmailProfilePresenterProtocol: class {
    func configureView()
    func saveAuthData(with authdata: AuthDataResult)
}

class EmailProfilePresenter: EmailProfilePresenterProtocol {
    
    weak var view: EmailProfileViewProtocol!
    var interactor: EmailProfileInteractorProtocol!
    var router: EmailProfileRouterProtocol!
    
    func configureView() {
        interactor.getUserConfig({ [view] user in
            view?.setterEmail(with: user?.email)
        })
    }
    
    func saveAuthData(with authdata: AuthDataResult) {
        interactor.setAuthData(with: authdata)
    }
    
    // MARK: - Initialization
    
    init(view: EmailProfileViewProtocol) {
        self.view = view
    }
}
