import UIKit

// Presenter decides whether to redirect the action to the Router or Interactor.
// Router will either close the current screen or open a new one. The specific implementation of the transition is carried out in it.
// The more important function of the Presenter is to prepare and pass visual data to the View/ViewController that will be visible to the user. Presenter is the heart of our module, it knows what data will be displayed and in what form.

// Presenter -> Router || Interactor

protocol ChoiceAuthMethodPresenterProtocol: class {
    var router: ChoiceAuthMethodRouterProtocol! { get set }
    var interactor: ChoiceAuthMethodInteractorProtocol! { get }
    func configureView()
    /// Sends information about a user-selected method
    func selectedMethod(with method: AuthMethod)
    func alertMethodNotAvailable() -> UIAlertController
}

class ChoiceAuthMethodPresenter: ChoiceAuthMethodPresenterProtocol {
    
    weak var view: ChoiceAuthMethodViewProtocol!
    var interactor: ChoiceAuthMethodInteractorProtocol!
    var router: ChoiceAuthMethodRouterProtocol!
    
    func configureView() {
        let tableView = UITableView()
        tableView.register(AuthMethodTableViewCell.nib, forCellReuseIdentifier: AuthMethodTableViewCell.id)
        view.tableViewConfig(tv: tableView)
    }
    
    // MARK: - Working with methods
    
    @objc func selectedMethod(with method: AuthMethod) {
        router.methodViewController(for: method)
        interactor.selected(method)
    }
    
    func alertMethodNotAvailable() -> UIAlertController {
        let alert = UIAlertController(title: "Oops...", message: "This method seems to be unavailable, please try another", preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel))
        return alert
    }
    
    // MARK: - Initialization
    
    init(view: ChoiceAuthMethodViewProtocol) {
        self.view = view
    }
}
