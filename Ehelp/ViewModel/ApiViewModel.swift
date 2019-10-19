import Foundation

class ApiViewModel: ViewModelType{
    private var api = TwilioApi.sharedInstance
    
    var delegate: ViewModelDelegate?
    
    func pass(reqBody: String) {
        api.sendReport(with: reqBody)
    }

}
