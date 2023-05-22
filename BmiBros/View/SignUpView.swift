//
//  SignUpView.swift
//  BmiBros
//
//  Created by MacBook Pro on 21/05/23.
//
import SwiftUI

struct SignUpView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var gender: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var selectedGender = 0
    
    var genderOptions = ["Male", "Female"]
    @State private var isSignUpButtonAnimating = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("signup")
                    .frame(width: 262, height: 263)
                    .animation(.spring()) // Animasi untuk gambar
                
                Spacer()
                
                Text("Sign Up")
                    .font(.custom("Poppins-Bold", size: 24))
                    .frame(width: 360, alignment: .leading)
                    .animation(.spring()) // Animasi untuk judul
                
                TextField("Username", text: $username)
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
                .padding(.horizontal)
                
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
                    
                    Text("Terms & conditions")
                        .foregroundColor(Color(UIColor(hex: "#6D85FD")))
                        .font(.custom("Poppins-Bold", size: 15))
                        .padding(.horizontal)
                }
                
                Spacer()
                
                VStack {
                    Button(action: {
                        // Aksi tombol login
                        isSignUpButtonAnimating.toggle() // Mengubah status animasi tombol
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
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
