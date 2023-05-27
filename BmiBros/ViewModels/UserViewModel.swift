//
//  UserViewModel.swift
//  BmiBros
//
//  Created by MacBook Pro on 23/05/23.
//

import Foundation
import Combine

class UserViewModel: ObservableObject {
    @Published var idLogin = 0
    @Published var users: [User] = []
    @Published var userInfos: [UserInfo]
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
        userInfos = [
//            UserInfo(id: 2, userId: "1", age: 30, height: 170, weight: 70, bmi: 0, calories: 0, date: Date()),
//            UserInfo(id: 2, userId: "1", age: 30, height: 170, weight: 90, bmi: 0, calories: 0, date: Date()),
//            UserInfo(id: 3, userId: "1", age: 30, height: 170, weight: 90, bmi: 0, calories: 0, date: Date()),
            UserInfo(id: 1, userId: "1", age: 30, height: 170, weight: 90, bmi: 0, calories: 0, date: Date()),
            UserInfo(id: 2, userId: "2", age: 25, height: 160, weight: 55, bmi: 0, calories: 0, date: Date())
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


    //authentication
    func registerUser(username: String, email: String, password: String, gender: String) {
        let newUser = User(username: username, email: email, password: password, gender: gender)
        users.append(newUser)

        debugPrint(users)
    }
    
    func loginUser(email: String, password: String) -> Bool {
        if let index = users.firstIndex(where: { $0.email == email && $0.password == password }) {
            debugPrint(idLogin)
            idLogin = index
            return true
        }
        debugPrint(idLogin)
        return false
    }

    
    //user
    func updateUserData(id: Int, newWeight:Double){
        if let index = userInfos.firstIndex(where: { $0.id == id }) {
            userInfos[index].weight = newWeight
        }
        debugPrint(userInfos)
    }
    
    func checkLogin(){
        debugPrint(idLogin)

    }
    
    
    //function getUserId
    //function getUserData(filter by id)
    //function updateUserData
    //function logout
}
