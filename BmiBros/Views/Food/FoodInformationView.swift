//
//  FoodInformationView.swift
//  BmiBros
//
//  Created by MacBook Pro on 22/05/23.
//

import SwiftUI

struct FoodInformationView: View {
    @StateObject private var viewModel = FoodViewModel()
    @Environment(\.horizontalSizeClass) var horizontalSizeClass //variabel untuk tau ukuran device yang dipake
    
    //pakai search
    @State private var searchText = ""
    
    // arahin ke detail
    @State private var selectedFood: Food? = nil
    
    // filter data berdasarkan protein, carbs dan fat
    @State private var isPopoverPresented = false
    @State private var isProteinFilterOn = false
    @State private var isCarbohydrateFilterOn = false
    @State private var isFatFilterOn = false
    
    var body: some View {
        if horizontalSizeClass == .compact {
            VStack{
                HStack{
                    Text("Food Information")
                        .font(.custom("Poppins-Bold", size: 24))
                        .padding(.horizontal)
                    Spacer()
                    Button(action: {
                        isPopoverPresented = true
                    }) {
                        HStack {
                            Image("filter")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.trailing, 16)
                                .alignmentGuide(HorizontalAlignment.trailing) { dimension in
                                    dimension[HorizontalAlignment.trailing]
                                }
                                .alignmentGuide(VerticalAlignment.top) { dimension in
                                    dimension[VerticalAlignment.top]
                                }
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
                                viewModel.setProteinFilterOn(isProteinFilterOn)
                            }
                            .onChange(of: isCarbohydrateFilterOn) { value in
                                viewModel.setCarbohydrateFilterOn(isCarbohydrateFilterOn)
                            }
                            .onChange(of: isFatFilterOn) { value in
                                viewModel.setFatFilterOn(isFatFilterOn)
                            }
                            .padding(.all)
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
                            if isProteinFilterOn == false && isFatFilterOn == false && isCarbohydrateFilterOn == false {
                                if(searchText == ""){
                                    ForEach(viewModel.foods) { food in
                                        Button(action: {
                                            selectedFood = food
                                        }) {
                                            HStack {
                                                Image(food.image)
                                                    .resizable()
                                                    .frame(width: 50, height: 50)
                                                    .clipShape(Circle())
                                                Text(food.name)
                                                    .font(.headline)
                                                Spacer()
                                                HStack {
                                                    Text("kcal")
                                                    Text("\(food.cal)")
                                                }
                                            }
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(Color(UIColor(hex: "#F7F7F7")))
                                            .cornerRadius(20)
                                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .listRowSeparator(.hidden)
                                        .listRowInsets(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                                        
                                    }
                                }else{
                                    ForEach(viewModel.filteredFoods) { food in
                                        Button(action: {
                                            selectedFood = food
                                        }) {
                                            HStack {
                                                Image(food.image)
                                                    .resizable()
                                                    .frame(width: 50, height: 50)
                                                    .clipShape(Circle())
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
                                
                                
                            }else {
                                ForEach(viewModel.filteredFoods) { food in
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
                        
                        .sheet(item: $selectedFood) { food in
                            FoodDetailView(food: food)
                        }
                    }
                }
            }
            .onChange(of: searchText){ newValue in
                viewModel.search(with: newValue)
            }
        }else{
            VStack{
                HStack{
                    
                    Spacer()
                    Button(action: {
                        isPopoverPresented = true
                    }) {
                        HStack {
                            Image("filter")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.trailing, 16)
                                .alignmentGuide(HorizontalAlignment.trailing) { dimension in
                                    dimension[HorizontalAlignment.trailing]
                                }
                                .alignmentGuide(VerticalAlignment.top) { dimension in
                                    dimension[VerticalAlignment.top]
                                }
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
                                viewModel.setProteinFilterOn(isProteinFilterOn)
                            }
                            .onChange(of: isCarbohydrateFilterOn) { value in
                                viewModel.setCarbohydrateFilterOn(isCarbohydrateFilterOn)
                            }
                            .onChange(of: isFatFilterOn) { value in
                                viewModel.setFatFilterOn(isFatFilterOn)
                            }
                            .padding(.all)
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
                NavigationStack {
                    VStack {
                        Text("Food Information")
                            .font(.custom("Poppins-Bold", size: 30))
                            .padding(.horizontal)
                        SearchBarView(searchText: $searchText)
                            .frame(width: 500)
                        
                        List {
                            if isProteinFilterOn == false && isFatFilterOn == false && isCarbohydrateFilterOn == false {
                                if(searchText == ""){
                                    ForEach(viewModel.foods) { food in
                                        Button(action: {
                                            selectedFood = food
                                        }) {
                                            HStack {
                                                Image(food.image)
                                                    .resizable()
                                                    .frame(width: 100, height: 100)
                                                Text(food.name)
                                                    .font(.headline)
                                                Spacer()
                                                HStack {
                                                    Text("kcal")
                                                    Text("\(food.cal)")
                                                }
                                            }
                                            .padding()
                                            .frame(maxWidth: .infinity)
                                            .background(Color(UIColor(hex: "#F7F7F7")))
                                            .cornerRadius(20)
                                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                                        }
                                        .buttonStyle(PlainButtonStyle())
                                        .listRowSeparator(.hidden)
                                        .listRowInsets(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                                        
                                    }
                                }else{
                                    ForEach(viewModel.filteredFoods) { food in
                                        Button(action: {
                                            selectedFood = food
                                        }) {
                                            HStack {
                                                Image(food.image)
                                                    .resizable()
                                                    .frame(width: 100, height: 100)
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
                                
                                
                            }else {
                                ForEach(viewModel.filteredFoods) { food in
                                    Button(action: {
                                        selectedFood = food
                                    }) {
                                        HStack {
                                            Image(food.image)
                                                .resizable()
                                                .frame(width: 100, height: 100)
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
                        .frame(width: 800)
                        
                        .sheet(item: $selectedFood) { food in
                            FoodDetailView(food: food)
                        }
                    }
                }
            }
            .onChange(of: searchText){ newValue in
                viewModel.search(with: newValue)
            }
        }
    }
}

struct FoodInformationView_Previews: PreviewProvider {
    static var previews: some View {
        FoodInformationView()
    }
}
