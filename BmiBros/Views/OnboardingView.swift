//
//  OnboardingView.swift
//  BmiBros
//
//  Created by MacBook Pro on 28/05/23.
//

import SwiftUI

struct OnboardingView: View {
    
    @StateObject private var manager = OnboardingManager()
    @State private var hideIndex = false
    @State private var showButton = false
    let action: () -> Void
    
    var body: some View {
        ZStack {
            
            //            Color(UIColor(hex: "#98A8F8")).ignoresSafeArea()
            
            if !manager.items.isEmpty {
                TabView {
                    
                    ForEach(manager.items) { item in
                        OnboardingInfoView(item: item)
                            .onAppear {
                                if item == manager.items.last {
                                    withAnimation(.spring().delay(0.25)) {
                                        showButton = true
                                    }
                                }
                            }
                            .overlay(alignment: .bottom) {
                                if showButton {
                                    Button("Continue") {
                                        action()
                                    }
                                    .font(.system(size: 20, weight: .bold, design: .rounded))
                                    .frame(width: 150, height: 50)
                                    .background(Color(UIColor(hex: "#98A8F8")), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                                    .offset(y: 50)
                                    .transition(.scale.combined(with: .opacity))
                                }
                            }
                    }
//                    IntroductionView()
//                        .onAppear {
//                            hideIndex = true
//                        }
//                        .onDisappear {
//                            hideIndex = false
//                        }
                }
                .tabViewStyle(.page)
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
        }
        .onAppear(perform: manager.load)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView {}
    }
}
