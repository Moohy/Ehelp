import Foundation
import UIKit

// report view model
struct ReportViewModel{


    // initialize report model
    private var reportManager = ReportManager.sharedInstance

    // add report to the report core data
    mutating func addReport( emergencyType: String, message: String, longitude: Double, latitude: Double){
        reportManager.addReport(emergencyType: emergencyType, message: message, longitude: longitude, latitude: latitude)
        print()
    }
    
    // delete report from report core data
    mutating func deleteReport(date: String){
        reportManager.deleteReport(date: date)
        print()
    }
    
    // get reports from report core data
    func getReports() -> [Report] {
        return reportManager.reports
    }
}
