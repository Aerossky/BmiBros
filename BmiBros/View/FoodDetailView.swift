//
//  FoodDetailView.swift
//  BmiBros
//
//  Created by MacBook Pro on 20/05/23.
//

import SwiftUI

struct FoodDetailView: View {

    var body: some View {
        VStack {
            HStack {
                Image("food Image")
            }.imageScale(.medium).padding(.top, 12).clipShape(Circle()).shadow(radius: 15)
//            text about food
            VStack{
                Text("Nasi Campur Bu Dewi").padding(.top, 12).padding(.bottom, 20)
                Text("Nasi campur Bu Dewi dengan isian ayam udang dan juga lobster khas atlantis").frame(width: 300)
            }
            Spacer()
//            info show
            VStack {
                HStack{
                    ZStack{
                        Circle().frame(width: 75)

                        VStack {
                            Text("Cal")
                            Text("457")
                        }.foregroundColor(.white)
                    }
                    ZStack{
                        Circle().frame(width: 75)

                        VStack {
                            Text("Prot")
                            Text("40g")
                        }.foregroundColor(.white)
                    }
                    ZStack{
                        Circle().frame(width: 75)

                        VStack {
                            Text("Carbs")
                            Text("30g")
                        }.foregroundColor(.white)
                    }
                    ZStack{
                        Circle().frame(width: 75)

                        VStack {
                            Text("fat")
                            Text("2g")
                        }.foregroundColor(.white)
                    }
                }.foregroundColor(.purple).shadow(radius: 7)
            }
        }
    }
}

struct FoodDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FoodDetailView()
    }
}
