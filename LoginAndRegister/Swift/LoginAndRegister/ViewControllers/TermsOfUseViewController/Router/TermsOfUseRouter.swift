import Foundation

protocol TermsOfUseRouterProtocol: class {
    var viewController: TermsOfUseViewController! { get }
}

class TermsOfUseRouter: TermsOfUseRouterProtocol {
    
    weak var viewController: TermsOfUseViewController!
    
    init(vc viewController: TermsOfUseViewController) {
        self.viewController = viewController
    }
}
