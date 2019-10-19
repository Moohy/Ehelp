// import packgaes and libraries
import Foundation
import UIKit
import CoreData

// report mangaer model
class ReportManager{
    
    // create a report array to hold values of the Report entity in the core data
    var reports:[Report] = []{
        willSet{
            print()
        }
    }
    
    // create an instance of the model, using Singleton design pattern
    static let sharedInstance = ReportManager()
    
    // Get a reference to your App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // Hold a reference to the managed context
    let managedContext: NSManagedObjectContext
    
    // model initalizer
    private init(){
        managedContext = appDelegate.persistentContainer.viewContext
        // call load report to load everything from the core data 'report entity' into the report array
        loadReports()
        print()
    }
    // create a report core-data instance and return it
    private func createNsReport(date: String, emergencyType: String, message: String, langitude: Double, latitude: Double) -> Report{
        // create a report entity
        let reportEntity = NSEntityDescription .entity(forEntityName: "Report" , in: managedContext)!
        // create an NS report entity
        let nsReport = NSManagedObject (entity: reportEntity, insertInto: managedContext) as! Report
        
        // set value of all attributes in the Report table based on the passed parameters
        nsReport.setValue(date, forKeyPath: "date")
        nsReport.setValue(emergencyType, forKeyPath: "emergencyType")
        nsReport.setValue(message, forKeyPath: "message")
        nsReport.setValue(langitude, forKeyPath: "longitude")
        nsReport.setValue(latitude, forKeyPath: "latitude")
        
        // return NS object of the report entity
        return nsReport
    }
    
    // delete a report from core data
    func deleteReport(date: String){
        
        // fetch data from Report table
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Report")
        // as of a Where clause, return row where date attribute equals the passed parameter
        fetchRequest.predicate = NSPredicate(format: "date = %@", date)
    
        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            // delete selected row
            managedContext.delete(objectToDelete)
            
            do{
                // save the report entity after object deletion
                try managedContext.save()
                // call load report to load everthing into reports array
                loadReports()
            }
            // catch any error that might occur
            catch
            {
                // if there is an error, print it out
                print(error)
            }
            
        }
        // catch any error that might occur
        catch
        {
            // if there is an error, print it out
            print(error)
        }
    }
    
    // add report to the report core-data
    func addReport(emergencyType: String, message: String, langitude: Double, latitude: Double){
        
        // call current data model to get the current date since we are not asking users for it
        let currDate = CurrentDate().setDate()
        // call create report function to create a new report
        let report = createNsReport(date: currDate, emergencyType: emergencyType, message: message, langitude: langitude, latitude: latitude)
        // append the created report to the reports array
        reports.append(report)
        do
        {
            // save the report entity after object creation
            try managedContext.save()
            // call load report to load everthing into report array
            loadReports()
        // catch any error that might occur
        } catch let error as NSError
        {
            // if there is an error, print it out
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    // load report function
    private func loadReports() {
        do
        {
            // fetch data from Report table
            let fetchRequest = NSFetchRequest <NSFetchRequestResult> (entityName:"Report")
            
            // add fetched data into results variable
            let results = try managedContext.fetch(fetchRequest)
            // add all fecthed data into reports array
            reports = results as! [Report]
        }
        // catch any error that might occur
        catch let error as NSError {
            // if there is an error, print it out
            print ("Could not fetch \(error) , \(error.userInfo )")
        }
    }
}
