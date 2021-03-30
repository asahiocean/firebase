import Foundation

extension Array where Element == String {
    static let symbols: Self = {
        let n = "0123456789".map({String($0)})
        let l = "abcdefghijklmnopqrstuvwxyz".map({String($0)})
        let L = l.map({ $0.uppercased() })
        return l + L + n
    }()
}
