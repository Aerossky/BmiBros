//
//  SignUpView.swift
//  BmiBros
//
//  Created by MacBook Pro on 21/05/23.
//
import SwiftUI

struct SignUpView: View {
    
    @Environment(\.horizontalSizeClass) var horizontalSizeClass //variabel untuk tau ukuran device yang dipake
    
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var viewModel: UserViewModel
    @EnvironmentObject var appEnvironment: AppEnvironment
    
    @State private var isEmailValid: Bool = true
    @State private var isPasswordValid: Bool = true
    @State private var navigateToSignUp = false
    
    @State private var showSignUpSuccessAlert = false
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var gender: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var selectedGender = 0
    
    var genderOptions = ["Male", "Female"]
    @State private var isSignUpButtonAnimating = false
    
    var body: some View {
        if horizontalSizeClass == .compact {
            NavigationStack {
                VStack {
                    Image("signup")
                        .frame(width: 262, height: 263)
                        .animation(.spring())
                    
                    Text("Sign Up")
                        .font(.custom("Poppins-Bold", size: 24))
                        .frame(width: 360, alignment: .leading)
                        .animation(.spring())
                    
                    TextField("Username", text: $username)
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
                        .padding(.horizontal)
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
                    .padding(.horizontal)
                    .onChange(of: password) { newValue in
                        viewModel.validatePassword(newValue)
                    }
                    
                    if !viewModel.isPasswordValid {
                        if !password.contains(where: { $0.isUppercase }) {
                            Text("Password must contain at least one uppercase letter")
                                .foregroundColor(.red)
                                .font(.custom("Poppins-Light", size: 12))
                                .multilineTextAlignment(.leading)
                                .frame(width: 360, alignment: .leading)
                        }  else if(password.count < 8){
                            Text("Password must be at least 8 characters")
                                .foregroundColor(.red)
                                .font(.custom("Poppins-Light", size: 12))
                                .multilineTextAlignment(.leading)
                                .frame(width: 360, alignment: .leading)
                        }
                        
                    }
                    
                    Picker("Gender", selection: $selectedGender) {
                        ForEach(0..<genderOptions.count) { index in
                            Text(genderOptions[index])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(height: 50)
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text("By signing up, you have read and agreed to our")
                            .font(.custom("Poppins-Light", size: 15))
                            .padding(.horizontal)
                        NavigationLink("Terms & conditions", destination: ContentView())
                            .font(.custom("Poppins-Bold", size: 15))
                            .foregroundColor(Color(UIColor(hex: "#6D85FD")))
                            .padding(.horizontal)
                    }
                    
                    VStack {
                        Button(action: {
                            if(selectedGender == 0){
                                gender = "male"
                            }else{
                                gender = "female"
                            }
                            
                            viewModel.registerUser(username: username, email: email, password: password, gender: gender)
                            showSignUpSuccessAlert = true
                            //                        showSignUpSuccessAlert = false
                            
                        }) {
                            Text("Sign Up")
                                .font(.custom("Poppins-SemiBold", size: 16))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(UIColor(hex: "#98A8F8")))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .alert(isPresented: $showSignUpSuccessAlert) {
                            Alert(
                                title: Text("Sign Up Successful \(username)"),
                                message: Text("You have successfully registered!"),
                                dismissButton: .default(Text("OK")) {
                                    navigateToSignUp = true
                                }
                            )
                        }
                        .fullScreenCover(isPresented: $navigateToSignUp) {
                            SignInView()
                        }
                        .disabled(username.isEmpty || email.isEmpty || password.isEmpty || !viewModel.isPasswordValid)
                        // Mengatur tombol menjadi nonaktif jika username, email, atau password kosong
                        .opacity(username.isEmpty || email.isEmpty || password.isEmpty || !viewModel.isPasswordValid ? 0.5 : 1) // Mengatur opasitas tombol
                        
                        
                        HStack {
                            Text("Already have an account?")
                            NavigationLink("Sign In", destination: SignInView())
                                .font(.custom("Poppins-Bold", size: 15))
                                .foregroundColor(Color(UIColor(hex: "#6D85FD")))
                        }
                        .font(.custom("Poppins-Light", size: 15))
                        .padding(.top)
                    }
                }
            }
            .toolbar(.hidden, for: .navigationBar)
        }else{
            NavigationStack {
                VStack {
                    Image("signupiPad")
                        .frame(width: 500, height: 500)
                        .animation(.spring())
                    
                    Text("Sign Up")
                        .font(.custom("Poppins-Bold", size: 36))
                        .frame(width: 360, alignment: .center)
                        .animation(.spring())
                    
                    TextField("Username", text: $username)
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
                        .padding(.horizontal)
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
                    .padding(.horizontal)
                    .onChange(of: password) { newValue in
                        viewModel.validatePassword(newValue)
                    }
                    
                    if !viewModel.isPasswordValid {
                        if !password.contains(where: { $0.isUppercase }) {
                            Text("Password must contain at least one uppercase letter")
                                .foregroundColor(.red)
                                .font(.custom("Poppins-Light", size: 12))
                                .multilineTextAlignment(.leading)
                                .frame(width: 360, alignment: .leading)
                        }  else if(password.count < 8){
                            Text("Password must be at least 8 characters")
                                .foregroundColor(.red)
                                .font(.custom("Poppins-Light", size: 12))
                                .multilineTextAlignment(.leading)
                                .frame(width: 360, alignment: .leading)
                        }
                        
                    }
                    
                    Picker("Gender", selection: $selectedGender) {
                        ForEach(0..<genderOptions.count) { index in
                            Text(genderOptions[index])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(height: 50)
                    .padding(.horizontal)
                    
                    VStack(alignment: .leading) {
                        Text("By signing up, you have read and agreed to our")
                            .font(.custom("Poppins-Light", size: 17))
                            .padding(.horizontal)
                        NavigationLink("Terms & conditions", destination: ContentView())
                            .font(.custom("Poppins-Bold", size: 17))
                            .foregroundColor(Color(UIColor(hex: "#6D85FD")))
                            .padding(.horizontal)
                    }
                    
                    VStack {
                        Button(action: {
                            if(selectedGender == 0){
                                gender = "male"
                            }else{
                                gender = "female"
                            }
                            
                            viewModel.registerUser(username: username, email: email, password: password, gender: gender)
                            showSignUpSuccessAlert = true
                            //                        showSignUpSuccessAlert = false
                            
                        }) {
                            Text("Sign Up")
                                .font(.custom("Poppins-SemiBold", size: 19))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(UIColor(hex: "#98A8F8")))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .alert(isPresented: $showSignUpSuccessAlert) {
                            Alert(
                                title: Text("Sign Up Successful \(username)"),
                                message: Text("You have successfully registered!"),
                                dismissButton: .default(Text("OK")) {
                                    navigateToSignUp = true
                                }
                            )
                        }
                        .fullScreenCover(isPresented: $navigateToSignUp) {
                            SignInView()
                        }
                        .disabled(username.isEmpty || email.isEmpty || password.isEmpty || !viewModel.isPasswordValid)
                        // Mengatur tombol menjadi nonaktif jika username, email, atau password kosong
                        .opacity(username.isEmpty || email.isEmpty || password.isEmpty || !viewModel.isPasswordValid ? 0.5 : 1) // Mengatur opasitas tombol
                        
                        
                        HStack {
                            Text("Already have an account?")
                            NavigationLink("Sign In", destination: SignInView())
                                .font(.custom("Poppins-Bold", size: 17))
                                .foregroundColor(Color(UIColor(hex: "#6D85FD")))
                        }
                        .font(.custom("Poppins-Light", size: 17))
                        .padding(.top)
                    }
                }
                .padding(.horizontal, 165)
            }
            .toolbar(.hidden, for: .navigationBar)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(SessionManager())
            .environmentObject(UserViewModel())
            .environmentObject(AppEnvironment())
    }
}
