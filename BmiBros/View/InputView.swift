//
//  InputView.swift
//  BmiBros
//
//  Created by MacBook Pro on 20/05/23.
//

import SwiftUI

struct InputView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        Text("Calculation Result")
                            .font(.custom("Poppins-SemiBold", size: 24))
                            .foregroundColor(Color(UIColor(hex: "#76AAFA")))
                    }
                }
                .padding(.top, 20)
                .padding(.bottom,20)
            }
            .padding(.leading, 20)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("")
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
        }
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
