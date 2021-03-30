import Foundation

protocol AuthMethodTableViewCellConfiguratorProtocol: class {
    func configure(with cell: AuthMethodTableViewCell)
}

class AuthMethodTableViewCellConfigurator: AuthMethodTableViewCellConfiguratorProtocol {
    func configure(with cell: AuthMethodTableViewCell) {
        let presenter = AuthMethodTableViewCellPresenter(view: cell)
        let interactor = AuthMethodTableViewCellInteractor(p: presenter)

        cell.presenter = presenter
        presenter.interactor = interactor
    }
}
