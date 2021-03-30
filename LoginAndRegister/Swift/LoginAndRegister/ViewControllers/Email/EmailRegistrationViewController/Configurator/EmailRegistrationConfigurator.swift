import Foundation

protocol EmailRegistrationConfiguratorProtocol: class {
    func configure(with viewController: EmailRegistrationViewController)
}

class EmailRegistrationConfigurator: EmailRegistrationConfiguratorProtocol {
    func configure(with viewController: EmailRegistrationViewController) {
        let presenter = EmailRegistrationPresenter(view: viewController)
        let interactor = EmailRegistrationInteractor(p: presenter)
        let router = EmailRegistrationRouter(vc: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
