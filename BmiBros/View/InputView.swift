//
//  InputView.swift
//  BmiBros
//
//  Created by MacBook Pro on 20/05/23.
//

import SwiftUI

struct InputView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var Gender = ""
    @State private var Height = ""
    @State private var Weight = ""
    @State private var selectedGender = 0

    @State private var selectedHeight = "40"
    @State private var selectedWeight = "20"
    
    let genderOptions = ["Man", "Woman"]
    let minHeight = 40
    let maxHeight = 300
    let minWeight = 20
    let maxWeight = 300
    
    @State private var activeAlert: ActiveAlert?
    
    enum ActiveAlert: Identifiable {
            case Weight, Height
            
            var id: Int {
                // Return a unique identifier for each case
                switch self {
                case .Weight:
                    return 0
                case .Height:
                    return 1
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
                            .pickerStyle(SegmentedPickerStyle())
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                        }
                        
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
                        Spacer()
                        
                        Button(action: {
                            if !isInputHeightValid {
                                activeAlert = .Height
                            }
                            else if(!isInputWeightValid){
                                activeAlert = .Weight
                            }
                            else if isInputHeightValid && isInputWeightValid {
                                Text("SUCCESS") // ini ganti buat lempar data
                            }
                        }) {
                            Text("Submit")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background((isInputHeightValid  && isInputWeightValid) ? Color.blue : Color.gray)
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
                            }
                        }
                    }
                    
                }
                .padding(.top, 50)
            }
            .multilineTextAlignment(.center)
        }
        .padding(.leading, 20)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Calculate Your BMI")
                        .font(.custom("Poppins-SemiBold", size: 24))
                        .foregroundColor(Color(UIColor(hex: "#76AAFA")))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    
    var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .imageScale(.large)
        }
    }
}



struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}
