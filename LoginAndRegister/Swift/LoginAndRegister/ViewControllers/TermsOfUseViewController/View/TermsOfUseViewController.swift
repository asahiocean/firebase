import UIKit

protocol TermsOfUseViewProtocol: class {
    func textViewConfig(tv textView: UITextView)
}

class TermsOfUseViewController: UIViewController, TermsOfUseViewProtocol {
    
    public static let shared = TermsOfUseViewController()
    
    fileprivate var configurator: TermsOfUseConfiguratorProtocol!
    var presenter: TermsOfUsePresenterProtocol!
    
    func textViewConfig(tv textView: UITextView) {
        textView.frame = view.frame
        textView.contentInset = .init(hr: 10, v: 10)
        
        textView.backgroundColor = .white
        
        textView.font = .systemFont(ofSize: textView.bounds.width.squareRoot())
        
        textView.textColor = .black
        textView.isEditable = false
        view.addSubview(textView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator = TermsOfUseConfigurator()
        configurator.configure(with: self)
        presenter.configureView()
        
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
    }
}
