//
//  LoginView.swift
//  BmiBros
//
//  Created by MacBook Pro on 20/05/23.
//

import SwiftUI

struct LoginView: View {
    //deklarasi variable
    @State private var email: String = ""
    @State private var password: String = ""
    
    
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
            SecureField("Password", text: $password)
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
            HStack{
                //text 1
                Text("New around here? ")
                    .foregroundColor(Color.black)
                    .padding(.trailing, -5)
                //text 2
                Text("Sign Up")
                    .foregroundColor(Color(UIColor(hex: "#98A8F8")))
            }.padding(.vertical,10)
            
           

            
            
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
