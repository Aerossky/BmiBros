//
//  MainAppView.swift
//  BmiBros
//
//  Created by MacBook Pro on 28/05/23.
//

import SwiftUI

struct MainAppView: View {
    
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var viewModel: UserViewModel
    @EnvironmentObject var appEnvironment: AppEnvironment
    
    var body: some View {
        ZStack {
            switch session.currentState {
            case .loggedIn:
                // HomeView()
                ContentView()
                    .transition(.opacity)
            case .loggedOut:
                // LoginView()
                IntroductionView()
                    .transition(.opacity)
            case .onboarding:
                OnboardingView(action: session.completeOnboarding)
                    .transition(.opacity)
            default:
                Color(UIColor(hex: "#98A8F8")).ignoresSafeArea()
                Text("Error 101 Kabarin Jovan hehe")
            }
        }
        .animation(.easeInOut, value: session.currentState)
        .onAppear(perform: session.configureCurrentState)
    }
}

struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
            .environmentObject(SessionManager())
            .environmentObject(UserViewModel())
            .environmentObject(AppEnvironment())
    }
}
