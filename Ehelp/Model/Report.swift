import Foundation
import MapKit

enum Emergency: String {
    case    police = "Police",
            fireFighter = "Fire Fighter",
            ambulance = "Ambulance"
}

struct Report: Codable {
    var emergencyType:  String! 
    var latitude:       Double!
    var longitude:      Double!
    var message:        String!
    var date:    String!

    mutating func setDate(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm"
        self.date = formatter.string(from: date)
    }
}
