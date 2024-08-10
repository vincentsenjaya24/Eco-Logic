//
//  ContentView.swift
//  Height-DarkMode
//
//  Created by Vincent Senjaya on 29/04/24.
//

import SwiftUI

struct DarkLightView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isDarkMode: Bool = false
    @State private var isAnimating = false
      var body: some View {
          VStack {
              Image(colorScheme == .dark ? "" : "bat_sleep")
                  .resizable()
                  .scaledToFit()
              HStack{
                  Spacer()
                  Image("DarkMode").resizable() .foregroundColor( colorScheme == .dark ? .gray : .white).frame(width: 50,height: 50).animation(
                        isAnimating ?
                      .easeInOut(duration: 1).repeatForever(autoreverses: true) :
                      .default,
                    value: isAnimating
                  )
                  .onAppear {
                    isAnimating = true
                  }
                  Spacer()
                  
              }
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(
              Image(colorScheme == .dark ? "black" : "cave_dark")
                  .resizable()
                  .scaledToFill()
                  .edgesIgnoringSafeArea(.vertical)
          )
          .onChange(of: colorScheme) { newColorScheme in
              if newColorScheme == .dark {
                  isDarkMode = true
                  // Navigate to another page here
              } else {
                  isDarkMode = false
              }
          }
          .fullScreenCover(isPresented: $isDarkMode) {
              // Replace "DestinationView" with the view you want to navigate to
              GeometryReader{
                  let size = $0.size
                  DarkView(size: size)
              }
              
          }
          .onAppear {
              HapticManager.instance.notification(type: .success)
          }
          
      }
}

#Preview {
    DarkLightView()
}
