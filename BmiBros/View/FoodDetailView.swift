//
//  FoodDetailView.swift
//  BmiBros
//
//  Created by MacBook Pro on 20/05/23.
//

import SwiftUI

struct FoodDetailView: View {
    let food: Food
    
    var body: some View {
        VStack {
            HStack {
                Image(food.image)
            }
            Text(food.name)
                .font(.title)
            Text(food.description)
                .frame(width: 300)
            Spacer()
            VStack {
                HStack {
                    InfoCircleView(title: "Cal", value: food.cal)
                    InfoCircleView(title: "Prot", value: food.prot)
                    InfoCircleView(title: "Carbs", value: food.carbs)
                    InfoCircleView(title: "Fat", value: food.fat)
                }
            }
        }
        .padding()
    }
}

struct InfoCircleView: View {
    let title: String
    let value: Int
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 75)
                .foregroundColor(.purple)
            
            VStack {
                Text(title)
                Text("\(value)")
            }
            .foregroundColor(.white)
        }
        .shadow(radius: 7)
    }
}


struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let food = Food(id: UUID(), image: "food Image", name: "Salad Babi", description: "Salad isi babi ala Joseph yang enaknya wauwwwww makjos slebew (aku diajarin Rey)", cal: 478, prot: 30, carbs: 25, fat: 12)
        FoodDetailView(food: food)
    }
}
