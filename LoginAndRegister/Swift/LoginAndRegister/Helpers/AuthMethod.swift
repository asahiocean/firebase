import Foundation
import UIKit.UIImage

@objc public enum AuthMethod: Int, CaseIterable {
    case email
    case phone
    case google
    case playGames
    case gameCenter
    case facebook
    case twitter
    case gitHub
    case yahoo
    case microsoft
    case apple
    case anonymous
    
    var available: Bool {
        switch self {
        case .email: return true
        case .phone:
            #warning("TODO: phone")
            return false
        case .google:
            #warning("TODO: google")
            return false
        case .playGames:
            #warning("TODO: playGames")
            return false
        case .gameCenter:
            #warning("TODO: gameCenter")
            return false
        case .facebook:
            #warning("TODO: facebook")
            return false
        case .twitter:
            #warning("TODO: twitter")
            return false
        case .gitHub:
            #warning("TODO: gitHub")
            return false
        case .yahoo:
            #warning("TODO: yahoo")
            return false
        case .microsoft:
            #warning("TODO: microsoft")
            return false
        case .apple:
            #warning("TODO: apple")
            return false
        case .anonymous:
            #warning("TODO: anonymous")
            return false
        }
    }
    
    var title: String {
        switch self {
        case .email: return "E-Mail"
        case .phone: return "Phone"
        case .google: return "Google"
        case .playGames: return "Play Games"
        case .gameCenter: return "Game Center"
        case .facebook: return "Facebook"
        case .twitter: return "Twitter"
        case .gitHub: return "GitHub"
        case .yahoo: return "Yahoo"
        case .microsoft: return "Microsoft"
        case .apple: return "Apple"
        case .anonymous: return "Anonymous"
        }
    }
    
    var image: UIImage {
        switch self {
        case .email: return #imageLiteral(resourceName: "email")
        case .phone: return #imageLiteral(resourceName: "phone")
        case .google: return #imageLiteral(resourceName: "google")
        case .playGames: return #imageLiteral(resourceName: "playGames")
        case .gameCenter: return #imageLiteral(resourceName: "gameCenter")
        case .facebook: return #imageLiteral(resourceName: "facebook")
        case .twitter: return #imageLiteral(resourceName: "twitter")
        case .gitHub: return #imageLiteral(resourceName: "gitHub")
        case .yahoo: return #imageLiteral(resourceName: "yahoo")
        case .microsoft: return #imageLiteral(resourceName: "microsoft")
        case .apple: return #imageLiteral(resourceName: "apple")
        case .anonymous: return #imageLiteral(resourceName: "anonymous")
        }
    }
}
