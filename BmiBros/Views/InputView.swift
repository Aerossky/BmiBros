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
        @State private var inputViewModel = InputViewModel()
        //variable data
        @State private var Height = ""
        @State private var Weight = ""
        @State private var Age = ""
        @State private var selectedGender = "male"
        @State private var selectedAge = "2"
        @State private var selectedHeight = "20"
        @State private var selectedWeight = "20"
  
        
        @State private var bmi:Double = 1
        
        @State private var bmiCategory : (String, Color) = ("", .clear)
        @State private var bmiColor : (String, Color) = ("", .clear)

        
        //picker gender
        @State private var gender = 0
        let genderOptions = ["Male", "Female"]
       
        let minHeight = 10
        let maxHeight = 300
        let minWeight = 20
        let maxWeight = 300
        let minAge = 2
        let maxAge = 130
        
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
            guard let value = Double(selectedWeight) else {
                return false
            }
            return Int(Double(value)) >= minWeight && Int(Double(value)) <= maxWeight
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
                            //BMI RESULT
                            Text("\(String(format: "%.1f", bmi))")
                                .font(.custom("Poppins-Bold", size: 96))
                                .foregroundColor(Color(UIColor(hex: "#76AAFA")))
                            //BMI CATEGORY
                            //getBMICategory.{0 = category, 1 = color}
                            Text(bmiCategory.0)
                                .font(.custom("Poppins-Bold", size: 32))
                                .foregroundColor(bmiColor.1)
                            HStack {
                                Text("Gender")
                                    .font(.custom("Poppins-Bold", size: 20))
                                    .foregroundColor(Color(UIColor(hex: "#76AAFA")))
                                Picker("Select an Option", selection: $gender) {
                                    ForEach(0..<genderOptions.count) { index in
                                        Text(genderOptions[index])
                                            .tag(index)
                                    }
                                }
                                .onChange(of: gender) { newValue in
                                    selectedGender = genderOptions[newValue].lowercased()
                                }
                                .padding(.trailing, 20)
                                .pickerStyle(SegmentedPickerStyle())
                                .padding(.leading, 20)
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
                                    //hitung bmmi
                                    bmi = inputViewModel.calculateBMI(weight: Double(selectedWeight) ?? 0, height: Double(selectedHeight) ?? 0, age: Int(selectedAge) ?? 0, gender: selectedGender)
                                     bmiCategory = inputViewModel.getBMICategory(bmi: bmi, age: Int(selectedAge) ?? 0)
                                     bmiColor = inputViewModel.getBMICategory(bmi: bmi, age: Int(selectedAge) ?? 1)
                                    Text("SUCCESS") // ini ganti buat lempar data
                                    activeAlert = .SuccessInput
                                }
                            }) {
                                Text("Check")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background((isInputHeightValid  && isInputWeightValid && isInputAgeValid) ? Color(UIColor(hex: "#6D85FD")): Color.gray)
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
                                    return Alert(title: Text("Success"), message: Text("Bmi Calculate "), dismissButton: .default(Text("OK")))
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
        @State private var inputViewModel = InputViewModel()
        //variable data
        @State private var Height = ""
        @State private var Weight = ""
        @State private var Age = ""
        @State private var selectedGender = "male"
        @State private var selectedAge = "30"
        @State private var selectedHeight = "183"
        @State private var selectedWeight = "75"
        
        //picker gender

        let genderOptions = ["Male", "Female"]
        @State private var gender = 0
        
        let minHeight = 40
        let maxHeight = 300
        let minWeight = 20
        let maxWeight = 300
        let minAge = 1
        let maxAge = 200
        
        @State private var calorie:Double = 1
        
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
                            
                            Text(String(format: "%.0f", calorie))
                                .font(.custom("Poppins-Bold", size: 96))
                                .foregroundColor(.green)
                            
                            Text("Calories/day")
                                .font(.custom("Poppins-Bold", size: 32))
                                .foregroundColor(Color(UIColor(hex: "#76AAFA")))
                            HStack {
                                Text("Gender")
                                    .font(.custom("Poppins-Bold", size: 20))
                                    .foregroundColor(Color(UIColor(hex: "#76AAFA")))
                                Picker("Select an Option", selection: $gender) {
                                    ForEach(0..<genderOptions.count) { index in
                                        Text(genderOptions[index])
                                            .tag(index)
                                    }
                                }
                                .onChange(of: gender) { newValue in
                                    selectedGender = genderOptions[newValue].lowercased()
                                }
                                .padding(.trailing, 20)
                                .pickerStyle(SegmentedPickerStyle())
                                .padding(.leading, 20)
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
                                    calorie = inputViewModel.calculateCalorie(weight: Double(selectedWeight) ?? 0, height: Double(selectedHeight) ?? 0, age: Double(selectedAge) ?? 0, gender: selectedGender)
                                    activeAlert = .SuccessInput
                                }
                            }) {
                                Text("Check")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background((isInputHeightValid  && isInputWeightValid && isInputAgeValid) ? Color(UIColor(hex: "#6D85FD")) : Color.gray)
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
                                    return Alert(title: Text("Success"), message: Text("Calories Calculate"), dismissButton: .default(Text("OK")))
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
