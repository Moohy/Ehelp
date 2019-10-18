//import Foundation
//import MapKit
//
//struct ReportViewModel {
//
//    private var report: Report = Report()
//
//    mutating func addEmergency(type: Emergency){
//        let emergency: String = type.rawValue
//        report.emergencyType = emergency
//    }
//
//    mutating func addLocation(lat: Double, long: Double){
//        report.latitude = lat
//        report.longitude = long
//    }
//
//    mutating func addMessage(msg: String){
//        report.message = msg
//    }
//
//    mutating func addDate(){
//        report.setDate()
//    }
//
//    func getEmergency() -> String{
//        return report.emergencyType
//    }
//
//    func getMessage() -> String{
//        return report.message
//    }
//
//    func getDate() -> String {
//        return report.date
//    }
//
//    func latitude()  -> Double{
//        return report.latitude
//    }
//
//    func longitude() -> Double{
//        return report.longitude
//    }
//}

import Foundation
import UIKit

struct ReportViewModel{


    private var reportManager = ReportManager.sharedInstance

    
    
    mutating func addReport( emergencyType: String, message: String, langitude: Double, latitude: Double){
        reportManager.addReport(emergencyType: emergencyType, message: message, langitude: langitude, latitude: latitude)
        print()
    }
    
    mutating func deleteReport(date: String){
        reportManager.deleteReport(date: date)
        print()
    }
    
    func getReports() -> [Report] {
        return reportManager.getReports()
    }
}
