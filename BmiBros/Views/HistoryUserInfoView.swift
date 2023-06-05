//
//  HistoryUserInfoView.swift
//  BmiBros
//
//  Created by MacBook Pro on 04/06/23.
//

import SwiftUI

struct HistoryUserInfoView: View {
    @State private var selectedOption = 0
    
    let options = ["BMI History", "Calories History"]
    
    var body: some View {
        NavigationView{
            VStack {
                
                Picker("Pilih Konten", selection: $selectedOption) {
                    ForEach(options.indices, id: \.self) { index in
                        Text(options[index]).tag(options[index])
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 50)
                //            Spacer()
                if selectedOption == 0 {
                    BMIHistoryView()
                } else {
                    CaloriesHistoryView()
                }
            }
        }
    }
    
    struct BMIHistoryView: View {
        @EnvironmentObject var session: SessionManager
        @EnvironmentObject var viewModel: UserViewModel
        @EnvironmentObject var inputViewModel: InputViewModel
        @EnvironmentObject var appEnvironment: AppEnvironment
        
        var body: some View{
            List {
                ForEach(viewModel.userInfos) { userInfo in
//                    if userInfo.userId == viewModel.loggedInUser?.id.uuidString {
                        if userInfo.bmi != 0 || userInfo.bmi > 0 {
                            HStack {
                                Text("Date")
                                Text("\(viewModel.formatDate(userInfo.date))")
                                    .font(.headline)
                                Spacer()
                                Text("BMI")
                                Text("\(Int(userInfo.bmi))")
                            }
                            .padding()
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20))
                            .background(Color(UIColor(hex: "#F7F7F7")))
                            .cornerRadius(20)
                            .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                        }
//                    }
                }
            }
            .listStyle(PlainListStyle())
            .accentColor(.clear)
        }
    }
    
    struct CaloriesHistoryView: View {
        @EnvironmentObject var session: SessionManager
        @EnvironmentObject var viewModel: UserViewModel
        @EnvironmentObject var inputViewModel: InputViewModel
        @EnvironmentObject var appEnvironment: AppEnvironment
        
        var body: some View{
            List {
                if viewModel.userInfos.filter({ $0.userId == viewModel.loggedInUser?.id.uuidString && ($0.calories != 0 || $0.calories > 0) }).isEmpty {
                            VStack {
                                Image("noData")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 200)
                                Text("No Data")
                                    .font(.headline)
                                    .padding()
                                    .alignmentGuide(HorizontalAlignment.center) { $0[HorizontalAlignment.center] }
                                     
                            }
                        } else {
                            ForEach(viewModel.userInfos) { userInfo in
                                if userInfo.userId == viewModel.loggedInUser?.id.uuidString && (userInfo.calories != 0 || userInfo.calories > 0) {
                                    HStack {
                                        Text("Date")
                                        Text("\(viewModel.formatDate(userInfo.date))")
                                            .font(.headline)
                                        Spacer()
                                        Text("Cals")
                                        Text("\(Int(userInfo.calories))")
                                    }
                                    .padding()
                                    .background(Color(UIColor(hex: "#F7F7F7")))
                                    .cornerRadius(20)
                                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                                }
                            }
                        }
            }

            .listStyle(PlainListStyle())
            .accentColor(.clear)
        }
    }
}

struct HistoryUserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryUserInfoView()
            .environmentObject(SessionManager())
            .environmentObject(UserViewModel())
            .environmentObject(InputViewModel())
            .environmentObject(AppEnvironment())
        
    }
}
