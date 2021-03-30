import Foundation

protocol TermsOfUseConfiguratorProtocol: class {
    func configure(with viewController: TermsOfUseViewController)
}

class TermsOfUseConfigurator: TermsOfUseConfiguratorProtocol {
    func configure(with viewController: TermsOfUseViewController) {
        let presenter = TermsOfUsePresenter(view: viewController)
        let interactor = TermsOfUseInteractor(p: presenter)
        let router = TermsOfUseRouter(vc: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
