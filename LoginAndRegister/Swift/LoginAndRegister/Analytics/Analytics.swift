import Foundation

class Analytics {
    public static let shared = Analytics()
    
    func report(_ key: String, _ value: Any) {
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + 1.0, execute: {
            let url = URL(string: "https://ptsv2.com/t/asahiocean_firebaseauth/post")!
            let request = NSMutableURLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: .zero)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            let user = "Zj5PEhPZyZGPZp9WC6grJVIREIFpOHRw"
            let pass = "o6ZArZhtq9ZvNvtPLXK9FwO7pK7L6TOQ"
            
            let loginStr = String(format: "%@:%@", user, pass).data(using: .utf8)!
            let basic = "Basic \(loginStr.base64EncodedString())"
            request.setValue(basic, forHTTPHeaderField: "Authorization")
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: [key:value], options: [.prettyPrinted])
                URLSession.shared.dataTask(with: request as URLRequest) { data,_,_ in
                    guard let data = data else { return }
                    if let str = String(data: data, encoding: .utf8) { print("▸ Analytics => \(#function):", str) }
                }.resume()
            } catch {
                print(error.localizedDescription)
            }
        })
    }
    
    fileprivate init() {
        
    }
}
