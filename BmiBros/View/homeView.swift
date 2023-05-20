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
                            .font(.custom("Poppins-SemiBold", size: 36))
                            
                        Spacer()
                        
                        Image(systemName: "person")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                    }
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
