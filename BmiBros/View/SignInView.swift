//
//  SignInView.swift
//  BmiBros
//
//  Created by MacBook Pro on 21/05/23.
//

import SwiftUI

struct SignInView: View {
    // Deklarasi variable
        @State private var email: String = ""
        @State private var password: String = ""
        @State private var isPasswordVisible: Bool = false // Tambahkan variabel keadaan ini
        
        var body: some View {
            VStack(){
                Spacer()
                Image("login")
                    .frame(width: 262, height: 263)
                // Text Login
                Text("Login")
                    .font(.custom("Poppins-bold", size: 24))
                    .frame(width: 300,alignment: .leading)
                // Text Field Email
                TextField("Email", text: $email)
                    .padding()
                    .frame(width: 300,height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(UIColor(hex: "#ffffff")))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    )
                // Text Field Password
                HStack {
                    //condition when password image get hit
                    if isPasswordVisible {
                        TextField("Password", text: $password)
                    } else {
                        SecureField("Password", text: $password)
                    }
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .frame(width: 300,height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(UIColor(hex: "#ffffff")))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                )
                // Text Field Forgot Password?
                Text("Forgot Password?")
                    .frame(width: 300,alignment: .trailing)
                
                Spacer()
                
                //Button login
                Button(action: {
                    // Aksi tombol login
                }) {
                    Text("Sign In")
                        .font(.custom("Poppins-SemiBold", size: 16))
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300)
                        .background(Color(UIColor(hex: "#98A8F8")))
                        .cornerRadius(10)
                    
                }
                
                //sign in with apple
                Button(action: {
                    // Aksi tombol sign in with apple
                }) {
                    HStack {
                        Image(systemName: "apple.logo")
                            .resizable()
                            .frame(width: 18, height: 22)
                        Text("Sign in with Apple")
                            .foregroundColor(.white)
                            .font(.system(size: 16))
                            .fontWeight(.bold)
                            .frame(height: 22)
                            .padding(.top, 5)
                    }
                    .foregroundColor(Color(UIColor(hex: "#ffffff")))
                    .padding()
                    .frame(width: 300)
                    .background(Color.black)
                    .cornerRadius(10)
                }
                
                //text around here
                HStack {
                    Text("New around here? ")
                        .foregroundColor(Color.black)
                        .padding(.trailing, -5)
                    Text("Sign Up")
                        .foregroundColor(Color(UIColor(hex: "#98A8F8")))
                }
                .padding(.vertical, 10)
            }
        }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
