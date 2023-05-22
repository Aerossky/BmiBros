//
//  FoodInformationView.swift
//  BmiBros
//
//  Created by MacBook Pro on 22/05/23.
//

import SwiftUI

struct FoodInformationView: View {
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section("Food") {
                    ForEach(Food.sampleFood) { food in
                        NavigationLink(value: food) {
                            HStack {
                                //                                Image(food.image)
                            }
                            Text(food.name)
                                .font(.headline)
                            HStack {
                                Text("kcal")
                                Text(food.cal, format: .number)
                            }
                        }
                        .navigationDestination(for: Food.self) { food in
                            VStack {
                                HStack {
                                    Image(food.image)
                                }.imageScale(.medium).padding(.top, 12).clipShape(Circle()).shadow(radius: 15)
                                //            text about food
                                VStack{
                                    Text(food.name).padding(.top, 12).padding(.bottom, 20)
                                    Text(food.description).frame(width: 300)
                                }
                                Spacer()
                                //            info show
                                VStack {
                                    HStack{
                                        ZStack{
                                            Circle().frame(width: 75)
                                            
                                            VStack {
                                                Text("Cal")
                                                Text(food.cal,  format: .number)
                                            }.foregroundColor(.white)
                                        }
                                        ZStack{
                                            Circle().frame(width: 75)
                                            
                                            VStack {
                                                Text("Prot")
                                                Text(food.prot,  format: .number)
                                            }.foregroundColor(.white)
                                        }
                                        ZStack{
                                            Circle().frame(width: 75)
                                            
                                            VStack {
                                                Text("Carbs")
                                                Text(food.carbs,  format: .number)
                                            }.foregroundColor(.white)
                                        }
                                        ZStack{
                                            Circle().frame(width: 75)
                                            
                                            VStack {
                                                Text("fat")
                                                Text(food.fat,  format: .number)
                                            }.foregroundColor(.white)
                                        }
                                    }.foregroundColor(.purple).shadow(radius: 7)
                                }
                            }
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
