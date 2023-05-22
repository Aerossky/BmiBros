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
//        self.cast = casts.map{Cast(name: $0)}
    }
}

extension Food{
    static let sampleFood: [Food] = [
        Food(
            image: "food Image",
            name: "Salad Babi",
            description: "Salad isi babi ala Joseph yang enaknya wauwwwww makjos slebew (aku diajarin Rey)",
            cal: 478,
            prot: 30,
            carbs: 25,
            fat: 12
        ),
        Food(
            image: "food Image",
            name: "Sushi Babi",
            description: "Sushi isi babi ala Joseph yang enaknya wauwwwww makjos slebew (aku diajarin Rey)",
            cal: 1,
            prot: 2,
            carbs: 3,
            fat: 4
        ),
        Food(
            image: "food Image",
            name: "Joseph Babi",
            description: "Joseph isi babi ala Joseph yang enaknya wauwwwww makjos slebew (aku diajarin Rey)",
            cal: 5,
            prot: 6,
            carbs: 7,
            fat: 8
        )
    ]
}

//extension Food{
//    struct Cast: Identifiable, Codable{
//        let id: UUID
//        var name: String
//
//        init(id: UUID = UUID(), name: String) {
//            self.id = id
//            self.name = name
//        }
//    }
//
//    static var emptyMovie: Movie{
//        Movie(title: "", casts: [])
//    }
//
//}
