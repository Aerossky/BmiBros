//
//  homeView.swift
//  BmiBros
//
//  Created by MacBook Pro on 20/05/23.
//

import SwiftUI

struct HomeView: View {
    @State private var isShowingDetail1 = false
    @State private var isShowingDetail3 = false
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    VStack(alignment: .leading){
                        Text("Hello, Rey 👋")
                            .font(.custom("Poppins-Bold", size: 36))
                            .foregroundColor(Color(UIColor(hex: "#609FFF")))
                        Text("How Are You Today?")
                            .font(.custom("Poppins-Regular", size: 16))
                            .foregroundColor(Color(UIColor(hex: "#76AAFA")))
                    }
                    Spacer()
                    Image(systemName: "person")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                }
                .padding(.top, 20)
                .padding(.bottom,20)
                
                HStack{
                    ZStack{
                        Rectangle()
                            .frame(width: 150, height: 125)
                            .foregroundColor(Color(UIColor(hex: "#98A8F8")))
                            .cornerRadius(25)
                        
                        VStack(alignment: .center){
                            var bmi : Double = 40 //ini perlu diganti kalo udh ada backend
                            Text("BMI")
                                .font(.custom("Poppins-SemiBold", size: 32))
                                .foregroundColor(.white)
                            Text(String(format: "%.1f" ,bmi))
                                .font(.custom("Poppins-Light", size: 16))
                                .foregroundColor(.white)
                            if(bmi<18.5){
                                Text("UnderWeight")
                                    .font(.custom("Poppins-SemiBold", size: 16))
                                    .foregroundColor(.yellow)
                            }else if(bmi<24.9){
                                Text("Normal")
                                    .font(.custom("Poppins-SemiBold", size: 16))
                                    .foregroundColor(.green)
                            }else if(bmi<29.9){
                                Text("OverWeight")
                                    .font(.custom("Poppins-SemiBold", size: 16))
                                    .foregroundColor(.red)
                            }else if(bmi<34.9){
                                Text("Obesity Class I")
                                    .font(.custom("Poppins-SemiBold", size: 16))
                                    .foregroundColor(.red)
                            }else if(bmi<39.9){
                                Text("Obesity Class II")
                                    .font(.custom("Poppins-SemiBold", size: 16))
                                    .foregroundColor(.red)
                            }else if(bmi>=40){
                                Text("Obesity Class III")
                                    .font(.custom("Poppins-SemiBold", size: 16))
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    
                    ZStack{
                        var cal: Double = 1000 // ini butuh diganti kalo sdh backend
                        Rectangle()
                            .fill(ImagePaint(image: Image("CalorieShowBG")))
                            .frame(width: 220, height: 125)
                            .cornerRadius(25)
                        
                        
                        VStack(alignment: .center){
                            Text("Calorie Information")
                                .font(.custom("Poppins-Bold", size: 20))
                                .foregroundColor(.white)
                            
                            Text("\(String(format: "%.0f" ,cal))/Day")
                                .font(.custom("Poppins-SemiBold", size: 15))
                                .foregroundColor(.white)
                        }
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
                                .fill(ImagePaint(image: Image("MealRSHBG")))
                                .frame(width: 370, height: 125)
                                .cornerRadius(25)
                            
                            
                            
                            VStack(alignment: .center) {
                                Text("Meal")
                                    .foregroundColor(.white)
                                    .font(.custom("Poppins-Bold", size: 24))
                                
                                Text("Recommendation")
                                    .foregroundColor(.white)
                                    .font(.custom("Poppins-Bold", size: 24))
                            }
                        }
                    }
                    .sheet(isPresented: $isShowingDetail1) {
                        Text("MEAL RECOM VIEW")
                    }
                    .padding(.trailing,15)
                    .padding(.leading,15)
                    
                    Button(action: {
                        // Food Information Button
                    }){
                        NavigationLink(destination: FoodInformationView()) {
                            ZStack{
                                Rectangle()
                                    .fill(ImagePaint(image: Image("FoodInfoBG")))
                                    .frame(width: 370, height: 125)
                                    .cornerRadius(25)
                                
                                Text("Food Information")
                                    .foregroundColor(.white)
                                    .font(.custom("Poppins-Bold", size: 24))
                            }
                        }
                    }
                    
                    Button(action: {
                        isShowingDetail3.toggle()
                    }){
                        ZStack{
                            Rectangle()
                                .fill(ImagePaint(image: Image("GraphBG")))
                                .frame(width: 370, height: 125)
                                .cornerRadius(25)
                            
                            Text("GRAPH")
                                .foregroundColor(.white)
                                .font(.custom("Poppins-Bold", size: 24))
                        }
                    }
                    .sheet(isPresented: $isShowingDetail3) {
                        Text("GRAPH VIEW")
                    }
                    .padding(.trailing,15)
                    .padding(.leading,15)
                }
                Spacer()
            }
            .padding(15)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
