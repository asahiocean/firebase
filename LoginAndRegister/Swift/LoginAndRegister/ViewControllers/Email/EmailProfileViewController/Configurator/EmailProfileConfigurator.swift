import Foundation

protocol EmailProfileConfiguratorProtocol: class {
    func configure(with viewController: EmailProfileViewController)
}

class EmailProfileConfigurator: EmailProfileConfiguratorProtocol {
    
    func configure(with viewController: EmailProfileViewController) {
        let presenter = EmailProfilePresenter(view: viewController)
        let interactor = EmailProfileInteractor(p: presenter)
        let router = EmailProfileRouter(vc: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
