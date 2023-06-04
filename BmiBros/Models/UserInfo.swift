//
//  UserInfo.swift
//  BmiBros
//
//  Created by MacBook Pro on 29/05/23.
//

import Foundation

struct UserInfo {
    let id: UUID
    let userId: String
    var age: Int
    var height: Double
    var weight: Double
    var bmi: Double
    var calories: Double
    let date: Date
    
    init(id: UUID, userId: String, age: Int, height: Double, weight: Double, bmi: Double, calories: Double, date: Date) {
        self.id = id
        self.userId = userId
        self.age = age
        self.height = height
        self.weight = weight
        self.bmi = bmi
        self.calories = calories
        self.date = date
    }
}
