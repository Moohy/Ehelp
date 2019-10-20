//
//  ReportTests.swift
//  EhelpTests
//
//  Created by Mohammed Alosaimi on 20/10/19.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import XCTest
@testable import Ehelp


class ReportTests: XCTestCase {

    // initialize report view model
    var reportViewModel:ReportViewModel!
    var emergencyType: String!
    var message: String!
    var longitude: Double!
    var latitude:Double!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // initialize report view model
        reportViewModel = ReportViewModel()
        
        addReport()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        // delete report from report core data
        reportViewModel.deleteReport(date: reportViewModel.getReports().last?.value(forKey:"date") as! String)
    }

    func testValidReportData() {
        
        // test if added report emergency type is equal the emergency type we initialized above
        XCTAssertTrue(reportViewModel.getReports().last?.emergencyType == emergencyType)
        // test if added report message is equal the message we initialized above
        XCTAssertTrue(reportViewModel.getReports().last?.message == message)
        // test if added report langitude is equal the langitude we initialized above
        XCTAssertTrue(reportViewModel.getReports().last?.longitude == longitude)
        // test if added report latitude is equal the latitude we initialized above
        XCTAssertTrue(reportViewModel.getReports().last?.latitude == latitude)
        
        
    }
    
    func testInValidReportData() {
        
        // test if added report emergency type does not equal the emergency type we initialized above
        XCTAssertNotEqual(reportViewModel.getReports().last?.emergencyType, "firefighter")
        // test if added report message does not equal the message we initialized above
        XCTAssertNotEqual(reportViewModel.getReports().last?.message, "Some message")
        // test if added report langitude does not equal the langitude we initialized above
        XCTAssertNotEqual(reportViewModel.getReports().last?.longitude, 00000000)
        // test if added report latitude does not equal the latitude we initialized above
        XCTAssertNotEqual(reportViewModel.getReports().last?.latitude, 00000000)
        
        
    }
    
    func testInValidReportMessageLengthBoundry() {
        
        // set up variables
        emergencyType = Emergency.fireFighter.rawValue
        //boundry of > 160
        message = "Some strings here and sentences will lead to higher than 160 characters Some strings here and sentences will lead to higher than 160 charactersSome strings here and sentences will lead to higher than 160 characters Some strings here and sentences will lead to higher than 160 characters"
        longitude = 1232.1
        latitude = 3223.32
        
        
        // add invalid report to the report core data
        reportViewModel.addReport(emergencyType: emergencyType, message: message, longitude: longitude, latitude: latitude)
        
        // testing the invalid report that is not equal to last value in core data
        XCTAssertNotEqual(reportViewModel.getReports().last?.message, message)
        
        //boundry of < 10
        message = "Some strs"
        
        reportViewModel.addReport(emergencyType: emergencyType, message: message, longitude: longitude, latitude: latitude)
        
        // add invalid report to the report core data
        reportViewModel.addReport(emergencyType: emergencyType, message: message, longitude: longitude, latitude: latitude)
        
        // testing the invalid report that is not equal to last value in core data
        XCTAssertNotEqual(reportViewModel.getReports().last?.message, message)
        
        //boundry of == 160
        message = "Some strings here and sentences will lead to higher than 160 characters Some strings here and sentences will lead to higher than 160 charactersSome strings here"
        
        reportViewModel.addReport(emergencyType: emergencyType, message: message, longitude: longitude, latitude: latitude)
        
        // add valid report to the report core data
        reportViewModel.addReport(emergencyType: emergencyType, message: message, longitude: longitude, latitude: latitude)
        
        // testing the valid report that is equal to last value in core data
        XCTAssertEqual(reportViewModel.getReports().last?.message, message)
        
        //deleteLast value in the core date
        deleteReport()
        
        //boundry of == 160
        message = "Some strs!"
        
        reportViewModel.addReport(emergencyType: emergencyType, message: message, longitude: longitude, latitude: latitude)
        
        // add valid report to the report core data
        reportViewModel.addReport(emergencyType: emergencyType, message: message, longitude: longitude, latitude: latitude)
        
        // testing the valid report that is equal to last value in core data
        XCTAssertEqual(reportViewModel.getReports().last?.message, message)
        
        //deleteLast value in the core date
        deleteReport()
        
        
        
    }
    
    func testInexistentReport() {
        
        // call delete report function to delete report
        deleteReport()

        // test if the data in the core data doesn't equal the message
        XCTAssertFalse(reportViewModel.getReports().last?.message == "message")
        // test if the data in the core data doesn't equal the longtitude
        XCTAssertFalse(reportViewModel.getReports().last?.longitude == 000000)
        // test if the data in the core data doesn't equal the latitude
        XCTAssertFalse(reportViewModel.getReports().last?.latitude == 000000)
        
        addReport()
        
    }
    
    func addReport() {
        // set up variables
        emergencyType = Emergency.police.rawValue
        message = "Help me Please"
        longitude = 1232.1
        latitude = 3223.32
        
        
        // add report to the report core data
        reportViewModel.addReport(emergencyType: emergencyType, message: message, longitude: longitude, latitude: latitude)
    }
    
    
    func deleteReport() {
        
        // delete report from report core data
        reportViewModel.deleteReport(date: reportViewModel.getReports().last?.value(forKey:"date") as! String)
    }

}
