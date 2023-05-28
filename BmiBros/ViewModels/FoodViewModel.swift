//
//  FoodViewModel.swift
//  BmiBros
//
//  Created by MacBook Pro on 22/05/23.
//

import Foundation

class FoodViewModel: ObservableObject {
    @Published var foods: [Food] = []
    
    @Published var filteredFoods: [Food] = []
       
    private var isProteinFilterOn = false
    private var isCarbohydrateFilterOn = false
    private var isFatFilterOn = false
    
    init() {
        fetchFoods()
    }
    
    func fetchFoods() {
        // Simulasi pengambilan data dari sumber eksternal (misalnya, API atau database)
        let sampleFoods = [
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
                name: "masak Babi",
                description: "Joseph isi babi ala Joseph yang enaknya wauwwwww makjos slebew (aku diajarin Rey)",
                cal: 5,
                prot: 6,
                carbs: 7,
                fat: 8
            ),
            Food(
                image: "food Image",
                name: "Dada Ayam",
                description: "per 100 gram",
                cal: 120,
                prot: 12,
                carbs: 0,
                fat: 0
            ),
            Food(
                image: "food Image",
                name: "Beras Putih",
                description: "per 100 gram",
                cal: 230,
                prot: 0,
                carbs: 12,
                fat: 0
            ),
            Food(
                image: "food Image",
                name: "Lemak Babi",
                description: "per 100 gram",
                cal: 300,
                prot: 0,
                carbs: 0,
                fat: 23
            )
        ]
        
        // Assign data yang diambil ke properti foods
        self.foods = sampleFoods
        
        applyFilter()
    }
    
    private func applyFilter() {
        // Reset filteredFoods
        filteredFoods = []
        
        // Apply filters based on selected options
        for food in foods {
            var check = false
            
            if isProteinFilterOn && food.prot > 0 {
                check = true
            }
            if isCarbohydrateFilterOn && food.carbs > 0 {
                check = true
            }
            if isFatFilterOn && food.fat > 0 {
                check = true
            }
            
            if check {
                filteredFoods.append(food)
            }
        }
    }
    
    // Functions to update filter options
    func setProteinFilterOn(_ isOn: Bool) {
        isProteinFilterOn = isOn
        applyFilter()
    }
    
    func setCarbohydrateFilterOn(_ isOn: Bool) {
        isCarbohydrateFilterOn = isOn
        applyFilter()
    }
    
    func setFatFilterOn(_ isOn: Bool) {
        isFatFilterOn = isOn
        applyFilter()
    }
}
