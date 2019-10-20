//
//  SettingTests.swift
//  EhelpTests
//
//  Created by Mohammed Alosaimi on 20/10/19.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import XCTest
@testable import Ehelp


class SettingTests: XCTestCase {

    
    // initialize setting view model
    var settingviewModel: SettingViewModel!
    // initialize setting model
    var settingManager: SettingManager!
    var faceID: Bool!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // initialize setting view model
        settingviewModel = SettingViewModel()
        settingManager = SettingManager.sharedInstance
        
        // add setting to the setting core data -- initialized value = false
        settingManager.addSetting()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        // always update faceID value to false
        settingviewModel.updateFaceid(bool: false)
    }


    func testFaceIDExistence() {
        
        // check if there is a face id element in the array
        XCTAssertNotNil(settingviewModel.getSettings().last?.faceId)
        
    }
    
    func testNotEqualValueofFaceID() {
        
        // check if the face id is not tre
        XCTAssertNotEqual(settingviewModel.getSettings().last?.faceId, true)

    }
    
    func testEqualValueofFaceID() {
        // update value to true
        settingviewModel.updateFaceid(bool: true)
        
        // check if the face id is true
        XCTAssertEqual(settingviewModel.getSettings().last?.faceId, true)
        
        // return to false
        settingviewModel.updateFaceid(bool: false)
    }
    
    
    

}
