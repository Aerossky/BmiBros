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
    //validate variable
    @Published var isEmailValid: Bool = true
    @Published var isPasswordValid: Bool = true
    
    init() {
        // Tambahkan kode di bawah ini untuk membuat default data users
        users = [
            User(username: "JohnDoe", email: "Admin", password: "1", gender: "Male"),
            User(username: "JaneSmith", email: "Admin1", password: "2", gender: "Female"),
            // Tambahkan pengguna lainnya sesuai kebutuhan
        ]
    }
    
    //validate
    func validateEmail(_ email: String) {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        isEmailValid = emailPredicate.evaluate(with: email)
    }
    
    func validatePassword(_ password: String) {

        let passwordRegex = "^(?=.*[A-Z])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        isPasswordValid = passwordPredicate.evaluate(with: password)
    }



    func registerUser(username: String, email: String, password: String, gender: String) {
        let newUser = User(username: username, email: email, password: password, gender: gender)
        users.append(newUser)

        debugPrint(users)
    }
    
    func loginUser(email: String, password: String) -> Bool {
        if let login = users.first(where: { $0.email == email && $0.password == password }) {
            return true
        }        
        debugPrint(users)
        return false
       
    }
}
