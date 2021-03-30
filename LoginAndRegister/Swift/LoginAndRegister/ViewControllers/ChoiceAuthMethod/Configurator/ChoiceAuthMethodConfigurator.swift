import Foundation

protocol ChoiceAuthMethodConfiguratorProtocol: class {
    func configure(with viewController: ChoiceAuthMethodViewController)
}

/// Configurator for installing components working with ChoiceAuthMethodViewController
class ChoiceAuthMethodConfigurator: ChoiceAuthMethodConfiguratorProtocol {
    func configure(with viewController: ChoiceAuthMethodViewController) {
        let presenter = ChoiceAuthMethodPresenter(view: viewController)
        let interactor = ChoiceAuthMethodInteractor(p: presenter)
        let router = ChoiceAuthMethodRouter(vc: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
