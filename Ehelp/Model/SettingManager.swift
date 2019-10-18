import Foundation
import UIKit
import CoreData


class SettingManager{
    
    var settings:[Setting] = []{
        willSet{
            print()
        }

    }
    
    static let sharedInstance = SettingManager()
    
    // Get a reference to your App Delegate
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // Hold a reference to the managed context
    let managedContext: NSManagedObjectContext
    
    
    private init(){
        managedContext = appDelegate.persistentContainer.viewContext
        loadSettings()
        addSetting()
        print()
    }
    
    private func createNsSetting() -> Setting{
        
        let settingEntity = NSEntityDescription .entity(forEntityName: "Setting" , in: managedContext)!
        
        let nsSetting = NSManagedObject (entity: settingEntity, insertInto: managedContext) as! Setting
        
        
        nsSetting.setValue(false, forKeyPath: "faceId")
        
        return nsSetting
    }
    
    func addSetting(){
        
//        loadSettings()
        
        if (settings.count > 0){
            return
        }
        
        let setting = createNsSetting()
        
        settings.append(setting)
        do
        {
            try managedContext.save()
            loadSettings()
        } catch let error as NSError
        {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    func updateFaceid(bool: Bool){
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Setting")

        do
        {
            let test = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(bool, forKey: "faceId")
            do{
                try managedContext.save()
                loadSettings()
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
    
    private func loadSettings() {
        do
        {
            let fetchRequest = NSFetchRequest <NSFetchRequestResult> (entityName:"Setting")
            
            let results = try managedContext.fetch(fetchRequest)
            settings = results as! [Setting]
        }
        catch let error as NSError {
            print ("Could not fetch \(error) , \(error.userInfo )")
        }
    }
}
