//
//  SessionManager.swift
//  BmiBros
//
//  Created by MacBook Pro on 28/05/23.
//

import Foundation

final class SessionManager: ObservableObject {
    
    enum UserDefaultKeys {
        static let  hasSeenOnboarding = "hasSeenOnboarding"
    }
    
    enum CurrentState {
        case loggedIn
        case loggedOut
        case onboarding
        case signup
    }
    
    @Published private(set) var currentState: CurrentState?
    
    func signIn() {
        currentState = .loggedIn
    }
    
    func signOut() {
        currentState = .loggedOut
    }
    
    func completeOnboarding() {
        currentState = .loggedOut
        UserDefaults.standard.set(true, forKey: UserDefaultKeys.hasSeenOnboarding)
    }
    
    func configureCurrentState() {
        let hasCompletedOnboarding = UserDefaults.standard.bool(forKey: UserDefaultKeys.hasSeenOnboarding)
        currentState = hasCompletedOnboarding ? .loggedOut : .onboarding
    }
}
