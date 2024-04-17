//
//  SwiftUIView.swift
//  PIII
//
//  Created by builder on 3/7/24.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        VStack {
            NavigationLink {
                Text("Hello")
            } label: {
                Text("Sign In With Email")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 55)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            
        }
        .navigationTitle("Sign In")
    }
}

#Preview {
    NavigationStack {
        SwiftUIView()
    }
}
