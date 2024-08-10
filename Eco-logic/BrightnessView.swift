//
//  TestBrightnessAmin.swift
//  Eco-logic
//
//  Created by Clarissa Alverina on 29/04/24.
//

//
//  ContentView.swift
//  Eco-logic
//
//  Created by Clarissa Alverina on 25/04/24.
//

import SwiftUI
import AVFoundation

var player2: AVAudioPlayer!


struct BrightnessView: View {
    @State private var currentImageIndex = 0
    let imageNames = ["seed fix", "tree1", "tree2", "tree3"]
    let delayInSeconds = 1.0
    @State private var timer: Timer?
    @State private var isMaxBrightness = false
    @State private var isCloudVisible = true
    @State private var buttonEnabled = false
    @State private var isButtonVisible = false
    @State private var soundPlayed2 = false

    
    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    VStack {
                        Image("sun2")
                        Spacer()
                    } .padding(.leading, 220) .padding(.top, 20)
                    
                    if isCloudVisible {
                        VStack {
                            Image("cloud")
                            Spacer()
                        } .padding(.leading, 170)
                            .padding(.top, 30)
                    }
                    
                    VStack {
                        Image("clouds")
                        Spacer()
                    } .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Spacer()
                        Image("trees")
                    } .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        if isCloudVisible {
                            VStack {
                                Image("seed fix")
                            }
                        }
                        
                        if isMaxBrightness {
                            updateImage()
                        }
                        
                    } .padding(.top, 280)
                    
                    if isButtonVisible {
                        Button(action: {
                            buttonEnabled = true
                        }) {
                            VStack {
                                Spacer()
                                NavigationLink(destination: ExplosiveView()) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 180, height: 45)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .foregroundColor(Color(hex: 0xB5C4B5))
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
                                .padding(.top, 200)
                                .padding(.bottom, 20)
                            }
                        } .disabled(!buttonEnabled)
                            .foregroundColor(Color(hex: 0xB5C4B5))
                            .onDisappear {
                                soundPlayed2 = true
                            }
                    }
                }
            } .background(Color(hex: 0xB5C4B5))
        }
        .onReceive(NotificationCenter.default.publisher(for: UIScreen.brightnessDidChangeNotification)) { _ in
            let currentBrightness = UIScreen.main.brightness
            isMaxBrightness = currentBrightness == 1.0
            isCloudVisible = !isMaxBrightness
        }
        
        .navigationBarBackButtonHidden(true)
        
    }
    
    private func playSound2() {
        let url = Bundle.main.url(forResource: "Plant Growing", withExtension: "mp3")
        
        guard url != nil else {
            return
        }
        do {
            player2 = try AVAudioPlayer(contentsOf: url!)
            player2!.play()
        } catch {
            print("error")
        }
    }
    
    private func updateImage() -> some View {
        Image(self.imageNames[currentImageIndex])
            .animation(Animation.easeInOut(duration: 1).delay(1))
            .onAppear {
                startTimer()
                if !soundPlayed2 {
                    playSound2()
                    
                    if soundPlayed2 {
                        print("ok")
                    }
                }
                
                isButtonVisible = true
            }
            .onDisappear {
                stopTimer()
            }
    }
    
    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: delayInSeconds, repeats: true) { _ in
            currentImageIndex = (currentImageIndex + 1) % imageNames.count
            if currentImageIndex == imageNames.count - 1 {
                timer?.invalidate()
                buttonEnabled = true
            }
        }
    }

    private func stopTimer() {
        timer?.invalidate()
        currentImageIndex = 0
    }
    
    
}


#Preview {
    BrightnessView()
}


