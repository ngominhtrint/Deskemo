//
//  UserUseCase.swift
//  Domain
//
//  Created by TriNgo on 1/15/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import RxSwift

public protocol UserUseCase {
    
    func create(user: User) -> Observable<Void>
    func update(user: User) -> Observable<Void>
}
