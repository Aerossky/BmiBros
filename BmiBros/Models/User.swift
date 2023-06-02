//
//  User.swift
//  BmiBros
//
//  Created by MacBook Pro on 22/05/23.
//

import Foundation
import SwiftUI

//extension UserViewModel {
    struct User {
        let id: UUID
        var username: String
        let email: String
        var password: String
        var gender: String
    }
//}

struct UserInfo {
    let id: Int
    let userId: String
    var age: Int
    var height: Double
    var weight: Double
    var bmi: Double
    var calories: Double
    let date: Date
}



//struct User: Identifiable, Hashable {
//    let id: UUID
//    var image: String
//    var username: String
//    var email: String
//    var password: String
//    var gender: Int
//    var weight: Int
//    var height: Int
//    var age: Int
//
//    init(id: UUID = UUID(), image: String, username: String, email: String, password: String, gender: Int, weight: Int, height: Int, age: Int) {
//        self.id = id
//        self.image = image
//        self.username = username
//        self.email = email
//        self.password = password
//        self.gender = gender
//        self.weight = weight
//        self.height = height
//        self.age = age
//    }
//}
