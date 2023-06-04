//
//  BmiBrosApp.swift
//  BmiBros
//
//  Created by MacBook Pro on 15/05/23.
//

import SwiftUI

@main
struct BmiBrosApp: App {
    var appEnviroment = AppEnvironment()
    
    @StateObject private var session = SessionManager()
    @StateObject private var viewModel = UserViewModel()
    @StateObject private var appEnvironment = AppEnvironment()
    
    var body: some Scene {
        WindowGroup {
            MainAppView()
                .environmentObject(session)
                .environmentObject(viewModel)
                .environmentObject(appEnvironment)
        }
    }
}
