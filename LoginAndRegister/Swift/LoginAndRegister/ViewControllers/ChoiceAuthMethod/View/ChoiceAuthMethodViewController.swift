import UIKit
import Firebase

// View/ViewController is not responsible for the logic of button clicks, text input, or any other interaction with the UI.
// All this is immediately passed to the Presenter.

// ViewController doesn't know what to do after clicking on the buttons, but it knows exactly what to do when it has a method called from ChoiceAuthMethodViewProtocol.
// ViewController only updates, moves, repaints, hides UI elements based on the data with which the Presenter called this method.
// At the same time, the presenter does not know exactly how all this data is located in the View/ViewController.

// View/ViewController -> Presenter

protocol ChoiceAuthMethodViewProtocol: class {
    /// Method for setting configuration for `UITableView`
    func tableViewConfig(tv tableView: UITableView)
    /// Function to reload the list
    func reloadList()
    func isAuthorized(with method: AuthMethod) -> Bool
    func authData(for method: AuthMethod, _ completion: @escaping ((AuthDataResult?) -> ()) )
}

class ChoiceAuthMethodViewController: UIViewController, ChoiceAuthMethodViewProtocol {
    
    fileprivate var configurator: ChoiceAuthMethodConfiguratorProtocol!
    var presenter: ChoiceAuthMethodPresenterProtocol!
    
    fileprivate weak var tableView: UITableView!
    
    // MARK: - Protocols methods
    
    func tableViewConfig(tv tableview: UITableView) {
        tableview.tableFooterView = .init()
        tableview.frame.size = view.frame.size
        tableview.rowHeight = tableview.frame.height / 20
        view.addSubview(tableview)
        self.tableView = tableview
        tableView?.delegate = self
        tableView?.dataSource = self
    }
    
    func reloadList() {
        tableView?.reloadData()
    }
    
    func isAuthorized(with method: AuthMethod) -> Bool {
        return presenter.interactor.isAuthorized(with: method)
    }
    
    func authData(for method: AuthMethod, _ completion: @escaping ((AuthDataResult?) -> ())) {
        do {
            let info = try presenter.interactor.session(for: method)
            completion(info)
        } catch let error as NSError {
            completion(nil)
            print("▸\(#function) error:", error.localizedDescription)
        }
    }
    
    // MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Firebase Authentication"
        configurator = ChoiceAuthMethodConfigurator()
        configurator.configure(with: self)
        presenter.configureView()
    }
}

// MARK: - Table View

extension ChoiceAuthMethodViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.interactor.methodsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AuthMethodTableViewCell.id, for: indexPath) as! AuthMethodTableViewCell
        if let method = presenter.interactor.method(i: indexPath.row) {
            cell.presenter.config(with: method)
            cell.authorized(with: isAuthorized(with: method))
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let method = presenter.interactor.method(i: indexPath.row) {
            presenter.selectedMethod(with: method)
        } else {
            let alert = presenter.alertMethodNotAvailable()
            self.present(alert, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
