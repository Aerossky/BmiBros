//
//  ContentView.swift
//  BmiBros Watch App Watch App
//
//  Created by MacBook Pro on 27/05/23.
//

import SwiftUI
import Charts


struct ContentView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    @EnvironmentObject var appEnvironment: AppEnvironment
    @ObservedObject private var connectivity: WatchConnectivityManager = WatchConnectivityManager.shared
    @State private var userID: String = ""
    
    @State private var loggedInUser: User?
    
    var body: some View {
        List {
            Section("BMI Bros") {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "arrow.up.forward")
                        Text("BMI")
                    }
                    .padding(.top, 15)
                    if connectivity.loggedUserID != "" {
                        // User is logged in
                        Text("Your BMI Score")
                            .foregroundColor(.gray)
                            .font(.footnote)
                            .padding(.bottom, 5)
                            .padding(.top, 10)
//                    let getID = connectivity.loggedUserID
                        let bmi = connectivity.bmi
                        Text(String(format: "%.1f", bmi))
                            .foregroundColor(.green)
                            .font(.system(size: 30))
                            .padding(.bottom, 10)
                    } else {
                        // User is not logged in
                        Text("Please log in to view your BMI.")
                            .foregroundColor(.gray)
                            .font(.footnote)
                            .padding(.vertical, 15)
                    }
                }
            }
            
            Section {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "chart.bar.fill")
                        Text("Calories")
                    }
                    .padding(.top, 15)
                    
                    if connectivity.loggedUserID != ""{
                        // User is logged in
                        Text("Your Cals Information")
                            .foregroundColor(.gray)
                            .font(.footnote)
                            .padding(.bottom, 5)
                            .padding(.top, 10)
                        
//                        let getID = loggedInUser.id.uuidString
                        let cal: Double = connectivity.calories
                        
                        HStack {
                            Text(String(format: "%.0f", cal))
                                .font(.system(size: 30))
                            Text("  Cals /day")
                                .font(.footnote)
                        }
                        .padding(.bottom, 10)
                        .foregroundColor(.green)
                    } else {
                        // User is not logged in
                        Text("Please log in to view your calorie information.")
                            .foregroundColor(.gray)
                            .font(.footnote)
                            .padding(.vertical, 15)
                    }
                }
            }
            
        }
        .navigationTitle("BMI Bros")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            loggedInUser = viewModel.loggedInUser
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserViewModel())
            .environmentObject(AppEnvironment())
    }
}
