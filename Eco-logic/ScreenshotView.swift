//
//  ScreenshotView.swift
//  Eco-logic
//
//  Created by Clarissa Alverina on 29/04/24.
//

import SwiftUI
import AVFoundation

var player3: AVAudioPlayer!

struct ScreenshotView: View {
    @State private var isMaxBrightness = false
    @State private var isPhotoVisible = false
    @State private var opacity = 1.0
    @State private var buttonEnabled = false

    var body: some View {
        VStack {
            ZStack {
                Image("bg screenshot")
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                
                if isPhotoVisible {
                    ZStack {
                        Image("bulletin board")
                        Image("polaroid")
                            .resizable()
                            .frame(width: 350, height: 500)
                            .padding(.bottom, 120)
                        
                        VStack {
                            NavigationLink(destination: DarkLightView().navigationBarBackButtonHidden(true)) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 180, height: 45)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .foregroundColor(Color(hex: 0x822E4C))
                                        )
                                    
                                    ZStack{
                                        
                                        Image(systemName: "arrow.right")
                                            .resizable()
                                            .frame(width: 30, height: 20)
                                            .padding()
                                            .foregroundColor(Color.white)
                                            .bold()
                                            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                                    }
                                }
                            }
                            .padding(.top, 650)
                            .foregroundColor(Color(hex: 0x822E4C))
                        }
                        
                        Rectangle()
                            .edgesIgnoringSafeArea(.all)
                            .foregroundColor(.white)
                            .opacity(opacity)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 1.0)) {
                                    self.opacity = 0
                                }
                            }
                    }
                }
                
            }
            
        } .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in
            isPhotoVisible = true
            
        } .navigationBarBackButtonHidden(true)
        
    }
    
    private func playSound3() {
        let url = Bundle.main.url(forResource: "Explosion Sound", withExtension: "mp3")
        
        guard url != nil else {
            return
        }
        do {
            player3 = try AVAudioPlayer(contentsOf: url!)
            player3?.play()
        } catch {
            print("error")
        }
    }
    
}

#Preview {
    ScreenshotView()
}
