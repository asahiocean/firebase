import Foundation

protocol TermsOfUseEntityProtocol: class {
    var paragraphs: [String] { get }
}

class TermsOfUseEntity: TermsOfUseEntityProtocol {
    
    static let shared = TermsOfUseEntity()
    
    var paragraphs: [String] = []
    
    init() {
        let p1 = "1. Do not do to others what you do not want to get yourself!"
        paragraphs.append(p1)
        
        let p2 = "2. Appreciate those who help you!"
        paragraphs.append(p2)
    }
}
