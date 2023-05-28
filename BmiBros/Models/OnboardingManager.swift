//
//  OnboardingManager.swift
//  BmiBros
//
//  Created by MacBook Pro on 28/05/23.
//

import Foundation

struct OnboardingItem: Identifiable {
    let id = UUID()
    let imageName: String
    let title: String
    let description: String
}

extension OnboardingItem: Equatable {}

final class OnboardingManager: ObservableObject {
    
    @Published private(set) var items: [OnboardingItem] = []
    
    func load() {
        items = [
            .init(imageName: "introduction",
                  title: "BMI Bros 1",
                  description: "BMI Bros, teman sehat Anda! Hitung BMI dan lacak kalori dengan mudah. Bergabunglah dan mulailah perjalanan hidup sehat anda."),
            .init(imageName: "introduction",
                  title: "BMI Bros 2",
                  description: "BMI Bros, teman sehat Anda! Hitung BMI dan lacak kalori dengan mudah. Bergabunglah dan mulailah perjalanan hidup sehat anda."),
            .init(imageName: "introduction",
                  title: "BMI Bros 3",
                  description: "BMI Bros, teman sehat Anda! Hitung BMI dan lacak kalori dengan mudah. Bergabunglah dan mulailah perjalanan hidup sehat anda.")
        ]
    }
}
