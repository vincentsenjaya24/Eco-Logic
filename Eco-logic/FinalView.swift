//
//  FinalView.swift
//  Eco-logic
//
//  Created by Clarissa Alverina on 02/05/24.
//

import SwiftUI
import Lottie

struct FinalView: View {
    var body: some View {
        VStack {
            NavigationLink(destination: HomeView().navigationBarBackButtonHidden(true)){
                LottieView(animation: .named("finish"))
                    .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
            }

        } .background(Color(hex: 0xFFFFFF))
    }
}

#Preview {
    FinalView()
}
