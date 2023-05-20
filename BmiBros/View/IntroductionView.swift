//
//  IntroductionView.swift
//  BmiBros
//
//  Created by MacBook Pro on 20/05/23.
//

import SwiftUI

struct IntroductionView: View {
    var body: some View {
        VStack(alignment: .center) {
            Image("introduction")
                .resizable()
                .frame(width: 320, height: 230)
                .padding(.top, 50)
            Text("BMI Bros")
                .font(.custom("Poppins-bold", size: 36))
                .padding(.horizontal, 10)
                .padding(.vertical, 20)
            Text("BMI Bros, teman setia untuk hidup sehat Anda! Aplikasi ini menyediakan penghitung BMI dan pelacak kalori yang praktis. Mari bergabung dengan kami dan mulai perjalanan menuju gaya hidup yang lebih baik dengan memilih opsi di bawah ini")
                .font(.custom("Poppins", size: 14))
                .multilineTextAlignment(.leading)
                .padding([.horizontal, .bottom], 20)
            Spacer()
            //Button GetStarted
            Button(action: {
                // Kode yang akan dijalankan ketika tombol ditekan
            }) {
                Text("Get Started")
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 280)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            //Button Sign In
            Button(action: {
                // Kode yang akan dijalankan ketika tombol ditekan
            }) {
                Text("Sign In")
                    .foregroundColor(.black)
                    .padding()
                    .frame(width: 280)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 2)
                    )
            }
        }
        .padding(.bottom, 10)
        
        
        
        
        
        
    }
}

struct IntroductionView_Previews: PreviewProvider {
    static var previews: some View {
        IntroductionView()
    }
}
