import UIKit

protocol EmailRegistrationViewProtocol: class, GetterEmailPass {
    var registrationButton: UIButton! { get }
    var showRulesButton: UIButton! { get }
    var rulesSwitch: UISwitch! { get }
}

class EmailRegistrationViewController: UIViewController, EmailRegistrationViewProtocol {
    
    fileprivate var configurator: EmailRegistrationConfiguratorProtocol!
    var presenter: EmailRegistrationPresenterProtocol!
    
    fileprivate var cornerRadius: CGFloat = 10
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var mainViewCenterYConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var showRulesButton: UIButton!
    
    @IBOutlet internal weak var registrationButton: UIButton!
    
    // MARK: - E-Mail
    
    // Let's make the email field private to prevent changing its content from outside
    @IBOutlet fileprivate weak var emailTextField: UITextField!
    func email() -> String {
        guard let email = emailTextField.text else {
            fatalError("Failed get email string!")
        }
        return email
    }
    
    // MARK: - Password
    
    // Let's make the password field private to prevent changing its content from outside
    @IBOutlet fileprivate weak var passwordTextField: UITextField!
    func password() -> String {
        guard let password = passwordTextField.text else {
            fatalError("Failed get password string!")
        }
        return password
    }
    
    func passwordLength() -> Int { return password().count }
    
    @IBOutlet internal weak var rulesSwitch: UISwitch!
    
    // MARK: - Initialization
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        configurator = EmailRegistrationConfigurator()
        configurator.configure(with: self)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - View Did Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Registration"
        
        // Registration button customization
        registrationButton?.contentEdgeInsets = .init(hr: 20, v: 10)
        registrationButton?.layer.cornerRadius = cornerRadius
        registrationButton?.backgroundColor = .systemBlue
        registrationButton?.tintColor = .white
        
        passwordTextField?.placeholder = "For instance: \(String.random(8, .all))"
    }
    
    //MARK: - View Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.configureView()
        presenter.viewWillAppear()
    }
    
    //MARK: - View Did Disappear
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
        func textFieldDeactivate(tf textField: UITextField?) {
            textField?.text = nil
            textField?.endEditing(true)
            textField?.becomeFirstResponder()
        }
        textFieldDeactivate(tf: emailTextField)
        textFieldDeactivate(tf: passwordTextField)
    }
}
