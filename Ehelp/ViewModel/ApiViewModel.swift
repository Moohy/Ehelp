import Foundation

// api view model
class ApiViewModel{
    
    // initialize api model
    private var api = TwilioApi.sharedInstance
    
    // computed variable using view model delegate
    var delegate: ViewModelDelegate?{
        get{
            // return instance of the delegate
            return api.delegate
        }
        // set value
        set (value)
        {
            // assign value to api delegate
            api.delegate = value
        }
    }
    
    // send sms message to phone number passed as parameter
    func sendSMS(reqBody: String) {
        // call model send report function
        api.sendReport(with: reqBody)
    }
}
