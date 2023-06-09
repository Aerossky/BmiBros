//
//  BmiBros_Watch_AppApp.swift
//  BmiBros Watch App Watch App
//
//  Created by MacBook Pro on 27/05/23.
//

import SwiftUI

@main
struct BmiBros_Watch_App_Watch_AppApp: App {
    
    @StateObject private var viewModel = UserViewModel()
    @StateObject private var appEnvironment = AppEnvironment()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .environmentObject(appEnvironment)
        }
    }
}
