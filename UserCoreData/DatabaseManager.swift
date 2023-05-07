//
//  DatabaseManager.swift
//  UserCoreData
//
//  Created by Sadia on 4/5/23.
//

import Foundation
import UIKit
import CoreData

struct UserModel {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let imageName: String
}

class DatabaseManager {
    
    func getContext() -> NSManagedObjectContext{
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }

    func addUser(_ user:UserModel){
        
        let userEntity = UserEntity(context: getContext())
        userEntity.firstName = user.firstName
        userEntity.lastName = user.lastName
        userEntity.email = user.email
        userEntity.password = user.password
        userEntity.imageName = user.imageName
        
        //Database e reflect korar jonno
        do{
            try getContext().save()
        }catch{
            print("user saving error:", error)
        }
    }
    
    func fetchUser() -> [UserEntity]{
        var users:[UserEntity] = []
        
        do{
            users = try getContext().fetch(UserEntity.fetchRequest())
        }catch{
            print("Fetch Error \(error.localizedDescription)")
        }
        return users
    }
}
