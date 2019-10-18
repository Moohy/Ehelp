import Foundation
import UIKit

struct SettingViewModel{
    
    
    private var settingManager = SettingManager.sharedInstance
    
    mutating func updateFaceid(bool: Bool){
        settingManager.updateFaceid(bool: bool)
        print()
    }
    
    func getSettings() -> [Setting] {
        return settingManager.settings
    }
}
