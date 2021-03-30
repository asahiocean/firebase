import UIKit

/// Navigation Controller is responsible for the transitions between screens when choosing authorization using email
class EmailAuthNavigationController: UINavigationController {
    
    weak var notify: DismissDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // some methods...
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isBeingDismissed { notify?.dismissed() }
    }
    
    // MARK: - Initialization
    
    convenience init(root: UIViewController) {
        self.init(rootViewController: root)
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        navigationItem.largeTitleDisplayMode = .always
        navigationBar.prefersLargeTitles = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
