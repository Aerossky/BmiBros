//
//  HistoryUserInfoView.swift
//  BmiBros
//
//  Created by MacBook Pro on 04/06/23.
//

import SwiftUI

struct HistoryUserInfoView: View {
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var viewModel: UserViewModel
    @EnvironmentObject var inputViewModel: InputViewModel
    @EnvironmentObject var appEnvironment: AppEnvironment
    
    var body: some View {
        NavigationView{
            List(viewModel.userInfos, id: \.id) { user in
                ForEach(viewModel.userInfos){ history in
                    if history.userId == viewModel.loggedInUser?.id.uuidString ?? "" {
                        HStack {
                            HStack {
                                Text("BMI")
                                Text("\(Int(user.bmi))")
                                    .font(.headline)
                            }
                            Spacer()
                            HStack {
                                Text("CALS")
                                Text("\(Int(user.calories))")
                            }
                        }
                        .padding()
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
