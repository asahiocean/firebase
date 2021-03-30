import UIKit

protocol AuthMethodTableViewCellViewProtocol: class {
    var method: AuthMethod! { get }
    func method(with method: AuthMethod?)
    func setImage(image: UIImage?)
    func setTitle(with label: String?)
    func availability(with status: Bool?)
    func authorized(with status: String)
    func authorized(with status: Bool)
}

class AuthMethodTableViewCell: UITableViewCell, AuthMethodTableViewCellViewProtocol {
    
    var method: AuthMethod!
    
    fileprivate var configurator: AuthMethodTableViewCellConfiguratorProtocol!
    var presenter: AuthMethodTableViewCellPresenterProtocol!
    
    func method(with method: AuthMethod?) {
        guard let method = method else { return }
        self.method = method
    }

    @IBOutlet fileprivate weak var logoImageView: UIImageView!
    func setImage(image: UIImage?) {
        logoImageView?.image = image
    }
    
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    func setTitle(with label: String?) {
        titleLabel?.text = label
    }

    @IBOutlet fileprivate weak var statusLabel: UILabel!
    func availability(with status: Bool?) {
        guard let valid = status else { return }
        logoImageView.alpha = valid ? 1.0 : 0.5
        statusLabel.alpha = logoImageView.alpha
        if valid {
            statusLabel.text = "Available"
        } else {
            statusLabel.text = "Not available"
        }
    }
    
    func authorized(with status: Bool) {
        if status {
            statusLabel.text = "Authorized"
        } else {
            statusLabel.text = "Not authorized"
        }
    }
    
    func authorized(with status: String) {
        statusLabel.text = status
    }
    
    fileprivate func viperConfigurator() {
        configurator = AuthMethodTableViewCellConfigurator()
        configurator.configure(with: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viperConfigurator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        viperConfigurator()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
