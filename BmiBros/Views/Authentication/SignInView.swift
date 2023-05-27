//
//  SignInView.swift
//  BmiBros
//
//  Created by MacBook Pro on 21/05/23.
//
import SwiftUI
import AuthenticationServices

struct SignInView: View {
    //describe view model
    @EnvironmentObject private var viewModel: UserViewModel

    //    @State private var username = ""
    //    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var showLoginSuccessAlert = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isSignInSuccessful: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {

        
                Image("login")
                    .resizable()
                    .frame(width: 262, height: 263)

                
                //EMAIL
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
//                EMAIL VALIDATOR
//                    .onChange(of: email) { newValue in
//                        viewModel.validateEmail(newValue)
//                    }
//
//                if !viewModel.isEmailValid {
//                    Text("Invalid email format")
//                        .foregroundColor(.red)
//                        .font(.custom("Poppins-Light", size: 12))
//                        .multilineTextAlignment(.leading)
//                        .frame(width: 360, alignment: .leading)
//                }
                
                //PASSWORD
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
                //password validator
//                .onChange(of: password) { newValue in
//                    viewModel.validatePassword(newValue)
//                }
//
//                if !viewModel.isPasswordValid {
//
//                    if !password.contains(where: { $0.isUppercase }) {
//                        Text("Password must contain at least one uppercase letter")
//                            .foregroundColor(.red)
//                            .font(.custom("Poppins-Light", size: 12))
//                            .multilineTextAlignment(.leading)
//                            .frame(width: 360, alignment: .leading)
//                    }  else if(password.count < 8){
//                        Text("Password must be at least 8 characters")
//                            .foregroundColor(.red)
//                            .font(.custom("Poppins-Light", size: 12))
//                            .multilineTextAlignment(.leading)
//                            .frame(width: 360, alignment: .leading)
//                    }
//
//                }
                

                
                Button(action: {
//                    // Aksi tombol login
//                    isLoggedIn = viewModel.loginUser(email: email, password: password)
//                    if isLoggedIn {
//                        showLoginSuccessAlert = true
//                    } else {
//                        showLoginSuccessAlert = false
//                    }
                    
                    // Aksi tombol login
                       isLoggedIn = viewModel.loginUser(email: email, password: password)
                       if isLoggedIn {
                           showLoginSuccessAlert = true
                           isSignInSuccessful = true // Set the flag to true
                       } else {
                           showLoginSuccessAlert = false
                           isSignInSuccessful = false // Set the flag to false
                       }
                }) {
                    Text("Sign In")
                        .font(.custom("Poppins-SemiBold", size: 16))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(UIColor(hex: "#98A8F8")))
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .alert(isPresented: $showLoginSuccessAlert) {
                            Alert(
                                title: Text("Login Successful"),
                                message: Text("You have successfully logged in!"),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                .background(
                    NavigationLink(
                        destination: ContentView().navigationBarBackButtonHidden(true), //ini ak ganti jadi contentview soalnya kalo lempar ke homeview gaada tabviewnya
                        isActive: $isLoggedIn,
                        label: {
                            EmptyView()
                        }
                    )
                )
//                BUTTON DISABLE
//                .disabled(email.isEmpty || password.isEmpty || !viewModel.isPasswordValid) // Mengatur tombol menjadi nonaktif jika username, email, atau password kosong
//                .opacity(email.isEmpty || password.isEmpty || !viewModel.isPasswordValid ? 0.5 : 1) // Mengatur opasitas tombol
                
                
                VStack {
                    if isSignInSuccessful {
                        NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) { // ini jg ak ganti biar bar backnya hilang
                            Text("Continue")
                        }
                    } else {
                        SignInWithAppleButton(.continue) { request in
                            request.requestedScopes = [.fullName, .email]
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
        SignInView().environmentObject(UserViewModel())
    }
}
