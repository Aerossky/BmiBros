//
//  FoodRecommendationView.swift
//  BmiBros
//
//  Created by MacBook Pro on 04/06/23.
//

import SwiftUI

struct FoodRecommendationView: View {
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var viewModel: UserViewModel
    @EnvironmentObject var foodViewModel: FoodViewModel
    @EnvironmentObject var inputViewModel: InputViewModel
    @EnvironmentObject var appEnvironment: AppEnvironment
    
//    untuk menentukan berapa item per row
    let gridLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: gridLayout, spacing: 16) {
                    ForEach(foodViewModel.foods, id: \.self) { item in
                        
                    }
                }
                .padding()
            }
            .navigationTitle("Food Recommendation")
        }
    }
}

struct FoodRecommendationView_Previews: PreviewProvider {
    static var previews: some View {
        FoodRecommendationView()
            .environmentObject(SessionManager())
            .environmentObject(UserViewModel())
            .environmentObject(FoodViewModel())
            .environmentObject(InputViewModel())
            .environmentObject(AppEnvironment())

    }
}
