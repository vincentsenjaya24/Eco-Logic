//
//  HomeView.swift
//  Eco-logic
//
//  Created by Clarissa Alverina on 30/04/24.
//

import SwiftUI
import AVFoundation

var player4: AVAudioPlayer!

struct HomeView: View {
    @State private var isPulsating = false
    @State private var soundPlayed4 = true
    @State private var isNavigatingToBrightnessView = false
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack {
                    Image("bg home")
                        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    
                    Image("logo")
                        .padding(.bottom, 700)
                        .padding(.leading, 27)
                        .scaleEffect(0.8)
                    
                    
                    Text("Eco-Logic")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(.bottom, 340)
                    
                    
                    NavigationLink(destination: SpeechView()) {
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.black, lineWidth: 4)
                                    .frame(width: 250, height: 70)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .foregroundColor(Color(hex: 0xFCFFD4))
                                    ) .onAppear {
                                        withAnimation(Animation.easeInOut(duration: 1.5).repeatForever()) {
                                            self.isPulsating = true
                                        }
                                    } .scaleEffect(isPulsating ? 1.2 : 1.0)
                                
                                ZStack{
                                    Image(systemName: "play.fill")
                                        .resizable()
                                        .frame(width: 40, height: 40)
                                        .padding(.leading, 4)
                                        .padding(.top, 1)
                                        .foregroundColor(Color(hex: 0x0E1E01))
                                    
                                    Image(systemName: "play.fill")
                                        .resizable()
                                        .frame(width: 26, height: 26)
                                        .padding()
                                        .foregroundColor(Color(hex: 0x6CC485))
                                        .bold()
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                                } .onAppear {
                                    withAnimation(Animation.easeInOut(duration: 1.5).repeatForever()) {
                                        self.isPulsating = true
                                    }
                                } .scaleEffect(isPulsating ? 1.2 : 1.0)
                            }
                        }
                    }
                    
                }
            }.onAppear(perform: {
                playSound4()
            })
            .onDisappear (perform: {
                soundStop()
            })
        }
    }
    private func playSound4() {
        if soundPlayed4 {
            let url = Bundle.main.url(forResource: "homescreen sound", withExtension: "mp3")
            
            guard url != nil else {
                return
            }
            do {
                player4 = try AVAudioPlayer(contentsOf: url!)
                player4?.play()
            } catch {
                print("error")
            }
        }
    }
    
    private func soundStop() {
            if soundPlayed4 {
                player4?.stop()
            }
        }
}

#Preview {
    HomeView()
}
