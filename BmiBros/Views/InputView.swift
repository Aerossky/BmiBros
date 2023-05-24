
//
//  InputView.swift
//  BmiBros
//
//  Created by MacBook Pro on 20/05/23.
//

import SwiftUI

struct InputView: View {
    
    // viewModel
    @StateObject private var viewModel = InputViewModel()
    
    @State private var selectedGender = 0
    @State private var selectedHeight = ""
    @State private var selectedWeight = ""
    @State private var selectedAge = ""
    
    let genderOptions = ["Man", "Woman"]
    let minHeight = 40
    let maxHeight = 300
    let minWeight = 20
    let maxWeight = 300
    let minAge = 1
    let maxAge = 200
    
    @State private var activeAlert: ActiveAlert?
    
    enum ActiveAlert: Identifiable {
        case weight, height, age, successInput
        
        var id: Int {
            // Return a unique identifier for each case
            switch self {
            case .weight:
                return 0
            case .height:
                return 1
            case .age:
                return 2
            case .successInput:
                return 3
            }
        }
    }
    
    var isInputHeightValid: Bool {
        guard let value = Int(selectedHeight) else {
            return false
        }
        return value >= minHeight && value <= maxHeight
    }
    
    var isInputWeightValid: Bool {
        guard let value = Int(selectedWeight) else {
            return false
        }
        return value >= minWeight && value <= maxWeight
    }
    
    var isInputAgeValid: Bool {
        guard let value = Int(selectedAge) else {
            return false
        }
        return value >= minAge && value <= maxAge
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        Text("BMI Score")
                            .font(.custom("Poppins-Bold", size: 32))
                            .foregroundColor(Color(UIColor(hex: "#76AAFA")))
                        
                        Text("99.9")
                            .font(.custom("Poppins-Bold", size: 96))
                            .foregroundColor(.red)
                        
                        Text("Obesity")
                            .font(.custom("Poppins-Bold", size: 32))
                            .foregroundColor(.red)
                        
                        HStack {
                            Text("Gender")
                                .font(.custom("Poppins-Bold", size: 20))
                                .foregroundColor(Color(UIColor(hex: "#76AAFA")))
                            
                            Picker("Select an Option", selection: $selectedGender) {
                                ForEach(0..<genderOptions.count) { index in
                                    Text(genderOptions[index])
                                        .tag(index)
                                }
                            }
                            .padding(.trailing, 20)
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.leading, 20)
                        }
                        .padding(.leading, 20)
                        
                        HStack {
                            Text("Height")
                                .font(.custom("Poppins-Bold", size: 20))
                                .foregroundColor(Color(UIColor(hex: "#76AAFA")))
                            
                            TextField("Enter a number", text: $selectedHeight)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .padding(.leading, 25)
                                .padding(.trailing, 20)
                            
                        }
                        .padding(.leading, 20)
                        
                        HStack {
                            Text("Weight")
                                .font(.custom("Poppins-Bold", size: 20))
                                .foregroundColor(Color(UIColor(hex: "#76AAFA")))
                            
                            TextField("Enter a number", text: $selectedWeight)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                            
                        }
                        .padding(.leading, 20)
                        
                        HStack {
                            Text("Age")
                                .font(.custom("Poppins-Bold", size: 20))
                                .foregroundColor(Color(UIColor(hex: "#76AAFA")))
                            
                            TextField("Enter a number", text: $selectedAge)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.numberPad)
                                .padding(.leading, 54)
                                .padding(.trailing, 20)
                            
                        }
                        .padding(.leading, 20)
                        
                        Spacer()
                        
                        Button(action: {
                            if !isInputHeightValid {
                                activeAlert = .height
                            } else if !isInputWeightValid {
                                activeAlert = .weight
                            } else if !isInputAgeValid {
                                activeAlert = .age
                            } else if isInputHeightValid && isInputWeightValid && isInputAgeValid {
                                // Replace the following line with your data submission code
                                activeAlert = .successInput
                            }
                        }) {
                            Text("Submit")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background((isInputHeightValid && isInputWeightValid && isInputAgeValid) ? Color.blue : Color.gray)
                                .cornerRadius(8)
                        }
                        .padding()
                        .alert(item: $activeAlert) { alertType in
                            switch alertType {
                            case .weight:
                                return Alert(title: Text("Invalid Input"), message: Text("Weight must be between \(minWeight) and \(maxWeight)."), dismissButton: .default(Text("OK")))
                            case .height:
                                return Alert(title: Text("Invalid Input"), message: Text("Height must be between \(minHeight) and \(maxHeight)."), dismissButton: .default(Text("OK")))
                            case .age:
                                return Alert(title: Text("Invalid Input"), message: Text("Age must be between \(minAge) and \(maxAge)."), dismissButton: .default(Text("OK")))
                            case .successInput:
                                return Alert(title: Text("Success"), message: Text("\(InputViewModel().nambah(a: Double(selectedHeight) ?? 0, b: Double(selectedWeight) ?? 0, c: Double(selectedAge) ?? 0))"), dismissButton: .default(Text("OK")))
                            }
                        }
                    }
                    
                }
                .padding(.top, 50)
            }
            .multilineTextAlignment(.center)
        }
    }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}
