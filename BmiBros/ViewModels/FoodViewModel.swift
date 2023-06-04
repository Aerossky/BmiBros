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
    
    private var searchKeyword = ""
    
    init() {
        fetchFoods()
    }
    
    func fetchFoods() {
        // Simulasi pengambilan data dari sumber eksternal (misalnya, API atau database)
        let sampleFoods = [
            Food(
                image: "food Image",
                name: "Nasi Goreng Babi",
                description: "Nasi goreng khas surabaya yang dimasak oleh jovan dengan bumbu khas batam",
                cal: 580,
                prot: 34,
                carbs: 50,
                fat: 12
            ),
            Food(
                image: "food Image",
                name: "Steak Wahyu A5",
                description: "250 Gram / servings",
                cal: 300,
                prot: 25,
                carbs: 0,
                fat: 15
            ),
            Food(
                image: "food Image",
                name: "Kentang Kukus",
                description: "per 100 gram",
                cal: 87,
                prot: 0,
                carbs: 20,
                fat: 0
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
            ),
            Food(
                image: "food Image",
                name: "Minyak Zam Zam",
                description: "per 100 gram",
                cal: 530,
                prot: 0,
                carbs: 0,
                fat: 100
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
        
        if(!isFatFilterOn && !isProteinFilterOn && !isCarbohydrateFilterOn){
            for food in foods{
                if (food.name.localizedCaseInsensitiveContains(searchKeyword)){
                    filteredFoods.append(food)
                }
            }
        }else if((isFatFilterOn || isProteinFilterOn || isCarbohydrateFilterOn) && searchKeyword == ""){
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
                
                if check{
                    filteredFoods.append(food)
                }
            }
        }else{
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
                
                if check && food.name.localizedCaseInsensitiveContains(searchKeyword) {
                    filteredFoods.append(food)
                }
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
    
    func search(with keyword: String) {
        searchKeyword = keyword
        applyFilter()
    }
}
