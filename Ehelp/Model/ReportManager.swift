import Foundation
import UIKit
import CoreData


class ReportManager{
    
    var reports:[Report] = []{
        willSet{
            print()
        }
    }
    
    static let sharedInstance = ReportManager()
    
    // Get a reference to your App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // Hold a reference to the managed context
    let managedContext: NSManagedObjectContext
    
    private init(){
        managedContext = appDelegate.persistentContainer.viewContext
        loadReports()
        print()
    }
    
    private func createNsReport(date: String, emergencyType: String, message: String, langitude: Double, latitude: Double) -> Report{
        let reportEntity = NSEntityDescription .entity(forEntityName: "Report" , in: managedContext)!
        
        let nsReport = NSManagedObject (entity: reportEntity, insertInto: managedContext) as! Report
        
        
        nsReport.setValue(date, forKeyPath: "date")
        nsReport.setValue(emergencyType, forKeyPath: "emergencyType")
        nsReport.setValue(message, forKeyPath: "message")
        nsReport.setValue(langitude, forKeyPath: "longitude")
        nsReport.setValue(latitude, forKeyPath: "latitude")
        
        return nsReport
    }
    func deleteReport(date: String){
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Report")
        fetchRequest.predicate = NSPredicate(format: "date = %@", date)
        
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do{
                try managedContext.save()
                loadReports()
            }
            catch
            {
                print(error)
            }
            
        }
        catch
        {
            print(error)
        }
    }
    
    func addReport(emergencyType: String, message: String, langitude: Double, latitude: Double){
        let currDate = CurrentDate().setDate() 
        let report = createNsReport(date: currDate, emergencyType: emergencyType, message: message, langitude: langitude, latitude: latitude)
        
        reports.append(report)
        do
        {
            try managedContext.save()
            loadReports()
        } catch let error as NSError
        {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    private func loadReports() {
        do
        {
            let fetchRequest = NSFetchRequest <NSFetchRequestResult> (entityName:"Report")
            
            let results = try managedContext.fetch(fetchRequest)
            reports = results as! [Report]
        }
        catch let error as NSError {
            print ("Could not fetch \(error) , \(error.userInfo )")
        }
    }
    
    func getReports() -> [Report] {
        return self.reports
    }
}
