//
//  ContentView.swift
//  BmiBros
//
//  Created by MacBook Pro on 15/05/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var viewModel: UserViewModel
    @EnvironmentObject var appEnvironment: AppEnvironment
    
    var body: some View {
        
        if horizontalSizeClass == .compact {
                    // Tampilan untuk iPhone
            if viewModel.loggedInUser != nil{
                NavigationView {
                    TabView {
                        HomeView()
                            .tabItem {
                                Label("Home", systemImage: "square.grid.2x2")
                                    .symbolRenderingMode(.hierarchical)
                            }
                            .tag(0)
                        
                        InputView()
                            .tabItem {
                                Label("Calculate", systemImage: "ruler")
                                    .symbolRenderingMode(.hierarchical)
                            }
                            .tag(1)
                        
                        ProfileView()
                            .tabItem {
                                Label("Account", systemImage: "person.fill")
                                    .symbolRenderingMode(.hierarchical)
                            }
                            .tag(2)
                    }
                }
                
                .accentColor(Color(UIColor(hex: "#6D85FD"))) // Ubah warna ikon yang dipilih di sini
            }else{
                IntroductionView()
            }
                } else {
                    // Tampilan untuk iPad
                    if viewModel.loggedInUser != nil{
                        NavigationStack {
                            TabView {
                                HomeView()
                                    .tabItem {
                                        Label("Home", systemImage: "square.grid.2x2")
                                            .symbolRenderingMode(.hierarchical)
                                    }
                                    .tag(0)
                                
                                InputView()
                                    .tabItem {
                                        Label("Calculate", systemImage: "ruler")
                                            .symbolRenderingMode(.hierarchical)
                                    }
                                    .tag(1)
                                
                                ProfileView()
                                    .tabItem {
                                        Label("Account", systemImage: "person.fill")
                                            .symbolRenderingMode(.hierarchical)
                                    }
                                    .tag(2)
                            }
                        }
                        
                        .accentColor(Color(UIColor(hex: "#6D85FD"))) // Ubah warna ikon yang dipilih di sini
                    }else{
                        IntroductionView()
                    }
                }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SessionManager())
            .environmentObject(UserViewModel())
            .environmentObject(AppEnvironment())
    }
}
