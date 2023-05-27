//
//  InputView.swift
//  BmiBros
//
//  Created by MacBook Pro on 20/05/23.
//

import SwiftUI

struct InputView: View {
    @State private var selectedOption = 0
    let options = ["BMI Calculator", "Calories Calculator"]
    
    var body: some View {
        VStack {
            Picker("Pilih Konten", selection: $selectedOption) {
                ForEach(0..<options.count) { index in
                    Text(options[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 50)
            //            Spacer()
            if selectedOption == 0 {
                BMIView()
                
            } else {
                CaloriesView()
            }
        }
    }
    
    struct BMIView: View {
        //variable data
        @State private var Gender = ""
        @State private var Height = ""
        @State private var Weight = ""
        @State private var Age = ""
        @State private var selectedHeight = "40"
        @State private var selectedWeight = "20"
        @State private var selectedAge = "20"
        
        //picker gender
        @State private var selectedGender = 0
        let genderOptions = ["Man", "Woman"]
        
        let minHeight = 40
        let maxHeight = 300
        let minWeight = 20
        let maxWeight = 300
        let minAge = 1
        let maxAge = 200
        
        @State private var activeAlert: ActiveAlert?
        enum ActiveAlert: Identifiable {
            case Weight, Height, Age, SuccessInput
            
            var id: Int {
                // Return a unique identifier for each case
                switch self {
                case .Weight:
                    return 0
                case .Height:
                    return 1
                case .Age:
                    return 2
                case .SuccessInput:
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
                            
                            Text("Obesitas")
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
                                VStack{
                                    TextField("Enter a number", text: $selectedWeight)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.numberPad)
                                        .padding(.leading, 20)
                                        .padding(.trailing, 20)
                                }
                                
                            }
                            .padding(.leading, 20)
                            
                            HStack {
                                Text("Age")
                                    .font(.custom("Poppins-Bold", size: 20))
                                    .foregroundColor(Color(UIColor(hex: "#76AAFA")))
                                VStack{
                                    TextField("Enter a number", text: $selectedAge)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.numberPad)
                                        .padding(.leading, 54)
                                        .padding(.trailing, 20)
                                }
                                
                            }
                            .padding(.leading, 20)
                            Spacer()
                            
                            Button(action: {
                                if !isInputHeightValid {
                                    activeAlert = .Height
                                }
                                else if(!isInputWeightValid){
                                    activeAlert = .Weight
                                }
                                else if(!isInputAgeValid){
                                    activeAlert = .Age
                                }
                                else if isInputHeightValid && isInputWeightValid && isInputAgeValid {
                                    Text("SUCCESS") // ini ganti buat lempar data
                                    activeAlert = .SuccessInput
                                }
                            }) {
                                Text("Submit")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background((isInputHeightValid  && isInputWeightValid && isInputAgeValid) ? Color.blue : Color.gray)
                                //                                .background(isInputWeightValid ? Color.blue : Color.gray)
                                    .cornerRadius(8)
                            }
                            .padding()
                            .alert(item: $activeAlert) { alertType in
                                switch alertType {
                                case .Weight:
                                    return Alert(title: Text("Invalid Input"), message: Text("Weight Must Between \(minWeight) and \(maxWeight) ."), dismissButton: .default(Text("OK")))
                                case .Height:
                                    return Alert(title: Text("Invalid Input"), message: Text("Height Must Between \(minHeight) and \(maxHeight) ."), dismissButton: .default(Text("OK")))
                                case .Age:
                                    return Alert(title: Text("Invalid Input"), message: Text("Age Must Between \(minAge) and \(maxAge) ."), dismissButton: .default(Text("OK")))
                                    
                                case .SuccessInput:
                                    return Alert(title: Text("Success"), message: Text("Data updated successfully!"), dismissButton: .default(Text("OK")))
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
    
    struct CaloriesView: View {
        //variable data
        @State private var Gender = ""
        @State private var Height = ""
        @State private var Weight = ""
        @State private var Age = ""
        @State private var selectedHeight = "40"
        @State private var selectedWeight = "20"
        @State private var selectedAge = "20"
        
        //picker gender
        @State private var selectedGender = 0
        let genderOptions = ["Man", "Woman"]
        
        let minHeight = 40
        let maxHeight = 300
        let minWeight = 20
        let maxWeight = 300
        let minAge = 1
        let maxAge = 200
        
        @State private var activeAlert: ActiveAlert?
        
        enum ActiveAlert: Identifiable {
            case Weight, Height, Age, SuccessInput
            
            var id: Int {
                // Return a unique identifier for each case
                switch self {
                case .Weight:
                    return 0
                case .Height:
                    return 1
                case .Age:
                    return 2
                case .SuccessInput:
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
                            Text("Your Daily Calories")
                                .font(.custom("Poppins-Bold", size: 32))
                                .foregroundColor(Color(UIColor(hex: "#76AAFA")))
                            
                            Text("2456")
                                .font(.custom("Poppins-Bold", size: 96))
                                .foregroundColor(.green)
                            
                            Text("Calories/day")
                                .font(.custom("Poppins-Bold", size: 32))
                                .foregroundColor(Color(UIColor(hex: "#76AAFA")))
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
                                VStack{
                                    TextField("Enter a number", text: $selectedWeight)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.numberPad)
                                        .padding(.leading, 20)
                                        .padding(.trailing, 20)
                                }
                                
                            }
                            .padding(.leading, 20)
                            
                            HStack {
                                Text("Age")
                                    .font(.custom("Poppins-Bold", size: 20))
                                    .foregroundColor(Color(UIColor(hex: "#76AAFA")))
                                VStack{
                                    TextField("Enter a number", text: $selectedAge)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.numberPad)
                                        .padding(.leading, 54)
                                        .padding(.trailing, 20)
                                }
                                
                            }
                            .padding(.leading, 20)
                            Spacer()
                            
                            Button(action: {
                                if !isInputHeightValid {
                                    activeAlert = .Height
                                }
                                else if(!isInputWeightValid){
                                    activeAlert = .Weight
                                }
                                else if(!isInputAgeValid){
                                    activeAlert = .Age
                                }
                                else if isInputHeightValid && isInputWeightValid && isInputAgeValid {
                                    Text("SUCCESS") // ini ganti buat lempar data
                                    activeAlert = .SuccessInput
                                }
                            }) {
                                Text("Submit")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background((isInputHeightValid  && isInputWeightValid && isInputAgeValid) ? Color.blue : Color.gray)
                                //                                .background(isInputWeightValid ? Color.blue : Color.gray)
                                    .cornerRadius(8)
                            }
                            .padding()
                            .alert(item: $activeAlert) { alertType in
                                switch alertType {
                                case .Weight:
                                    return Alert(title: Text("Invalid Input"), message: Text("Weight Must Between \(minWeight) and \(maxWeight) ."), dismissButton: .default(Text("OK")))
                                case .Height:
                                    return Alert(title: Text("Invalid Input"), message: Text("Height Must Between \(minHeight) and \(maxHeight) ."), dismissButton: .default(Text("OK")))
                                case .Age:
                                    return Alert(title: Text("Invalid Input"), message: Text("Age Must Between \(minAge) and \(maxAge) ."), dismissButton: .default(Text("OK")))
                                    
                                case .SuccessInput:
                                    return Alert(title: Text("Success"), message: Text("Data updated successfully!"), dismissButton: .default(Text("OK")))
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
}



struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}

