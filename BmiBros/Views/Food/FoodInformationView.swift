//
//  FoodInformationView.swift
//  BmiBros
//
//  Created by MacBook Pro on 22/05/23.
//

import SwiftUI

struct FoodInformationView: View {
    @StateObject private var viewModel = FoodViewModel()
    @State private var searchText = ""
    @State private var selectedFood: Food? = nil
    @State private var isPopoverPresented = false
    
    @State var filterArray:[Food] = []
    @State private var isProteinFilterOn = false
    @State private var isCarbohydrateFilterOn = false
    @State private var isFatFilterOn = false
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action: {
                    isPopoverPresented = true
                }) {
                    Image("filter")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 16)
                        .alignmentGuide(HorizontalAlignment.trailing) { dimension in
                            dimension[HorizontalAlignment.trailing]
                        }
                        .alignmentGuide(VerticalAlignment.top) { dimension in
                            dimension[VerticalAlignment.top]
                        }
                }.popover(isPresented: $isPopoverPresented, arrowEdge: .top) {
                    VStack {
                        VStack {
                            Text("Filter Options")
                            Toggle("Protein", isOn: $isProteinFilterOn)
                            Toggle("Carbohydrate", isOn: $isCarbohydrateFilterOn)
                            Toggle("Fat", isOn: $isFatFilterOn)
                        }
                        .onChange(of: isProteinFilterOn) { value in
                            applyFilter()
                        }
                        .onChange(of: isCarbohydrateFilterOn) { value in
                            applyFilter()
                        }
                        .onChange(of: isFatFilterOn) { value in
                            applyFilter()
                        }
                        Button(action: {
                            isPopoverPresented = false
                        }) {
                            VStack{
                                Spacer()
                                Text("Close")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                
                            }
                        }
                    }
                }
            }
            NavigationView {
                VStack {
                    SearchBarView(searchText: $searchText)
                    List {
                        if filterArray.isEmpty {
                            ForEach(viewModel.foods) { food in
                                Button(action: {
                                    selectedFood = food
                                }) {
                                    HStack {
                                        Image(food.image)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                        Text(food.name)
                                            .font(.headline)
                                        Spacer()
                                        HStack {
                                            Text("kcal")
                                            Text("\(food.cal)")
                                        }
                                    }
                                    .padding()
                                }
                                .buttonStyle(PlainButtonStyle())
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                                .background(Color(UIColor(hex: "#F7F7F7")))
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                            }
                        }else {
                            ForEach(filterArray) { food in
                                Button(action: {
                                    selectedFood = food
                                }) {
                                    HStack {
                                        Image(food.image)
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                        Text(food.name)
                                            .font(.headline)
                                        Spacer()
                                        HStack {
                                            Text("kcal")
                                            Text("\(food.cal)")
                                        }
                                    }
                                    .padding()
                                }
                                .buttonStyle(PlainButtonStyle())
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                                .background(Color(UIColor(hex: "#F7F7F7")))
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .accentColor(.clear)
                    .navigationTitle("Food List")
                    .sheet(item: $selectedFood) { food in
                        FoodDetailView(food: food)
                    }
                }
            }
        }
    }
    private func applyFilter() {
        // Reset filterArray
        filterArray.removeAll()
        
        // Apply filters based on selected options
        for foodFilter in viewModel.foods {
            if isProteinFilterOn && foodFilter.prot > 0 {
                filterArray.append(foodFilter)
            }
            if isCarbohydrateFilterOn && foodFilter.carbs > 0 {
                filterArray.append(foodFilter)
            }
            if isFatFilterOn && foodFilter.fat > 0 {
                filterArray.append(foodFilter)
            }
        }
    }
}

struct FoodInformationView_Previews: PreviewProvider {
    static var previews: some View {
        FoodInformationView()
    }
}
