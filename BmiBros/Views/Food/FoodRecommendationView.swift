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
    
    let data = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7"]
    
//    untuk menentukan berapa item per row
    let gridLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridLayout, spacing: 16) {
                ForEach(data, id: \.self) { item in
                    ZStack {
                        Rectangle()
                        Text(item)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.gray)
                            .cornerRadius(8)
                        .padding()
                    }
                }
            }
            .padding()
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
