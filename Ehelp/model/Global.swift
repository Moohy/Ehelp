//
//  Global.swift
//  Ehelp
//
//  Created by Mohammed on 6/9/19.
//  Copyright © 2019 Mohammed. All rights reserved.
//

import Foundation

class Global{
    private init() { }
    static let shared = Global()
    var reports = [Report]()
}
