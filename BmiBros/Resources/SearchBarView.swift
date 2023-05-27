//
//  SearchBarView.swift
//  BmiBros
//
//  Created by MacBook Pro on 24/05/23.
//
import SwiftUI

struct SearchBarView: View {
    @Binding var searchText: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search", text: $searchText)
                .foregroundColor(.primary)
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.horizontal)
        .frame(height: 50)
        .background(Color.white)
        .cornerRadius(50)
        .padding()
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2) // Memberikan efek bayangan

    }
}
