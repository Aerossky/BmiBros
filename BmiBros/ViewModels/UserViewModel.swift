//
//  UserViewModel.swift
//  BmiBros
//
//  Created by MacBook Pro on 23/05/23.
//

import SwiftUI
import Foundation
import Combine

class UserViewModel: ObservableObject {
    
    @Published var users: [User]
    @Published var userInfos: [UserInfo]
    @Published var loginUserInfo: [UserInfo] = []
    @Published var loggedInUser: User?
    //validate variable
    @Published var isEmailValid: Bool = true
    @Published var isPasswordValid: Bool = true
    
    @Published var hasError = false
    @Published var error: SignUpError?
    
    init() {
        // Tambahkan kode di bawah ini untuk membuat default data users
        users = [
            User(id: UUID(),username: "JohnDoe", email: "Admin", password: "1", gender: "Male"),
            User(id: UUID(),username: "JaneSmith", email: "Admin1", password: "2", gender: "Female"),
            User(id: UUID(),username: "JaneSmith", email: "Admin2", password: "3", gender: "Female"),
            User(id: UUID(),username: "JaneSmith", email: "Admin3", password: "4", gender: "Female"),
            User(id: UUID(),username: "JaneSmith", email: "Admin4", password: "5", gender: "Female"),
            User(id: UUID(),username: "JaneSmith", email: "Admin5", password: "6", gender: "Female"),
            
            // Tambahkan pengguna lainnya sesuai kebutuhan
        ]
        userInfos = [
            UserInfo(id: UUID(), userId: "1", age: 30, height: 170, weight: 90, bmi: 0, calories: 0, date: Date()),
            UserInfo(id: UUID(), userId: "2", age: 25, height: 160, weight: 55, bmi: 0, calories: 0, date: Date()),
            UserInfo(id: UUID(), userId: "3", age: 25, height: 160, weight: 55, bmi: 50, calories: 2500, date: Date())
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
    //    func registerUser(username: String, email: String, password: String, gender: String) {
    //        let newUser = User(username: username, email: email, password: password, gender: gender)
    //        users.append(newUser)
    //
    //        debugPrint(users)
    //    }
    
    func registerUser(username: String, email: String, password: String, gender: String) {
        let newUserId = UUID()
        let newUser = User(id: newUserId, username: username, email: email, password: password, gender: gender)
        users.append(newUser)
        
        debugPrint(users)
    }
    
    func updateUsername(id: UUID, newUsername: String) {
        if let index = users.firstIndex(where: { $0.id == id }) {
            users[index].username = newUsername
            //rewrite loggedInUser
            loggedInUser = users[index]
        }
     
        debugPrint(loggedInUser)
    }

    
    
    //    func loginUser(email: String, password: String) -> Bool {
    //        if let index = users.firstIndex(where: { $0.email == email && $0.password == password }) {
    //            appEnvironment.idLogin = index
    //            debugPrint(index)
    //            return true
    //        }
    //        debugPrint(index)
    //        return false
    //    }
    func loginUser(email: String, password: String) -> Bool {
        if let user = users.first(where: { $0.email == email && $0.password == password }) {
            loggedInUser = user
            debugPrint(loggedInUser)
            return true
        } else {
            debugPrint("User not found")
            debugPrint(users)
            return false
        }
    }
    
    
    //user
    
    func getUserData(id: UUID) -> (username: String, email: String, gender: String)? {
        if let user = users.first(where: { $0.id == id }) {
            return (username: user.username, email: user.email, gender: user.gender)
        }
        return nil
    }
    
//    func updateUserData(id: Int, newWeight:Double){
//        if let index = userInfos.firstIndex(where: { $0.id == id }) {
//            userInfos[index].weight = newWeight
//        }
//        debugPrint(userInfos)
//    }
    
    func logoutUser() {
        loggedInUser = nil
    }
    
//    user info
    func getLastUserInfoBMI(_ userID: String) -> Double {
        loginUserInfo = []
        
        for info in userInfos {
            if info.userId == userID {
                loginUserInfo.append(info)
            }
        }
        
        if loginUserInfo.isEmpty {
            return 0.0
        }else{
            return loginUserInfo.last?.bmi ?? 0
        }
    }
    
    func getLastUserInfoCalories(_ userID: String) -> Double {
        loginUserInfo = []
        
        for info in userInfos {
            if info.userId == userID {
                loginUserInfo.append(info)
            }
        }
        
        if loginUserInfo.isEmpty {
            return 0.0
        }else{
            return loginUserInfo.last?.calories ?? 0
        }
    }
    
    func addUserInfo(_ id:UUID, _ userID: String, _ age: Int, _ height: Double, _ weight: Double, _ bmi: Double, _ calories: Double, _ date: Date){
        let userInfo = UserInfo(id: id, userId: userID, age: age, height: height, weight: weight, bmi: bmi, calories: calories, date: date)
        userInfos.append(userInfo)
        debugPrint(userInfos)
    }
    
    //function getUserId
    //function getUserData(filter by id)
    //function updateUserData
    //function logout
}

extension UserViewModel {
    enum SignUpError: LocalizedError {
        case emptyUsername
        case emptyEmail
        case emptyPassword
        
        var errorDescription: String? {
            switch self {
            case .emptyUsername:
                return "Username is empty"
            case .emptyEmail:
                return "Email is empty"
            case .emptyPassword:
                return "Password is empty"
            }
        }
    }
}
