//
//  Date+Ext.swift
//  Deskemo
//
//  Created by TriNgo on 1/18/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation

extension Date {
    
    init(milliseconds: Double) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}
