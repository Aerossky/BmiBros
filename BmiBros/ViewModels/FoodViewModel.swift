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
            name: "Brokoli",
            description: "Brokoli adalah sayuran hijau yang termasuk dalam keluarga kubis-kubisan. Brokoli memiliki batang dan kepala bunga yang dapat dimakan. Sayuran ini kaya akan serat, vitamin C, vitamin K, dan sulforaphane, yang memiliki efek antioksidan dan antiinflamasi.",
            cal: 34,
            prot: 28,
            carbs: 66,
            fat: 4
            ),
            Food(
            image: "food Image",
            name: "Ayam Panggang",
            description: "Ayam panggang adalah potongan daging ayam yang dipanggang dengan bumbu atau saus tertentu. Ayam panggang merupakan sumber protein yang baik dan rendah lemak. Daging ayam juga mengandung vitamin B kompleks dan mineral seperti selenium dan fosfor.",
            cal: 165,
            prot: 310,
            carbs: 0,
            fat: 36
            ),
            Food(
            image: "food Image",
            name: "Tahu",
            description: "Tahu adalah makanan yang terbuat dari kedelai yang difermentasi dan dipadatkan menjadi blok padat. Tahu merupakan sumber protein nabati yang baik, rendah lemak, dan bebas gluten. Tahu juga mengandung zat besi, kalsium, dan vitamin B kompleks.",
            cal: 76,
            prot: 80,
            carbs: 24,
            fat: 48
            ),
            Food(
            image: "food Image",
            name: "Salmon",
            description: "Salmon adalah jenis ikan laut yang populer dikonsumsi karena kandungan asam lemak omega-3 yang tinggi. Ikan salmon juga mengandung protein, vitamin D, vitamin B kompleks, dan mineral seperti selenium dan potasium. Konsumsi ikan salmon dapat memberikan manfaat bagi kesehatan jantung dan fungsi otak.",
            cal: 206,
            prot: 220,
            carbs: 0,
            fat: 130
            ),
            Food(
            image: "food Image",
            name: "Quinoa",
            description: "Quinoa adalah biji-bijian yang ditanam untuk dikonsumsi. Quinoa merupakan sumber karbohidrat kompleks yang tinggi serat, protein nabati lengkap, dan lemak sehat. Quinoa juga mengandung zat besi, magnesium, fosfor, dan vitamin B kompleks.",
            cal: 120,
            prot: 44,
            carbs: 213,
            fat: 19
            ),
            Food(
            image: "food Image",
            name: "Alpukat",
            description: "Alpukat adalah buah yang kaya akan lemak sehat, terutama asam lemak tak jenuh tunggal. Alpukat juga mengandung serat, vitamin K, vitamin C, vitamin E, dan kalium. Konsumsi alpukat dapat membantu menjaga kesehatan jantung dan mengurangi risiko penyakit degeneratif.",
            cal: 160,
            prot: 20,
            carbs: 90,
            fat: 140
            ),
            Food(
            image: "food Image",
            name: "Yogurt Yunani",
            description: "Yogurt Yunani adalah produk olahan susu yang dibuat dengan fermentasi bakteri baik. Yogurt Yunani rendah lemak dan tinggi protein. Produk ini juga mengandung kalsium, vitamin B12, dan probiotik yang baik untuk kesehatan pencernaan.",
            cal: 59,
            prot: 100,
            carbs: 36,
            fat: 4
            ),
            Food(
            image: "food Image",
            name: "Oatmeal",
            description: "Oatmeal adalah bubur gandum yang terbuat dari biji oat yang digiling. Oatmeal kaya serat larut, vitamin B kompleks, mineral, dan antioksidan. Makan oatmeal dapat membantu menjaga kesehatan jantung, menjaga berat badan, dan meningkatkan pencernaan.",
            cal: 68,
            prot: 24,
            carbs: 120,
            fat: 14
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
