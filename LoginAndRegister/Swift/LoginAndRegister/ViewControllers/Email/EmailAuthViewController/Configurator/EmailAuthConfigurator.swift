import Foundation

protocol EmailAuthConfiguratorProtocol: class {
    func configure(with viewController: EmailAuthViewController)
}

class EmailAuthConfigurator: EmailAuthConfiguratorProtocol {
    
    func configure(with viewController: EmailAuthViewController) {
        let presenter = EmailAuthPresenter(view: viewController)
        let interactor = EmailAuthInteractor(p: presenter)
        let router = EmailAuthRouter(vc: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router        
    }
}
