//
//  ContentView.swift
//  BmiBros
//
//  Created by MacBook Pro on 15/05/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                // Tampilan pertama
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "square.grid.2x2")
                            .symbolRenderingMode(.hierarchical)
                    }
                    .tag(0)
                
                // Tampilan kedua
                InputView()
                    .tabItem {
                        Label("Calculate", systemImage: "ruler")
                            .symbolRenderingMode(.hierarchical)
                    }
                    .tag(1)
                
                // Tampilan ketiga
                Text("Third View")
                    .tabItem {
                        Label("Account", systemImage: "person.fill")
                            .symbolRenderingMode(.hierarchical)
                    }
                    .tag(2)
            }
        }
        .accentColor(Color(UIColor(hex: "#6D85FD"))) // Ubah warna ikon yang dipilih di sini
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
