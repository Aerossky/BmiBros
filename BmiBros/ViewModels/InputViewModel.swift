//
//  InputViewModel.swift
//  BmiBros
//
//  Created by MacBook Pro on 23/05/23.
//

import SwiftUI
import Foundation

class InputViewModel: ObservableObject {
    
    //BMI
    func calculateBMI(weight: Double, height: Double, age: Int, gender: String) -> Double {
        let heightInMeters = height / 100
        let bmi = weight / (heightInMeters * heightInMeters)
        
        var ageFactor: Double = 0.0
        var genderFactor: Double = 0.0
        
        //        if age >= 2 && age <= 5 {
        //            ageFactor = 0.1
        //        } else if age >= 6 && age <= 12 {
        //            ageFactor = 0.2
        //        } else if age >= 13 && age <= 19 {
        //            ageFactor = 0.3
        //        } else if age >= 20 && age <= 30 {
        //            ageFactor = 0.4
        //        } else if age >= 31 && age <= 120 {
        //            ageFactor = 0.5
        //        }
        //
        //        if gender == "male" {
        //            genderFactor = 0.1
        //        } else if gender == "female" {
        //            genderFactor = 0.2
        //        }
        
        //        let adjustedBMI = bmi + ageFactor + genderFactor
        let adjustedBMI = bmi
        let roundedBMI = adjustedBMI
        
        return roundedBMI
    }
    func getBMICategory(bmi: Double, age: Int) -> (String, Color) {
        var category: String = ""
        var textColor: Color = .black
        
        if age >= 2 && age <= 20 {
            if bmi < 18.5 {
                category = "UnderWeight"
                textColor = Color(UIColor(hex: "#ED5656"))
            } else if bmi < 24.9 {
                category = "Normal"
                textColor = Color(UIColor(hex: "#C1FF8F"))
            } else if bmi < 29.9 {
                category = "OverWeight"
                textColor = Color(UIColor(hex: "#FFDF84"))
            } else{
                category = "Obesity"
                textColor = Color(UIColor(hex: "#FA6657"))
            }
        } else {
            if bmi < 18.5 {
                textColor = Color(UIColor(hex: "#ED5656"))
            } else if bmi < 24.9 {
                category = "Normal"
                textColor = Color(UIColor(hex: "#C1FF8F"))
            } else if bmi < 29.9 {
                category = "OverWeight"
                textColor = Color(UIColor(hex: "#FFDF84"))
            } else if bmi < 34.9 {
                category = "Obesity Class I"
                textColor = Color(UIColor(hex: "#FA6657"))
            } else if bmi < 39.9 {
                category = "Obesity Class II"
                textColor = Color(UIColor(hex: "#FF5353"))
            } else if bmi >= 40 {
                category = "Obesity Class III"
                textColor = Color(UIColor(hex: "#ED5656"))
            }
        }
        
        return (category, textColor)
    }
    
    //CALORIE
    func calculateCalorie(weight:Double, height:Double, age:Double, gender:String) -> Double{
        
        var calorie: Double = 0.0
        
        if gender.lowercased() == "male" {
            calorie = 66.5 + (13.75 * weight) + (5.03 * height) - (6.75 * age)
        }else{
            calorie = 655.1 + (9.563 * weight) + (1.850 * height) - (4.676 * age)
        }
        
        return calorie
        
    }

}
