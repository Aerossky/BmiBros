//
//  UserViewModel.swift
//  BmiBros
//
//  Created by MacBook Pro on 23/05/23.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    @Published var users: [User] = []
    
    func registerUser(username: String, email: String, password: String) {
        let newUser = User(username: username, email: email, password: password)
        users.append(newUser)
    }
    
    func loginUser(email: String, password: String) -> Bool {
        if let _ = users.first(where: { $0.email == email && $0.password == password }) {
            return true
        }
        return false
    }
}
