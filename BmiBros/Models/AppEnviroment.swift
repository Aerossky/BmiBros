//
//  AppEnviroment.swift
//  BmiBros
//
//  Created by MacBook Pro on 27/05/23.
//

import Foundation

//cara menggunakan idGlobal
//@EnvironmentObject var appEnvironment: AppEnvironment
//@EnvironmentObject  var userViewModel: UserViewModel

//jangan lupa pada view tambahkan
//.environmentObject(AppEnvironment()).environmentObject(UserViewModel())

class AppEnvironment: ObservableObject {
    @Published var idLogin: Int?
}
