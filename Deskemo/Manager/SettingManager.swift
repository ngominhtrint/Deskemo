//
//  SettingManager.swift
//  Deskemo
//
//  Created by TriNgo on 1/17/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation

class SettingManager {
    
    static let shared: SettingManager = SettingManager()
    
    init() { }
    
    var preloaded: Bool {
        set {
            UserDefaults.standard.set(newValue, forKey: DEFAULT_PRELOADED_KEY)
            UserDefaults.standard.synchronize()
        }
        
        get {
            guard let preloaded = UserDefaults.standard.object(forKey: DEFAULT_PRELOADED_KEY) as? Bool else { return false }
            return preloaded
        }
    }
}
