//
//  ContentView.swift
//  Eco-logic
//
//  Created by Clarissa Alverina on 25/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isActive = false
    @State private var size = 0.5
    @State private var opacity = 0.5
    
    var body: some View {
        if isActive {
            HomeView()
        } else {
                VStack{
                    VStack {
                        Spacer()
                        Image("logo")
                            .padding(.leading, 27)
                            .padding(.bottom, 10)
                        
                        Text("Eco-Logic")
                            .fontWeight(.bold)
                            .font(.title)
                            .foregroundColor(.black)
                        
                    }
                    .padding(.bottom, 250)
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                } .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        self.isActive = true
                    }
                } .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(hex: 0xE9DB93))
            }
        }
    }


extension Color {
    init(hex: Int, opacity: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: opacity
        )
    }
}
    
    

#Preview {
    ContentView()
}


