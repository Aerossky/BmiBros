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
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(appEnviroment)
        }
    }
}
