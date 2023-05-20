//
//  homeView.swift
//  BmiBros
//
//  Created by MacBook Pro on 20/05/23.
//

import SwiftUI

struct homeView: View {
    var body: some View {
        VStack {
                    HStack {
                        Text("Hello, Nama")
                            .font(.custom("Poppins-Bold", size: 36))
                            .padding(.leading)
                        Spacer()
                    }
                    Spacer()
                    Image("nama-foto-profil")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.trailing)
                        .padding(.top, 20)
                }
        .padding(25)
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        homeView()
    }
}
