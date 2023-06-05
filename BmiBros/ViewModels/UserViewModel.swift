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
//    @Published var loginUserInfo: [UserInfo] = []
    @Published var loggedInUser: User?
    //validate variable
    @Published var isEmailValid: Bool = true
    @Published var isPasswordValid: Bool = true
    
    @Published var hasError = false
    @Published var error: SignUpError?
    
    
    init() {
        // Tambahkan kode di bawah ini untuk membuat default data users
        users = [
            User(id: UUID(),username: "Budi", email: "admin@gmail.com", password: "Admin12345", gender: "Male"),
//            User(id: UUID(),username: "JaneSmith", email: "Admin1", password: "2", gender: "Female"),
//            User(id: UUID(),username: "JaneSmith", email: "Admin2", password: "3", gender: "Female"),
//            User(id: UUID(),username: "JaneSmith", email: "Admin3", password: "4", gender: "Female"),
//            User(id: UUID(),username: "JaneSmith", email: "Admin4", password: "5", gender: "Female"),
//            User(id: UUID(),username: "JaneSmith", email: "Admin5", password: "6", gender: "Female"),
            
            // Tambahkan pengguna lainnya sesuai kebutuhan
        ]
        
        userInfos = [
//            UserInfo(id: UUID(), userId: "1", age: 30, height: 170, weight: 90, bmi: 0, calories: 0, date: Date.from(year: 2023, month: 6, day: 4)),
//            UserInfo(id: UUID(), userId: "2", age: 25, height: 160, weight: 55, bmi: 0, calories: 0, date: Date.from(year: 2023, month: 6, day: 5)),
//            UserInfo(id: UUID(), userId: "3", age: 25, height: 160, weight: 55, bmi: 50, calories: 2500, date: Date.from(year: 2023, month: 6, day: 6)),
//            UserInfo(id: UUID(), userId: "4", age: 25, height: 160, weight: 55, bmi: 40, calories: 2550, date: Date.from(year: 2023, month: 6, day: 7)),
//            UserInfo(id: UUID(), userId: "5", age: 25, height: 160, weight: 55, bmi: 45, calories: 2600, date: Date.from(year: 2023, month: 6, day: 8)),
//            UserInfo(id: UUID(), userId: "6", age: 25, height: 160, weight: 55, bmi: 50, calories: 2400, date: Date.from(year: 2023, month: 6, day: 9)),
//            UserInfo(id: UUID(), userId: "7", age: 25, height: 160, weight: 55, bmi: 55, calories: 2450, date: Date.from(year: 2023, month: 6, day: 10))
        ]
    }
    //date convert
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        return dateFormatter.string(from: date)
    }
    //limit name length
  
    func limitWordCount(_ text: String?) -> String {
         guard let text = text else {
             return "Admin"
         }
         
         let words = text.split(separator: " ").map(String.init)
         let truncatedWords = words.prefix(6)
         return truncatedWords.joined(separator: " ")
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
     
//        debugPrint(loggedInUser)
    }

    func updatePassword(id: UUID, newPassword: String) {
        if let index = users.firstIndex(where: { $0.id == id }) {
            users[index].password = newPassword
            //rewrite loggedInUser
            loggedInUser = users[index]
        }
     
//        debugPrint(loggedInUser)
    }
    

    func loginUser(email: String, password: String) -> Bool {
        if let user = users.first(where: { $0.email == email && $0.password == password }) {
            loggedInUser = user
//            debugPrint(loggedInUser)
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
    
    func logoutUser() {
        loggedInUser = nil
    }
    
//    user info
    func getLastUserInfoBMI(_ userID: String) -> Double {
        var loginUserInfo: [UserInfo] = []
        
        for info in userInfos {
            if info.userId == userID {
                loginUserInfo.append(info)
            }
        }
        
        if loginUserInfo.isEmpty {
            return 0.0
        }else{
            
            return loginUserInfo.filter{
//                debugPrint("User info bmi apakah 0? \($0.bmi != 0)")
                return $0.bmi != 0
                
            }.last?.bmi ?? 0
        }
    }
    
    func getLastUserInfoCalories(_ userID: String) -> Double {
        var loginUserInfo: [UserInfo] = []
        
        for info in userInfos {
            if info.userId == userID {
                loginUserInfo.append(info)
            }
        }
        
        if loginUserInfo.isEmpty {
            return 0.0
        }else{
            return loginUserInfo.filter{
//                debugPrint("User info kalori apakah 0? \($0.calories != 0)")
                return $0.calories != 0
                
            }.last?.calories ?? 0
        }
    }
    
    func addUserInfo(_ id:UUID, _ userID: String, _ age: Int, _ height: Double, _ weight: Double, _ bmi: Double, _ calories: Double, _ date: Date){
        let userInfo = UserInfo(id: id, userId: userID, age: age, height: height, weight: weight, bmi: bmi, calories: calories, date: date)
        userInfos.append(userInfo)
        debugPrint(userInfos)
    }

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
