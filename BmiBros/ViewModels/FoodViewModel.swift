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
        let sampleFoods = [Food(
            image: "brokoli",
            name: "Broccoli",
            description: "Broccoli is a green vegetable that belongs to the cabbage family. It has edible stems and flower heads. This vegetable is rich in fiber, vitamin C, vitamin K, and sulforaphane, which have antioxidant and anti-inflammatory effects.",
            cal: 34,
            prot: 28,
            carbs: 0,
            fat: 0
            ),
            Food(
            image: "ayamPanggang",
            name: "Grilled Chicken",
            description: "Grilled chicken is a dish made from chicken meat that is cooked by grilling with certain spices or sauces. Grilled chicken is a good source of protein and low in fat. Chicken meat also contains B-complex vitamins and minerals such as selenium and phosphorus.",
            cal: 165,
            prot: 310,
            carbs: 0,
            fat: 36
            ),
            Food(
            image: "tahuGoreng",
            name: "Fried Tofu",
            description: "Tofu is a food made from fermented and compacted soybeans into a solid block. Tofu is a good source of plant-based protein, low in fat, and gluten-free. Tofu also contains iron, calcium, and B-complex vitamins.",
            cal: 76,
            prot: 80,
            carbs: 24,
            fat: 48
            ),
            Food(
            image: "salmon",
            name: "Salmon",
            description: "Salmon is a type of fish that is popularly consumed due to its high content of omega-3 fatty acids. Salmon also contains protein, vitamin D, B-complex vitamins, and minerals such as selenium and potassium. Consuming salmon can provide benefits for heart health and brain function.",
            cal: 206,
            prot: 220,
            carbs: 0,
            fat: 130
            ),
            Food(
            image: "alpukat",
            name: "Avocado",
            description: "Avocado is a fruit that is rich in healthy fats, especially monounsaturated fatty acids. Avocado also contains fiber, vitamin K, vitamin C, vitamin E, and potassium. Consuming avocado can help maintain heart health and reduce the risk of degenerative diseases.",
            cal: 160,
            prot: 20,
            carbs: 90,
            fat: 140
            ),
            Food(
            image: "sushi",
            name: "Sushi",
            description: "Sushi is a Japanese dish that consists of rolled rice with slices of fresh fish, vegetables, or other seafood. Sushi can be a healthy and delicious choice of food.",
            cal: 300,
            prot: 8,
            carbs: 45,
            fat: 7
            ),
            Food(
            image: "oatmeal",
            name: "Oatmeal",
            description: "Oatmeal is a porridge made from rolled oats. Oatmeal is rich in soluble fiber, B-complex vitamins, minerals, and antioxidants. Consuming oatmeal can help maintain heart health, manage weight, and improve digestion.",
            cal: 68,
            prot: 24,
            carbs: 120,
            fat: 14
            ),
            Food(
            image: "burgerAyam",
            name: "Chicken Burger",
            description: "A burger is a sandwich made with a chicken patty usually served with cheese, sauce, and vegetables. Burgers can be a tasty and convenient fast food option.",
            cal: 400,
            prot: 20,
            carbs: 30,
            fat: 22
            ),
            Food(
            image: "mieAyam",
            name: "Chicken Noodles",
            description: "Chicken noodles are a dish of noodles with chicken pieces, broth, and vegetables such as scallions and celery. Chicken noodles are a delicious and popular dish in Indonesia.",
            cal: 380,
            prot: 15,
            carbs: 50,
            fat: 10
            ),
            Food(
            image: "nasiGoreng",
            name: "Fried Rice",
            description: "Fried rice is a dish made from rice that is fried with spices and mixed with vegetables, meat, or seafood. Fried rice can be a delicious and convenient main dish.",
            cal: 350,
            prot: 10,
            carbs: 50,
            fat: 12
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
