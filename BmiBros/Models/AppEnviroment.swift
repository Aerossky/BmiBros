//
//  AppEnviroment.swift
//  BmiBros
//
//  Created by MacBook Pro on 27/05/23.
//

import Foundation
import SwiftUI

//cara menggunakan idGlobal
//@EnvironmentObject var appEnvironment: AppEnvironment
//@EnvironmentObject  var userViewModel: UserViewModel

//jangan lupa pada view tambahkan
//.environmentObject(AppEnvironment()).environmentObject(UserViewModel())

class AppEnvironment: ObservableObject {
    @Published var idLogin: UUID?
    @Published var isLoggedIn: Bool = false
//    @Published var loginUser: User = User(id: UUID(), username: "JohnDoe", email: "Admin", password: "1", gender: "Male")
    @Published var loginUser: User?
}
