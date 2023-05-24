//
//  InputViewModel.swift
//  BmiBros
//
//  Created by MacBook Pro on 23/05/23.
//

import Foundation

class InputViewModel: ObservableObject {
    
//    Untuk laki-laki: (88,4 + 13,4 x berat dalam kilogram) + (4,8 x tinggi dalam sentimeter) - (5,68 x usia dalam tahun)
    
    func nambah(a: Double, b: Double, c: Double) -> Double {
        let bmiPria = 66.5 + (13.75 * a) + (5.003 * b) - (6.755 * c)
        return bmiPria
    }


    
}
