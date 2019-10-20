import Foundation
import UIKit


class TwilioApi
{
    let session = URLSession.shared
    
    var delegate: ViewModelDelegate?

    func sendReport(with body: String)
    {
        // api configiration
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
            sendSMS(request)
        }
    }
    
    private func sendSMS(_ request: URLRequest)
    {
        self.delegate?.willLoadData()
        
        let task = session.dataTask(with: request, completionHandler: {
            data, response, downloadError in
            
            if downloadError != nil {
                // unsuccessful submission
                DispatchQueue.main.async(execute:{
                    self.delegate?.didLoadData(title: "Unsuccessfull Submission", message: "Something went wrong!", isSuccessful: false)
                })
            }
            if let data = data, let responseDetails = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                var parsedResult: Any! = nil
                do
                {
                    parsedResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)
                }
                catch{
                }
                
                let result = parsedResult as! [String:Any]

                if let code = result["code"] {
                    // unsuccessful submission
                    DispatchQueue.main.async(execute:{
                        self.delegate?.didLoadData(title: "Unsuccessfull Submission", message: "Something went wrong!", isSuccessful: false)
                    })
                } else {
                    // successful submission
                    DispatchQueue.main.async(execute:{
                        self.delegate?.didLoadData(title: "Seccussfull Submission", message: "Report has been filed successfully", isSuccessful: true)
                    })
                }
            }
        })
        task.resume()
        
    }
    
    static let sharedInstance = TwilioApi()
    private init(){

        let session = URLSession.shared
    }
}

