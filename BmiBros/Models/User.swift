//
//  User.swift
//  BmiBros
//
//  Created by MacBook Pro on 22/05/23.
//

import Foundation
import SwiftUI

//extension UserViewModel {
struct User: Identifiable, Equatable {
    let id: UUID
    var username: String
    let email: String
    var password: String
    let gender: String
}

