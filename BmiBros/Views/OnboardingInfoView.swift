//
//  OnboardingInfoView.swift
//  BmiBros
//
//  Created by MacBook Pro on 28/05/23.
//

import SwiftUI

struct OnboardingInfoView: View {
    
    let item: OnboardingItem
    
    var body: some View {
        VStack(spacing: 0) {
            Image(item.imageName)
                .resizable()
                .frame(width: 320, height: 230)
                .padding(.top, 50)
            Text(item.title)
                .font(.custom("Poppins-bold", size: 36))
                .padding(.horizontal, 10)
                .padding(.vertical, 20)
            Text(item.description)
                .font(.custom("Poppins-Light", size: 14))
                .multilineTextAlignment(.center)
                .padding([.horizontal, .bottom], 20)
        }
    }
}

struct OnboardingInfoView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingInfoView(item: .init(imageName: "introduction",
                                       title: "BMI Bros 1",
                                       description: "BMI Bros, teman sehat Anda! Hitung BMI dan lacak kalori dengan mudah. Bergabunglah dan mulailah perjalanan hidup sehat anda."))
            .previewLayout(.sizeThatFits)
//            .background(Color(UIColor(hex: "#98A8F8")))
    }
}
