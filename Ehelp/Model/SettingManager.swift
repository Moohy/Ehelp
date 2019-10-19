// import packgaes and libraries
import Foundation
import UIKit
import CoreData

// setting mangaer model
class SettingManager{
    
    // create a settings array to hold values of the Setting entity in the core data
    var settings:[Setting] = []{
        willSet{
            print()
        }

    }
    // create an instance of the model, using Singleton design pattern
    static let sharedInstance = SettingManager()
    
    // Get a reference to your App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // Hold a reference to the managed context
    let managedContext: NSManagedObjectContext
    
    // model initalizer
    private init(){
        managedContext = appDelegate.persistentContainer.viewContext
        // call load settings to load everything from the core data 'setting entity' into the settings array
        loadSettings()
        // call add setting function to add an inital value to the setting data
        addSetting()
        print()
    }
    
    // create a setting core-data instance and return it
    private func createNsSetting() -> Setting{
        // create a setting entity
        let settingEntity = NSEntityDescription .entity(forEntityName: "Setting" , in: managedContext)!
        // create an NS setting entity
        let nsSetting = NSManagedObject (entity: settingEntity, insertInto: managedContext) as! Setting

        // set value for the only given attribute in the Setting table to inital value 'false'
        nsSetting.setValue(false, forKeyPath: "faceId")

        // return NS object of the setting entity
        return nsSetting
    }
    // add setting to the setting core-data
    func addSetting(){
        // check if the setting array has any values, if it does, then pass and do nothing
        if (settings.count > 0){
            return
        }
        // else, create a setting object with its inital value 'false'
        let setting = createNsSetting()
        
        // append the created setting to the settings array
        settings.append(setting)
        do
        {
            // save the setting entity after object creation
            try managedContext.save()
            // call load setting to load everthing into settings array
            loadSettings()
        // catch any error that might occur
        } catch let error as NSError
        {
            // if there is an error, print it out
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    // update report core data
    func updateFaceid(bool: Bool){
        
        // As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        // We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        // fetch data from Setting table
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Setting")

        do
        {
            
            let test = try managedContext.fetch(fetchRequest)
            
            // fetch the first row in the table
            let objectUpdate = test[0] as! NSManagedObject
            // update faceId based on the given parameter
            objectUpdate.setValue(bool, forKey: "faceId")
            do{
                // save the report entity after object update
                try managedContext.save()
                // call load report to load everthing into setting array
                loadSettings()
            }
            // catch any error that might occur
            catch
            {
                // if there is an error, print it out
                print(error)
            }
        }
        catch
        {
            print(error)
        }
        
    }
    
    private func loadSettings() {
        do
        {
            // fetch data from Setting table
            let fetchRequest = NSFetchRequest <NSFetchRequestResult> (entityName:"Setting")
            
            // add fetched data into results variable
            let results = try managedContext.fetch(fetchRequest)
            // add all fecthed data into setting array
            settings = results as! [Setting]
        }
        // catch any error that might occur
        catch let error as NSError {
            // if there is an error, print it out
            print ("Could not fetch \(error) , \(error.userInfo )")
        }
    }
}
