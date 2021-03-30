import UIKit
import Firebase

protocol EmailProfileViewProtocol: class {
    func setterEmail(with email: String?)
    func getterEmail() -> String
}

class EmailProfileViewController: UIViewController, EmailProfileViewProtocol, AuthDataDelegate {
    
    fileprivate var configurator: EmailProfileConfiguratorProtocol!
    var presenter: EmailProfilePresenterProtocol!
    
    @IBOutlet weak var refreshButton: UIButton!
    @IBAction func refreshButtonAction(_ sender: UIButton) {
        presenter.configureView()
    }
    
    func authData(with authdata: AuthDataResult) {
        presenter.saveAuthData(with: authdata)
        presenter.configureView()
    }
    
    @IBOutlet fileprivate weak var emailStackView: UIStackView!
    @IBOutlet fileprivate weak var emailLabel: UILabel!
    func setterEmail(with email: String?) {
        DispatchQueue.main.async { [weak self] in
            self?.emailStackView?.isHidden = false
            self?.emailLabel?.text = email
        }
    }
    func getterEmail() -> String {
        guard let email = emailLabel?.text else {
            fatalError("Failed to get email string")
        }
        return email
    }
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        configurator = EmailProfileConfigurator()
        configurator.configure(with: self)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.configureView()
        emailStackView.isHidden = true
    }
}
