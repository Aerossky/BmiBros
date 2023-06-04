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
    
    init(_ id: UUID, _ userId: String, _ age: Int, _ height: Double, _ weight: Double, _ bmi: Double, _ calories: Double, _ date: Date) {
        self.id = UUID()
        self.userId = userId
        self.age = age
        self.height = height
        self.weight = weight
        self.bmi = bmi
        self.calories = calories
        self.date = date
    }
}
