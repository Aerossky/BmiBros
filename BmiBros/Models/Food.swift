//
//  Food.swift
//  BmiBros
//
//  Created by MacBook Pro on 22/05/23.
//

import Foundation

struct Food: Identifiable, Hashable {
    let id: UUID
    var image: String
    var name: String
    var description: String
    var cal: Int
    var prot: Int
    var carbs: Int
    var fat: Int
    
    init(id: UUID = UUID(), image: String, name: String, description: String, cal: Int, prot: Int, carbs: Int, fat: Int) {
        self.id = id
        self.image = image
        self.name = name
        self.description = description
        self.cal = cal
        self.prot = prot
        self.carbs = carbs
        self.fat = fat
    }
    enum FilterType: String, CaseIterable {
        case protein
        case carbohydrate
        case fat
    }
}
