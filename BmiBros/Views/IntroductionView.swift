//
//  IntroductionView.swift
//  BmiBros
//
//  Created by MacBook Pro on 20/05/23.
//

import SwiftUI

struct IntroductionView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .center) {
                Image("introduction")
                    .resizable()
                    .frame(width: 320, height: 230)
                    .padding(.top, 50)
                Text("BMI Bros")
                    .font(.custom("Poppins-bold", size: 36))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 20)
                Text("BMI Bros, teman sehat Anda! Hitung BMI dan lacak kalori dengan mudah. Bergabunglah dan mulailah perjalanan hidup sehat anda.")
                    .font(.custom("Poppins-Light", size: 14))
                    .multilineTextAlignment(.center)
                    .padding([.horizontal, .bottom], 20)
                
                Spacer()
                //Button GetStarted
                Button(action: {
                    // Aksi tombol login
                }) {
                    NavigationLink(destination: SignInView()) {
                        Text("Get Started")
                            .font(.custom("Poppins-SemiBold", size: 16))
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 300)
                            .background(Color(UIColor(hex: "#98A8F8")))
                            .cornerRadius(10)
                    }
                    
                }
                //Button Sign Up
                Button(action: {
                    // Kode yang akan dijalankan ketika tombol ditekan
                }) {
                    NavigationLink(destination: SignUpView()) {
                        Text("Sign Up")
                            .foregroundColor(Color(UIColor(hex: "#98A8F8")))
                            .padding()
                            .frame(width: 300)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(UIColor(hex: "#7D7777")), lineWidth: 2)
                            )
                    }
                }
            }
            .padding(.bottom, 10)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct IntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionView()
    }
}
