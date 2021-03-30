import Foundation
import UIKit

protocol TermsOfUsePresenterProtocol: class {
    var router: TermsOfUseRouterProtocol! { set get }
    func configureView()
}

class TermsOfUsePresenter: TermsOfUsePresenterProtocol {

    weak var view: TermsOfUseViewProtocol!
    var interactor: TermsOfUseInteractorProtocol!
    var router: TermsOfUseRouterProtocol!
    
    init(view: TermsOfUseViewProtocol) {
        self.view = view
    }
    
    func configureView() {
        let textView = UITextView()
        textView.text = interactor.entity.paragraphs.joined(separator: "\n")
        view.textViewConfig(tv: textView)
    }
}
