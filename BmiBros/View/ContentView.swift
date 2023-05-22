//
//  ContentView.swift
//  BmiBros
//
//  Created by MacBook Pro on 15/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            TabView {
                // Tampilan pertama
                HomeView()
                    .tabItem {
                        Image(systemName: "square.grid.2x2")
                        Text("Home")
                    }
                    .tag(0)
                
                // Tampilan kedua
                InputView()
                    .tabItem {
                        Image(systemName: "ruler")
                        Text("Calculate")
                    }
                    .tag(1)
                
                // Tampilan ketiga
                Text("Third View")
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Account")
                    }
                    .tag(2)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
