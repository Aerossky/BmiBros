//
//  ContentView.swift
//  BmiBros Watch App Watch App
//
//  Created by MacBook Pro on 27/05/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var bmi: Double = 24.3
    @State private var cal: Int = 2500
    
    var body: some View {
        List {
            Section("BMI Bros") {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "arrow.up.forward")
                        Text("BMI")
                    }
                    .padding(.top, 15)
                    Text("Your BMI Score")
                        .foregroundColor(.gray)
                        .font(.footnote)
                        .padding(.bottom, 5)
                        .padding(.top, 10)
                    Text(String(format: "%.1f", bmi))
                        .foregroundColor(.green)
                        .font(.system(size: 30))
                        .padding(.bottom, 10)
                }
            }
            
            Section {
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "chart.bar.fill")
                        Text("Calories")
                    }
                    .padding(.top, 15)
                    Text("Your Cals Information")
                        .foregroundColor(.gray)
                        .font(.footnote)
                        .padding(.bottom, 5)
                        .padding(.top, 10)
                    HStack {
                        Text("\(cal)")
                            .font(.system(size: 30))
                        Text("  Cals /day")
                            .font(.footnote)
                    }
                    .padding(.bottom, 10)
                    .foregroundColor(.green)
                }
            }
        }
        .navigationTitle("BMI Bros")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
