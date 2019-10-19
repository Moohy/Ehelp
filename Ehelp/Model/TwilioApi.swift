import Foundation
import UIKit


class TwilioApi
{
    let session = URLSession.shared

    func sendReport(with body: String)
    {
        let SID = "AC58a35a6192706ebdf5900cd64653550a"
        let secret = "f38d7fa46d4470061be7d13276e599f5"
        let from = "+12055259360"
        let to = "+61478110131"
        
        let message = "\(body)"
        
        if let url = URL(string: "https://\(SID):\(secret)@api.twilio.com/2010-04-01/Accounts/\(SID)/Messages.json")
        {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = NSMutableData(data: "From=\(from)&To=\(to)&Body=\(message)".data(using: .utf8)!) as Data
            sendSMS(request, element: "results")
        }
    }
    
    private func sendSMS(_ request: URLRequest, element: String)
    {
        let task = session.dataTask(with: request, completionHandler: {
            data, response, downloadError in
            
            if downloadError != nil {
                print(downloadError)
            }
            if let data = data, let responseDetails = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                // Success
                print("Response: \(responseDetails)")
                
            }

        })
        task.resume()
        
    }

    
    static let sharedInstance = TwilioApi()
    private init(){

        let session = URLSession.shared
    }
    
}

