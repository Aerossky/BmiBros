//
//  SignInView.swift
//  BmiBros
//
//  Created by MacBook Pro on 21/05/23.
//
import SwiftUI
import AuthenticationServices

struct SignInView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass //variabel untuk tau ukuran device yang dipake
    
    //describe view model
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var viewModel: UserViewModel
    @EnvironmentObject var appEnvironment: AppEnvironment
    let conn = iOSConnectivityManager()
    
    //    @State private var username = ""
    //    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var showLoginSuccessAlert = false
    @State private var showLoginFailAlert = false
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var isSignInSuccessful: Bool = false
    
    var body: some View {
        if horizontalSizeClass == .compact {
            NavigationStack {
                VStack {
                    Image("login")
                        .resizable()
                        .frame(width: 262, height: 263)
                    
                    Text("Sign In")
                        .font(.custom("Poppins-Bold", size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    TextField("Email", text: $email)
                        .keyboardType(.asciiCapable)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
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
                        .onChange(of: email) { newValue in
                            viewModel.validateEmail(newValue)
                        }
                    
                    if !viewModel.isEmailValid {
                        Text("Invalid email format")
                            .foregroundColor(.red)
                            .font(.custom("Poppins-Light", size: 12))
                            .multilineTextAlignment(.leading)
                            .frame(width: 360, alignment: .leading)
                    }
                                        
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                                .keyboardType(.asciiCapable)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                        } else {
                            SecureField("Password", text: $password)
                                .keyboardType(.asciiCapable)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
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
                    
                    Button(action: {
                        isLoggedIn = viewModel.loginUser(email: email, password: password)
                        if isLoggedIn {
                            conn.sendID(userID: viewModel.loggedInUser?.id.uuidString ?? "") 
                            showLoginSuccessAlert = true
                        } else {
                            showLoginFailAlert = true
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
                    .alert(isPresented: $showLoginFailAlert) {
                        Alert(
                            title: Text("Login Failed"),
                            message: Text("Please check your login details and try again!"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    .navigationDestination(isPresented: $isLoggedIn){
                        ContentView()
                            .navigationBarBackButtonHidden(true)
                        
                    }
                    //                BUTTON DISABLE
                    .disabled(email.isEmpty || password.isEmpty || !viewModel.isPasswordValid) // Mengatur tombol menjadi nonaktif jika username, email, atau password kosong
                    .opacity(email.isEmpty || password.isEmpty || !viewModel.isPasswordValid ? 0.5 : 1) // Mengatur opasitas tombol
                    
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
                                case .success(_):
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
        }else{
            NavigationStack {
                VStack {
                    
                    Image("login")
                        .resizable()
                        .frame(width: 500, height: 500)
                        .frame(alignment: .center)
                    
                    
                    Text("Sign In")
                        .font(.custom("Poppins-Bold", size: 36))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 30)
                        .padding(.bottom, 130)
                    
                    
                    TextField("Email", text: $email)
                        .keyboardType(.asciiCapable)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
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
                        .onChange(of: email) { newValue in
                            viewModel.validateEmail(newValue)
                        }
                    
                    if !viewModel.isEmailValid {
                        Text("Invalid email format")
                            .foregroundColor(.red)
                            .font(.custom("Poppins-Light", size: 12))
                            .multilineTextAlignment(.leading)
                            .frame(width: 360, alignment: .leading)
                    }
                    
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $password)
                                .keyboardType(.asciiCapable)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                        } else {
                            SecureField("Password", text: $password)
                                .keyboardType(.asciiCapable)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
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
                    
                    Button(action: {
                        isLoggedIn = viewModel.loginUser(email: email, password: password)
                        if isLoggedIn {
                            conn.sendID(userID: viewModel.loggedInUser?.id.uuidString ?? "") 
                            showLoginSuccessAlert = true
                        } else {
                            showLoginFailAlert = true
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
                    .alert(isPresented: $showLoginFailAlert) {
                        Alert(
                            title: Text("Login Failed"),
                            message: Text("Please check your login details and try again!"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    .navigationDestination(isPresented: $isLoggedIn){
                        ContentView()
                            .navigationBarBackButtonHidden(true)
                        
                    }
                    //                BUTTON DISABLE
                    .disabled(email.isEmpty || password.isEmpty || !viewModel.isPasswordValid) // Mengatur tombol menjadi nonaktif jika username, email, atau password kosong
                    .opacity(email.isEmpty || password.isEmpty || !viewModel.isPasswordValid ? 0.5 : 1) // Mengatur opasitas tombol
                
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
                                case .success(_):
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
                .padding(.horizontal, 162)
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(SessionManager())
            .environmentObject(UserViewModel())
            .environmentObject(AppEnvironment())
    }
}
