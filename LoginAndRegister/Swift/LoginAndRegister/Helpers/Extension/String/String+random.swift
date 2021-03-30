import Foundation

extension String {
    enum Symbols: String, CaseIterable {
        case letters
        case LETTERS
        case numbers
        case all
        var value: String {
            switch self {
            case .letters:
                return "abcdefghijklmnopqrstuvwxyz"
            case .LETTERS:
                return "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
            case .numbers:
                return "0123456789"
            case .all:
                return Self.letters.value + Self.LETTERS.value + Self.numbers.value
            }
        }
        
    }
    static func random(_ count: Int, _ symbols: Symbols) -> String {
        return String((0..<count).shuffled().map{ _ in symbols.value.randomElement()! })
    }
}
