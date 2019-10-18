//
//  ApiViewModel.swift
//  Ehelp
//
//  Created by Mohammed on 18/10/19.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import Foundation

class ApiViewModel: ViewModelType{
    private var api = TwilioApi.sharedInstance
    
    var delegate: ViewModelDelegate?
    
    func pass(reqBody: String) {
        api.sendReport(with: reqBody)
    }

}
