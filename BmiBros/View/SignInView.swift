//
//  SignInView.swift
//  BmiBros
//
//  Created by MacBook Pro on 21/05/23.
//
import SwiftUI
import AuthenticationServices

struct SignInView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isSignInSuccessful = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Image("login")
                    .resizable()
                    .frame(width: 262, height: 263)
                Spacer()
                Text("Sign In")
                    .font(.custom("Poppins-Bold", size: 24))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                
                TextField("Email", text: $email)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(UIColor(hex: "#ffffff")))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                    )
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                
                HStack {
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
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(UIColor(hex: "#ffffff")))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black, lineWidth: 1)
                        )
                )
                .frame(maxWidth: .infinity)
                .padding(.horizontal)
                Spacer()
                
                Button(action: {
                    // Aksi tombol login
                    
                }) {
                    NavigationLink(destination: ContentView()) {
                        Text("Sign In")
                            .font(.custom("Poppins-SemiBold", size: 16))
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(UIColor(hex: "#98A8F8")))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
                
                VStack {
                           if isSignInSuccessful {
                               NavigationLink(destination: ContentView()) {
                                   Text("Continue")
                               }
                           } else {
                               SignInWithAppleButton(.continue) { request in
                                   request.requestedScopes = [.email]
                               } onCompletion: { result in
                                   switch result {
                                   case .success(let authResults):
                                       print("Authorization successful")
                                       isSignInSuccessful = true  // Set the flag to true
                                   case .failure(let error):
                                       print("Authorization failed: \(error.localizedDescription)")
                                   }
                               }
                               .padding(.horizontal)
                               .cornerRadius(10)
                               .signInWithAppleButtonStyle(.black)
                               .frame(height: 50)
                           }
                       }
                
//                Button(action: {
//                    // Aksi tombol sign in with apple
//                }) {
//                    HStack {
//                        Image(systemName: "applelogo")
//                            .resizable()
//                            .frame(width: 18, height: 22)
//                        Text("Sign in with Apple")
//                            .foregroundColor(.white)
//                            .font(.system(size: 16, weight: .bold))
//                            .frame(height: 22)
//                            .padding(.top, 5)
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .frame(maxWidth: .infinity)
//                    .background(Color.black)
//                    .cornerRadius(10)
//                }
//                .padding(.horizontal)
                
                HStack {
                    Text("New around here? ")
                        .foregroundColor(.black)
                        .font(.custom("Poppins-Light", size: 15))
                    
                    NavigationLink("Sign Up", destination: SignUpView())
                        .foregroundColor(Color(UIColor(hex: "#6D85FD")))
                        .padding(.horizontal,-5)
                        .font(.custom("Poppins-Bold", size: 15))
                }
                .padding(.vertical, 10)
            }
            .padding(.vertical)
        }
        .toolbar(.hidden, for: .navigationBar)
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
