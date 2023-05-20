//
//  InputView.swift
//  BmiBros
//
//  Created by MacBook Pro on 20/05/23.
//

import SwiftUI

struct InputView: View {
    var body: some View {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .frame(width: 40, height: 50)
                        .foregroundColor(Color(UIColor(hex: "#76AAFA")))
                        .alignmentGuide(.top) { d in d[.bottom] }
                    Text("Calculation Result")
                        .font(.custom("Poppins-SemiBold", size: 24))
                        .foregroundColor(Color(UIColor(hex: "#76AAFA")))
                        .alignmentGuide(.top) { d in d[.top] }
                }
                Spacer()
            }
        }
}

struct InputView_Previews: PreviewProvider {
    static var previews: some View {
        InputView()
    }
}
