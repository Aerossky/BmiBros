//
//  homeView.swift
//  BmiBros
//
//  Created by MacBook Pro on 20/05/23.
//

import SwiftUI
import UIKit

struct HomeView: View {
    // deklarasi variable
    @Environment(\.horizontalSizeClass) var horizontalSizeClass //variabel untuk tau ukuran device yang dipake
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var viewModel: UserViewModel
    @EnvironmentObject var appEnvironment: AppEnvironment
    
    //    @State private var id = userViewModel.appEnvironment.idLogin
    @State private var isShowingDetail1 = false
    @State private var isShowingDetail3 = false
    @State private var id: UUID?
    
    // Hari
    let dateFormatter = DateFormatter()
    
    // Tanggal
    var currentDate: String {
        dateFormatter.dateFormat = "EEEE, dd MMMM yyyy"
        return dateFormatter.string(from: Date())
    }
    
    // Jam
    var isMorning: Bool {
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: Date())
        return hour >= 6 && hour < 18
    }
    
    var body: some View {
        
        if horizontalSizeClass == .compact {
            // Tampilan untuk iPhone
            NavigationStack {
                ScrollView {
                    VStack {
                        let getID = viewModel.loggedInUser?.id.uuidString ?? UUID().uuidString
                        HStack {
                            VStack(alignment: .leading){
                                Text("Hello, \(viewModel.loggedInUser?.username ?? "Admin")")
                                    .font(.custom("Poppins-Bold", size: 36))
                                    .foregroundColor(Color(UIColor(hex: "#609FFF")))
                                Text("\(currentDate)")
                                    .font(.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color(UIColor(hex: "#76AAFA")))
                            }
                            Spacer()
                            Image(isMorning ? "Morning" : "Night")
                                .resizable()
                                .frame(width: 95, height: 75)
                        }
                        .padding(.horizontal, 15)
                        .padding(.top, 20)
                        .padding(.bottom,20)
                        
                        HStack{
                            ZStack{
                                Rectangle()
                                    .frame(width: 150, height: 125)
                                    .foregroundColor(Color(UIColor(hex: "#98A8F8")))
                                    .cornerRadius(25)
                                
                                VStack(alignment: .center){
                                    let bmi = viewModel.getLastUserInfoBMI(getID)//ini perlu diganti kalo udh ada backend
                                    Text("BMI")
                                        .font(.custom("Poppins-SemiBold", size: 25))
                                        .foregroundColor(.white)
                                    Text(String(format: "%.1f" ,bmi))
                                        .font(.custom("Poppins-Light", size: 15))
                                        .foregroundColor(.white)
                                    if(bmi == 0){
                                        Text("")
                                    }
                                    else if(bmi<18.5){
                                        Text("UnderWeight")
                                            .font(.custom("Poppins-SemiBold", size: 16))
                                            .foregroundColor(Color(UIColor(hex: "#ED5656")))
                                    }else if(bmi<24.9){
                                        Text("Normal")
                                            .font(.custom("Poppins-SemiBold", size: 16))
                                            .foregroundColor(Color(UIColor(hex: "#C1FF8F")))
                                    }else if(bmi<29.9){
                                        Text("OverWeight")
                                            .font(.custom("Poppins-SemiBold", size: 16))
                                            .foregroundColor(Color(UIColor(hex: "#FFDF84")))
                                    }else if(bmi<34.9){
                                        Text("Obesity Class I")
                                            .font(.custom("Poppins-SemiBold", size: 16))
                                            .foregroundColor(Color(UIColor(hex: "#FA6657")))
                                    }else if(bmi<39.9){
                                        Text("Obesity Class II")
                                            .font(.custom("Poppins-SemiBold", size: 16))
                                            .foregroundColor(Color(UIColor(hex: "#FF5353")))
                                    }else if(bmi>=40){
                                        Text("Obesity Class III")
                                            .font(.custom("Poppins-SemiBold", size: 16))
                                            .foregroundColor(Color(UIColor(hex: "#ED5656")))
                                    }
                                }
                            }
                            
                            ZStack{
                                let cal = viewModel.getLastUserInfoCalories(getID) // ini butuh diganti kalo sdh backend
                                Rectangle()
                                    .fill(ImagePaint(image: Image("CalorieShowBG")))
                                    .frame(width: 220, height: 125)
                                    .cornerRadius(25)
                                VStack(alignment: .center){
                                    Text("Calorie Information")
                                        .font(.custom("Poppins-Bold", size: 20))
                                        .foregroundColor(.white)
                                    
                                    Text("\(String(format: "%.0f" ,cal))/Day")
                                        .font(.custom("Poppins-Light", size: 15))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        
                        VStack{
                            Button(action: {
                                //food recom button
                            }){
                                NavigationLink(destination: FoodRecommendationView()) {
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
                            }
                            
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
                                            .font(.custom("Poppins-Bold", size: 21))
                                    }
                                }
                            }
                            
                            Button(action: {
                                
                            }){
                                NavigationLink(destination: GraphView()) {
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
                            }
                            .sheet(isPresented: $isShowingDetail3) {
                                VStack {
                                    HStack {
                                        Image("chart")
                                    }
                                }
                                .frame(width: 75, height: 75)
                                .padding(.all)
                            }
                            .padding(.trailing,15)
                            .padding(.leading,15)
                        }
                        Spacer()
                    }
                    .padding(15)
                }
            }
        } else {
            // Tampilan untuk iPad
            NavigationStack {
                ScrollView {
                    VStack {
                        let getID = viewModel.loggedInUser?.id.uuidString ?? UUID().uuidString
                        HStack {
                            VStack(alignment: .leading){
                                Text("Hello, \(viewModel.loggedInUser?.username ?? "Admin")")
                                    .font(.custom("Poppins-Bold", size: 36))
                                    .foregroundColor(Color(UIColor(hex: "#609FFF")))
                                Text("\(currentDate)")
                                    .font(.custom("Poppins-Regular", size: 16))
                                    .foregroundColor(Color(UIColor(hex: "#76AAFA")))
                            }
                            Spacer()
                            Image(isMorning ? "Morning" : "Night")
                                .resizable()
                                .frame(width: 120, height: 90)
                        }
//                        .padding(.horizontal, 120)
                        .frame(maxWidth: horizontalSizeClass == .compact ? .infinity : 800)
                        .padding(.top, 20)
                        .padding(.bottom,20)
                        
                        HStack{
                            ZStack{
                                Rectangle()
                                    .frame(width: 280, height: 196)
                                    .foregroundColor(Color(UIColor(hex: "#98A8F8")))
                                    .cornerRadius(25)
                                
                                VStack(alignment: .center){
                                    let bmi = viewModel.getLastUserInfoBMI(getID)//ini perlu diganti kalo udh ada backend
                                    Text("BMI")
                                        .font(.custom("Poppins-SemiBold", size: 30))
                                        .foregroundColor(.white)
                                    Text(String(format: "%.1f" ,bmi))
                                        .font(.custom("Poppins-Light", size: 24))
                                        .foregroundColor(.white)
                                    if(bmi == 0){
                                        Text("")
                                    }
                                    else if(bmi<18.5){
                                        Text("UnderWeight")
                                            .font(.custom("Poppins-SemiBold", size: 16))
                                            .foregroundColor(Color(UIColor(hex: "#ED5656")))
                                    }else if(bmi<29.9){
                                        Text("OverWeight")
                                            .font(.custom("Poppins-SemiBold", size: 24))
                                            .foregroundColor(Color(UIColor(hex: "#FFDF84")))
                                    }else if(bmi<34.9){
                                        Text("Obesity Class I")
                                            .font(.custom("Poppins-SemiBold", size: 24))
                                            .foregroundColor(Color(UIColor(hex: "#FA6657")))
                                    }else if(bmi<39.9){
                                        Text("Obesity Class II")
                                            .font(.custom("Poppins-SemiBold", size: 24))
                                            .foregroundColor(Color(UIColor(hex: "#FF5353")))
                                    }else if(bmi>=40){
                                        Text("Obesity Class III")
                                            .font(.custom("Poppins-SemiBold", size: 24))
                                            .foregroundColor(Color(UIColor(hex: "#ED5656")))
                                    }
                                }
                            }
                            
                            ZStack{
                                let cal = viewModel.getLastUserInfoCalories(getID) // ini butuh diganti kalo sdh backend
                                Rectangle()
                                    .fill(ImagePaint(image: Image("CalorieShowBGiPad")))
                                    .frame(width: 505, height: 196)
                                    .cornerRadius(25)
                                
                                
                                VStack(alignment: .center){
                                    Text("Calorie Information")
                                        .font(.custom("Poppins-Bold", size: 30))
                                        .foregroundColor(.white)
                                    
                                    Text("\(String(format: "%.0f" ,cal))/Day")
                                        .font(.custom("Poppins-Light", size: 24))
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        
                        VStack{
                            Button(action: {
                                //food recom button
                            }){
                                NavigationLink(destination: FoodRecommendationView()) {
                                    ZStack{
                                        Rectangle()
                                            .fill(ImagePaint(image: Image("MealRecomBGiPad")))
                                            .frame(width: 800, height: 200)
                                            .cornerRadius(25)
                                        
                                        
                                        
                                        VStack(alignment: .center) {
                                            Text("Meal")
                                                .foregroundColor(.white)
                                                .font(.custom("Poppins-Bold", size: 30))
                                            
                                            Text("Recommendation")
                                                .foregroundColor(.white)
                                                .font(.custom("Poppins-Bold", size: 30))
                                        }
                                    }
                                }
                            }
                            .padding(.trailing,15)
                            .padding(.leading,15)
                            
                            Button(action: {
                                // Food Information Button
                            }){
                                NavigationLink(destination: FoodInformationView()) {
                                    ZStack{
                                        Rectangle()
                                            .fill(ImagePaint(image: Image("foodBGiPad")))
                                            .frame(width: 800, height: 200)
                                            .cornerRadius(25)
                                        
                                        Text("Food Information")
                                            .foregroundColor(.white)
                                            .font(.custom("Poppins-Bold", size: 30))
                                    }
                                }
                            }
                            
                            Button(action: {
                                isShowingDetail3.toggle()
                            }){
                                ZStack{
                                    Rectangle()
                                        .fill(ImagePaint(image: Image("GraphBGiPad")))
                                        .frame(width: 800, height: 200)
                                        .cornerRadius(25)
                                    
                                    Text("GRAPH")
                                        .foregroundColor(.white)
                                        .font(.custom("Poppins-Bold", size: 30))
                                }
                            }
                            .sheet(isPresented: $isShowingDetail3) {
                                VStack {
                                    HStack {
                                        Image("chart")
                                    }
                                }
                                .frame(width: 75, height: 75)
                                .padding(.all)
                            }
                            .padding(.trailing,15)
                            .padding(.leading,15)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 15)
                    .padding(.top, 100)
                    .padding(.bottom, 200)
                }
            }
        }
        
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(SessionManager())
            .environmentObject(UserViewModel())
            .environmentObject(AppEnvironment())
    }
}
