//
//  FoodInformationView.swift
//  BmiBros
//
//  Created by MacBook Pro on 22/05/23.
//

import SwiftUI

struct FoodInformationView: View {
    @StateObject private var viewModel = FoodViewModel()
       
    var body: some View {
        NavigationStack{
            List(viewModel.foods) { food in
                NavigationLink(destination: FoodDetailView(food: food)) {
                    HStack {
                        // Image(food.image)
                        Text(food.name)
                            .font(.headline)
                        HStack {
                            Text("kcal")
                            Text("\(food.cal)")
                        }
                    }
                }
            }
        }
    }
}

struct FoodInformationView_Previews: PreviewProvider {
    static var previews: some View {
        FoodInformationView()
    }
}
