import Foundation

class TwilioApi{
    static func sendSMS(with body: ReportViewModel, completion: @escaping ([String: Any]?, Error?)->()){
        let SID = "AC58a35a6192706ebdf5900cd64653550a"
        let secret = "f38d7fa46d4470061be7d13276e599f5"
        let from = "+12055259360"
        let to = "+61466636990"
        
        let message = "Test \(body.getEmergency()) - \(body.getMessage()) - Location: \(body.latitude()), \(body.longitude())"
        
            // REQUEST and HEADER info
            var req = URLRequest(url: URL(string: "https://\(SID):\(secret)@api.twilio.com/2010-04-01/Accounts/\(SID)/Messages.json")!)
            req.httpMethod = "POST"
        
//            req.addValue("application/json", forHTTPHeaderField: "Accept")
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
        
//        static func delSession(completion: @escaping (Error?) -> ()){
//            var req = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
//            req.httpMethod = "DELETE"
//            var xsrfCookie: HTTPCookie? = nil
//            let sharedCookieStorage = HTTPCookieStorage.shared
//            for cookie in sharedCookieStorage.cookies! {
//                if cookie.name == "XSRF-TOKEN"{
//                    xsrfCookie = cookie
//                }
//            }
//            if let xsrfCookie = xsrfCookie {
//                req.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
//            }
//
//            let task = URLSession.shared.dataTask(with: req) { data, response, error in
//                if error != nil {
//                    completion(error)
//                    return
//                }
//                let range = (5..<data!.count)
//                let newData = data?.subdata(in: range)
//                completion(nil)
//            }
//            task.resume()
//        }
        
    



}
