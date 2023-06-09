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
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass //variabel untuk tau ukuran device yang dipake
    
    // arahin ke detail
    @State private var selectedFood: Food? = nil
    
    //    untuk menentukan berapa item per row
    let gridLayout = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        let getID = viewModel.loggedInUser?.id.uuidString
        let userInfo = viewModel.getLastUserInfoCalories(getID ?? "")
        let calsMakan = Int(userInfo)/3
        if horizontalSizeClass == .compact {
            // tampilan iphone
            if userInfo != 0{
                NavigationView {
                    ScrollView {
                        LazyVGrid(columns: gridLayout, spacing: 16) {
                            ForEach(foodViewModel.foods, id: \.self) { item in
                                if item.cal <= calsMakan {
                                    Button(action: {
                                        selectedFood = item
                                    }) {
                                        ZStack {
                                            Rectangle()
                                                .foregroundColor(.white)
                                                .cornerRadius(25)
                                                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                                            
                                            VStack {
                                                Image(item.image)
                                                    .resizable()
                                                    .frame(width: 50, height: 50)
                                                .clipShape(Circle())
                                                Text(item.name)
                                                    .font(.custom("Poppins-Regular", size: 16))
                                                    .foregroundColor(.black)
                                            }
                                            .padding()
                                        }
                                    }
                                }
                            }.sheet(item: $selectedFood) { food in
                                FoodDetailView(food: food)
                            }
                        }
                        .padding()
                    }
                    .navigationTitle("Food Recommendation")
                }
            }else{
                VStack{
                    Image("noFoodData").resizable().frame(width: 150, height: 160)
                        .padding(.vertical,20)
                    Text("No data available.")
                        .fontWeight(.bold)
                        .padding(.bottom,1)
                    Text("Please input calorie data first for food recommendations.")
                        .font(.custom("Poppins-Regular", size: 16))
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                    
                }
               
            }
        }else{
            // tampilan ipad
            if userInfo != 0{
                NavigationStack {
                    ScrollView {
                        VStack {
                            Text("Food Recommendation")
                                .font(.system(size: 52))
                            
                            LazyVGrid(columns: gridLayout, spacing: 50) {
                                ForEach(foodViewModel.foods, id: \.self) { item in
                                    if item.cal <= 20000 {
                                        Button(action: {
                                            selectedFood = item
                                        }) {
                                            ZStack {
                                                Rectangle()
                                                    .foregroundColor(.white)
                                                    .cornerRadius(25)
                                                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                                                    .padding(.horizontal)
                                                
                                                VStack {
                                                    Image(item.image)
                                                        .resizable()
                                                        .clipShape(Circle())
                                                        .frame(width: 250, height: 250)
                                                    Text(item.name)
                                                        .font(.custom("Poppins-Regular", size: 32))
                                                        .foregroundColor(.black)
                                                }
                                                .padding()
                                            }
                                        }
                                    }
                                }
                                .sheet(item: $selectedFood) { food in
                                    FoodDetailView(food: food)
                                }
                            }
                            .padding()
                        }
                    }
//                    .navigationTitle("Food Recommendation")
                }
            }else{
                VStack{
                    Image("noFoodData").resizable().frame(width: 150, height: 160)
                        .padding(.vertical,20)
                    Text("No data available.")
                        .fontWeight(.bold)
                        .padding(.bottom,1)
                    Text("Please input calorie data first for food recommendations.")
                        .font(.custom("Poppins-Regular", size: 16))
                        .multilineTextAlignment(.center)
                        .frame(width: 300)
                }
            }
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

