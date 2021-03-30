import UIKit

protocol EmailAuthViewProtocol: class, GetterEmailPass {
    /// Button to confirm authorization
    var loginButton: UIButton! { get }
    /// Password recovery button
    var forgotPasswordButton: UIButton! { get }
    /// Optional button for registration
    var registrationButton: UIButton? { get }
    /// Optional button for displaying any information on the screen
    var infoButton: UIButton? { get }
    /// Method for displaying an alert with any content
    func alertIsNotAvailable(alert: UIAlertController)
    /// A delegate to pass information about the selected authorization method
    var delegate: AuthMethodDelegate? { get set }
}

class EmailAuthViewController: UIViewController, EmailAuthViewProtocol {
    
    fileprivate var configurator: EmailAuthConfiguratorProtocol!
    var presenter: EmailAuthPresenterProtocol!
    
    var delegate: AuthMethodDelegate?
    
    fileprivate var cornerRadius: CGFloat = 10
    
    @IBOutlet fileprivate weak var mainView: UIView!
    @IBOutlet weak var mainViewCenterYConstraint: NSLayoutConstraint!
    
    // MARK: - E-mail
    
    @IBOutlet fileprivate weak var emailTextField: UITextField!
    func email() -> String {
        guard let email = emailTextField.text else {
            fatalError("Failed get email string!")
        }
        return email
    }
    
    // MARK: - Password
    
    @IBOutlet fileprivate weak var passwordTextField: UITextField!
    func password() -> String {
        guard let password = passwordTextField.text else {
            fatalError("Failed get password string!")
        }
        return password
    }
    
    func passwordLength() -> Int { return password().count }
    
    // MARK: - Forgot password
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    func alertIsNotAvailable(alert: UIAlertController) {
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Buttons
    weak var infoButton: UIButton?
    
    @IBOutlet weak var loginButton: UIButton!
    
    var registrationButton: UIButton?
    
    // MARK: - Initialization
    
    convenience init() {
        self.init(nibName: nil, bundle: nil)
        configurator = EmailAuthConfigurator()
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
        title = "E-Mail Authorization"
        
        loginButton?.contentEdgeInsets = .init(hr: 30, v: 15)
        loginButton?.layer.cornerRadius = cornerRadius
        loginButton?.tintColor = .white
        loginButton?.backgroundColor = .systemBlue
        
        mainView?.layer.cornerRadius = cornerRadius
        mainView?.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.25)
        
        let regButton = UIButton()
        regButton.setTitle("Registration", for: .normal)
        regButton.contentEdgeInsets = .init(hr: 10, v: 5)
        regButton.layer.cornerRadius = cornerRadius
        regButton.backgroundColor = #colorLiteral(red: 0.9096776247, green: 0.4200070202, blue: 0.5918607116, alpha: 1)
        navigationItem.rightBarButtonItem = .init(customView: regButton)
        self.registrationButton = regButton
        
        let infoButton = UIButton(type: .infoLight)
        navigationItem.leftBarButtonItem = .init(customView: infoButton)
        self.infoButton = infoButton
    }
    
    //MARK: - View Will Appear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.configureView()
        keyboardVisibilityObserver()
    }
}

extension EmailAuthViewController: EmailRegistrationDelegate {
    func emailDelegate(_ email: String) {
        if let password = Keychain.shared.retrive(key: email) {
            emailTextField?.text = email
            passwordTextField.text = password
        }
    }
}
