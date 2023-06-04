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
                let getID = viewModel.loggedInUser?.id.uuidString
                let userInfo = viewModel.getLastUserInfoCalories(getID ?? "")
                LazyVGrid(columns: gridLayout, spacing: 16) {
                    ForEach(foodViewModel.foods, id: \.self) { item in
                        if item.cal <= Int(userInfo) {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(25)
                                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                                
                                VStack {
                                    Image(item.image)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                    Text(item.name)
                                }
                                .padding()
                            }
                        }
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
