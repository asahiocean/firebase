import Foundation

extension String {
    public var letters: String {
        String(unicodeScalars.filter(CharacterSet.letters.contains))
    }
}
