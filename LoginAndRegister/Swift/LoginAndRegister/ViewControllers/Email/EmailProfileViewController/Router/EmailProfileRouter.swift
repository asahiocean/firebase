import Foundation

protocol EmailProfileRouterProtocol: class {
    
}

class EmailProfileRouter: EmailProfileRouterProtocol {
    
    fileprivate let mainscreen: EmailProfileViewController
    
    init(vc viewController: EmailProfileViewController) {
        self.mainscreen = viewController
        
    }
}
