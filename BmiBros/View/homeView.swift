//
//  homeView.swift
//  BmiBros
//
//  Created by MacBook Pro on 20/05/23.
//

import SwiftUI

struct homeView: View {
    @State private var isShowingDetail1 = false
    @State private var isShowingDetail2 = false
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading){
                    Text("Hello, Nama")
                        .font(.custom("Poppins-SemiBold", size: 36))
                    Text("How Are You Today?")
                        .font(.custom("Poppins-Light", size: 16))
                }
                Spacer()
                Image(systemName: "person")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
            }
            .padding(.bottom, 50)
            
            HStack{
                
                ZStack{
                    Rectangle()
                        .frame(width: 150, height: 125)
                        .foregroundColor(.blue)
                        .cornerRadius(25)
                    
                    VStack(alignment: .center){
                        var bmi = 24.3
                        Text("BMI")
                            .font(.custom("Poppins-SemiBold", size: 32))
                            .foregroundColor(.white)
                        Text(String(format: "%.2f" ,bmi))
                            .font(.custom("Poppins-Light", size: 16))
                            .foregroundColor(.white)
//                        if(bmi<18.5){
//                        Text
//                        }
                    }
                }
                
                
                
                ZStack{
                    Rectangle()
                        .frame(width: 220, height: 125)
                        .foregroundColor(.blue)
                        .cornerRadius(25)
                    
                    Text("Tes")
                        .foregroundColor(.black)
                }
                
            }
            .padding(.trailing,15)
            .padding(.leading,15)
            
            VStack{
                Button(action: {
                    isShowingDetail1.toggle()
                }){
                    ZStack{
                        Rectangle()
                            .frame(width: 370, height: 125)
                            .foregroundColor(.blue)
                            .cornerRadius(25)
                        
                        Text("Tes")
                            .foregroundColor(.black)
                    }
                }
                .sheet(isPresented: $isShowingDetail1) {
                    Text("1")
                }
            .padding(.trailing,15)
            .padding(.leading,15)
            
                Button(action: {
                    isShowingDetail2.toggle()
                }){
                    ZStack{
                        Rectangle()
                            .frame(width: 370, height: 125)
                            .foregroundColor(.blue)
                            .cornerRadius(25)
                        
                        Text("Tes")
                            .foregroundColor(.black)
                    }
                }
            }
            .sheet(isPresented: $isShowingDetail2) {
                Text("ASU")
            }
            .padding(.trailing,15)
            .padding(.leading,15)
            Spacer()
            }
            .padding(15)
        }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}
