//
//  ProfileView.swift
//  BmiBros
//
//  Created by MacBook Pro on 26/05/23.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var viewModel: UserViewModel
    @EnvironmentObject var appEnvironment: AppEnvironment
    
    enum Country: String, CaseIterable {
        case Indonesia
        case Japan
        case USA
        case Other
        
        func getLocalizedCountry() -> String {
            return rawValue
        }
    }
    
    @State private var profilePictureSelection: PhotosPickerItem?
    @State private var profilePictureObject: UIImage?
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var passwordConfirmation: String = ""
    @State private var showPassword: Bool = false
    @State private var passwordSecurityCheckProgress: Double = 0
    @State private var isPasswordLengthValid: Bool = false
    @State private var showLogoutAlert = false
    
    @State private var ageHidden: Bool = false
    @State private var age: Double = 18
    
    @State private var country: Country = .Indonesia
    @State private var customizedCountry: String = ""
    @State private var dateOfBirth: Date = Calendar.current.date(byAdding: .year, value: -20, to: Date()) ?? Date()
    
    var body: some View {
        
        NavigationStack {
            
            Form {
                
                Section("Profile picture") {
                    HStack {
                        Spacer()
                        VStack {
                            if let profilePictureObject {
                                Image(uiImage: profilePictureObject)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width: 150, height: 150)
                            }
                            PhotosPicker("Pick a profile picture", selection: $profilePictureSelection)
                                .onChange(of: profilePictureSelection) { newValue in
                                    Task(priority: .userInitiated) {
                                        if let newValue {
                                            // PhotosPickerItem -> Data -> UIImage -> SwiftUI Image
                                            if let loadedImageData = try? await
                                                newValue.loadTransferable(type: Data.self),
                                               // mac os use NSImage
                                               let loadedImage = UIImage(data: loadedImageData)
                                            {
                                                self.profilePictureObject = loadedImage
                                            }
                                        }
                                    }
                                }
                        }
                        Spacer()
                        
                    }
                }
                
                Section {
                    Text("Current Username")
                    TextField("New Username", text: $username)
                        .keyboardType(.asciiCapable)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                } header: {
                    Text("Username")
                }
                
                Section("Password") {
                    HStack {
                        if showPassword {
                            TextField("New Password", text: $password)
                                .keyboardType(.asciiCapable)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                        } else {
                            SecureField("New Password", text: $password)
                                .keyboardType(.asciiCapable)
                                .autocorrectionDisabled(true)
                                .textInputAutocapitalization(.never)
                        }
                        Button {
                            self.showPassword.toggle()
                        } label: {
                            Image(systemName: self.showPassword ? "eye" : "eye.slash")
                        }
                    }
                    if !password.isEmpty {
                        VStack(alignment: .leading) {
                            Label("minimal of 5 characters", systemImage: isPasswordLengthValid ? "checkmark" : "xmark")
                                .foregroundColor(isPasswordLengthValid ? .green : .red)
                        }
                        Gauge(value: passwordSecurityCheckProgress) {
                            Label("Password security", systemImage: passwordSecurityCheckProgress >= 0.5 ? "checkmark" : "xmark")
                                .foregroundColor(passwordSecurityCheckProgress >= 0.5 ? .green : .red)
                        }
                    }
                    SecureField("Confirm Password", text: $passwordConfirmation)
                        .keyboardType(.asciiCapable)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                    if !password.isEmpty, !passwordConfirmation.isEmpty, password != passwordConfirmation {
                        Label("Password confirmation does not match", systemImage: "xmark.circle")
                            .foregroundColor(.red)
                    } else if !password.isEmpty, !passwordConfirmation.isEmpty, password == passwordConfirmation {
                        Label("Password confirmation match", systemImage: "checkmark.circle")
                            .foregroundColor(.green)
                    }
                }
                .onChange(of: password) { newValue in
                    withAnimation {
                        self.passwordSecurityCheckProgress = isSecurePassword(newValue)
                        self.isPasswordLengthValid = newValue.count >= 5
                    }
                }
                
                Section("Age") {
                    Toggle("Hide your age", isOn: $ageHidden)
                    HStack {
                        Slider(value: $age, in: 2...120, step: 1)
                        Text("\(Int(age)) years")
                    }
                }
                
                Section("Test Section") {
                    Picker("Country of origin", selection: $country) {
                        ForEach(Country.allCases, id: \.self.rawValue) { countryID in
                            Text(countryID.getLocalizedCountry())
                                .tag(countryID)
                        }
                    }
                    if country == .Other {
                        TextField("Which country are you from?", text: $customizedCountry)
                    }
                    DatePicker("Date of birth", selection: $dateOfBirth, displayedComponents: .date)
                }
                
                Button(action: {
                    viewModel.logoutUser()
                    showLogoutAlert = true
                }) {
                    Text("Sign Out")
                }
                .alert(isPresented: $showLogoutAlert) {
                    Alert(
                        title: Text("Success"),
                        message: Text("You have logged out."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                .background(NavigationLink(destination: IntroductionView()
                    .navigationBarBackButtonHidden(true),
                    label: {
                        EmptyView()
                    })
                )
                
            }
//            .navigationTitle("Profile Settings")
//            .navigationBarTitleDisplayMode(.inline)
            //            .toolbar {
            //                ToolbarItem(placement: .navigationBarTrailing) {
            //                    Button("Submit") {
            //                        // fill later
            //                    }
            //                    .disabled(!isPasswordLengthValid || passwordSecurityCheckProgress < 0.5)
            //                }
            //            }
        }
    }
    
    private func isSecurePassword(_ password: String) -> Double {
        var passwordStrengthScore: Double = 0
        
        let lowercaseLetterRegEx = ".*[a-z]+.*"
        let uppercaseLetterRegEx = ".*[A-Z]+.*"
        let digitRegEx = ".*[0-9]+.*"
        let specialCharacterRegEx = ".*[!@#$%^&*]+.*"
        
        let lowercaseLetterPredicate = NSPredicate(format: "SELF MATCHES %@", lowercaseLetterRegEx)
        let uppercaseLetterPredicate = NSPredicate(format: "SELF MATCHES %@", uppercaseLetterRegEx)
        let digitPredicate = NSPredicate(format: "SELF MATCHES %@", digitRegEx)
        let specialCharacterPredicate = NSPredicate(format: "SELF MATCHES %@", specialCharacterRegEx)
        
        if password.count >= 8 { passwordStrengthScore += 1 }
        if lowercaseLetterPredicate.evaluate(with: password) { passwordStrengthScore += 1 }
        if uppercaseLetterPredicate.evaluate(with: password) { passwordStrengthScore += 1 }
        if digitPredicate.evaluate(with: password) { passwordStrengthScore += 1 }
        if specialCharacterPredicate.evaluate(with: password) { passwordStrengthScore += 1 }
        
        return passwordStrengthScore / 5
    }
    
    private func isValidString(_ input: String) -> Bool {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_")
        let inputCharacters = CharacterSet(charactersIn: input)
        return allowedCharacters.isSuperset(of: inputCharacters)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(SessionManager())
            .environmentObject(UserViewModel())
            .environmentObject(AppEnvironment())
    }
}
