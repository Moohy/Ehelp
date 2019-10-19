import Foundation

// current date model
struct CurrentDate {
    
    // set date function to set the current date
    func setDate() -> String{
        // call Date object
        let date = Date()
        // call date formatter object
        let formatter = DateFormatter()
        // set the desired format
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        // return the current date in the desired format
        return formatter.string(from: date)
        
    }
}
