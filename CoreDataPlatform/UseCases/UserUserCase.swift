//
//  UserUserCase.swift
//  CoreDataPlatform
//
//  Created by TriNgo on 1/16/19.
//  Copyright © 2019 RoverDream. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class UserUseCase<Repository>: Domain.UserUseCase where Repository: AbstractRepository, Repository.T == User {
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func create(user: User) -> Observable<Void> {
        return repository.save(entity: user)
    }
    
    func update(user: User) -> Observable<Void> {
        return repository.save(entity: user)
    }
    
    func user(username: String) -> Observable<[User]> {
        return repository.query(with: NSPredicate(format: "username = %@", username),
                                sortDescriptors: [User.CoreDataType.uid.descending()])
            .filter { $0.count > 0}
    }
}
