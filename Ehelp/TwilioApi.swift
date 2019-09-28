import Foundation

class TwilioApi{
    static func sendSMS(with body: ReportViewModel, completion: @escaping ([String: Any]?, Error?)->()){
        let SID = "AC58a35a6192706ebdf5900cd64653550a"
        let secret = "f38d7fa46d4470061be7d13276e599f5"
        let from = "+12055259360"
        let to = "+61478110131"
        
        let message = "\(body.getEmergency()) - \(body.getMessage()) - Location: \(body.latitude()), \(body.longitude())"
        
            // REQUEST and HEADER info
            var req = URLRequest(url: URL(string: "https://\(SID):\(secret)@api.twilio.com/2010-04-01/Accounts/\(SID)/Messages.json")!)
            req.httpMethod = "POST"
        
            req.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            // REQUEST BODY
        req.httpBody = NSMutableData(data: "From=\(from)&To=\(to)&Body=\(message)".data(using: .utf8)!) as Data
            
            let task = URLSession.shared.dataTask(with: req) { data, response, error in
                if error != nil {
                    completion(nil, error)
                    return
                }
                if let data = data, let responseDetails = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    // Success
                    print("Response: \(responseDetails)")

                }
                
            }
            task.resume()
        }
}
