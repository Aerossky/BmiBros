//
//  InputViewModel.swift
//  BmiBros
//
//  Created by MacBook Pro on 23/05/23.
//

import Foundation

class InputViewModel: ObservableObject {
    
    //    Untuk laki-laki: (88,4 + 13,4 x berat dalam kilogram) + (4,8 x tinggi dalam sentimeter) - (5,68 x usia dalam tahun)
    
    //    func nambah(a: Double, b: Double, c: Double) -> Double {
    //        let bmiPria = 66.5 + (13.75 * a) + (5.003 * b) - (6.755 * c)
    //        return bmiPria
    //    }
    
    func calculateBMI(adultWeight: Double, adultHeight: Double) -> Double {
        let height = adultHeight / 100
        let bmi = adultWeight / (height * height)
        let roundedBMI = (bmi * 100).rounded() / 100
        return roundedBMI
    }
    
    func calculateBMIForChild(weight: Double, height: Double, age: Int, gender: String) -> Double {
        let heightInMeters = height / 100
        let bmi = weight / (heightInMeters * heightInMeters)
        
        var ageFactor: Double = 0.0
        var genderFactor: Double = 0.0
        
        if age >= 2 && age <= 5 {
            ageFactor = 0.1
        } else if age >= 6 && age <= 12 {
            ageFactor = 0.2
        } else if age >= 13 && age <= 19 {
            ageFactor = 0.3
        } else if age >= 20 && age <= 30 {
            ageFactor = 0.4
        } else if age >= 31 && age <= 120 {
            ageFactor = 0.5
        }
        
        if gender == "male" {
            genderFactor = 0.1
        } else if gender == "female" {
            genderFactor = 0.2
        }
        
        let adjustedBMI = bmi + ageFactor + genderFactor
        let roundedBMI = (adjustedBMI * 100).rounded() / 100
        
        return roundedBMI
    }
}
