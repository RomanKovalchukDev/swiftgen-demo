//
//  ErrorToastView.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import SwiftUI

struct ErrorToastView: View {
    let error: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "exclamationmark.circle.fill")
                .resizable()
                .frame(width: 24, height: 24)
                .foregroundStyle(Color.white)
            
            Text(error)
                .padding(.top, 3) // Magic number, to align in the center of the image
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .padding(.horizontal, 24)
        .background(Color.red)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .padding(.horizontal, 16)
    }
}

#Preview {
    VStack {
        ErrorToastView(error: "Wehe long long long long long long long long long text")
        ErrorToastView(error: "Wj")
        Spacer()
    }
}
