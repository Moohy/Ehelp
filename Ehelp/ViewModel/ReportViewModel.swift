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
        return reportManager.reports
    }
}
