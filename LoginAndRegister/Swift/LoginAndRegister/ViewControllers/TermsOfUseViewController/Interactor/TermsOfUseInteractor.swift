import Foundation

protocol TermsOfUseInteractorProtocol {
    var entity: TermsOfUseEntityProtocol! { get }
    var presenter: TermsOfUsePresenterProtocol! { get }
}

class TermsOfUseInteractor: TermsOfUseInteractorProtocol {
    
    weak var entity: TermsOfUseEntityProtocol!
    weak var presenter: TermsOfUsePresenterProtocol!
    
    required init(p presenter: TermsOfUsePresenterProtocol) {
        self.presenter = presenter
        self.entity = TermsOfUseEntity.shared
    }
}
