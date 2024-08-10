//
//  ExplosiveView.swift
//  Eco-logic
//
//  Created by Clarissa Alverina on 26/04/24.
//

import SwiftUI
import AVFoundation

var player: AVAudioPlayer!

extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}


extension UIWindow {
     open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
     }
}


struct DeviceShakeViewModifier: ViewModifier {
    let action: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.deviceDidShakeNotification)) { _ in
                action()
            }
    }
}


extension View {
    func onShake(perform action: @escaping () -> Void) -> some View {
        self.modifier(DeviceShakeViewModifier(action: action))
    }
}


struct ExplosiveView: View {
    @State private var isExploded = false
    private let explodingBits: Int = 200
    @State private var isFlagVisible = false
    @State private var isBombVisible = true
    @State private var isRuinVisible = true
    @State private var isButtonVisible = false
    @State var isShaken:Bool = false
    @State private var soundPlayed = false
    
    var body: some View {
        VStack {
                Spacer()
            ZStack {
                VStack {
                    Spacer()
                    Image("ground")
                } .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                ZStack {
                    ForEach(0..<explodingBits, id: \.self) { _ in
                        if isBombVisible {
                            Rectangle()
                                .rotation(Angle(degrees: Double.random(in: 0..<360)))
                                .frame(width: 10, height: 10)
                                .foregroundColor(Color(hex: 0x5BA3D6))
                                .offset(x: isExploded ? (Double.random(in: -1...1) * 500) : 0, y: isExploded ? (Double.random(in: -1...1) * 500) : 0)
                                .opacity(isExploded ? 0 : 1)
                                .animation(.easeInOut.speed(0.2), value: isExploded)
                                .padding()
                        }
                    }
                    if isRuinVisible {
                        Image("ruins")
                            .resizable()
                            .frame(width: 280, height: 350)
                            .foregroundColor(.indigo)
                            .opacity(isExploded ? 0 : 1)
                            .animation(.easeInOut.speed(0.2), value: isExploded)
                            .padding(.top, 10)
                            .padding(.leading, 50)
                    }
                    
                    if isButtonVisible {
                        VStack {
                            NavigationLink(destination: ScreenshotView()) {
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
                            .foregroundColor(Color(hex: 0x5A7F99))
                        } .onDisappear {
                            soundPlayed = true
                        }
                    }
                    
                    if isExploded {
                        VStack {
                            if isFlagVisible {
                                Image("flag")
                                    .padding(.top, 140)
                                    .padding(.leading, 50)
                            }
                        } .onAppear {
                            Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false) { timer in
                                isFlagVisible = false
                                isBombVisible = false
                                isRuinVisible = false
                                isButtonVisible = true
                            }
                        }
                    }
                }
                Spacer()
                    .onShake {
                        withAnimation{
                            self.isExploded.toggle()
                        }
                        if !soundPlayed {
                            playSound()
                            
                            if soundPlayed {
                                print("ok")
                            }
                        }
                    }
                    
                VStack {
                    Image("sign")
                        .padding(.trailing, 280)
                        .padding(.top, 150)
                }
            }
            
        } .background(Color(hex: 0x5A7F99))
            .navigationBarBackButtonHidden(true)
    }
    
    private func playSound() {
        let url = Bundle.main.url(forResource: "Explosion Sound", withExtension: "mp3")
        
        guard url != nil else {
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url!)
            player?.play()
        } catch {
            print("error")
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ExplosiveView()
    }
}
