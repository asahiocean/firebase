import Foundation
import CoreData
import Firebase

extension Firebase {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Firebase> {
        return NSFetchRequest<Firebase>(entityName: "Firebase")
    }
    
    @NSManaged public var email: AuthDataResult?
    @NSManaged public var phone: AuthDataResult?
    @NSManaged public var google: AuthDataResult?
    @NSManaged public var playgames: AuthDataResult?
    @NSManaged public var gamecenter: AuthDataResult?
    @NSManaged public var facebook: AuthDataResult?
    @NSManaged public var twitter: AuthDataResult?
    @NSManaged public var github: AuthDataResult?
    @NSManaged public var yahoo: AuthDataResult?
    @NSManaged public var microsoft: AuthDataResult?
    @NSManaged public var apple: AuthDataResult?
    @NSManaged public var anonymous: AuthDataResult?
    
    subscript(_ method: AuthMethod) -> AuthDataResult? {
        switch method {
        case .email: return email
        case .phone: return phone
        case .google: return google
        case .playGames: return playgames
        case .gameCenter: return gamecenter
        case .facebook: return facebook
        case .twitter: return twitter
        case .gitHub: return github
        case .yahoo: return yahoo
        case .microsoft: return microsoft
        case .apple: return apple
        case .anonymous: return anonymous
        }
    }
}
