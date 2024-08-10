//
//  ShapeMorphingView.swift
//  Height-DarkMode
//
//  Created by Vincent Senjaya on 30/04/24.
//

import SwiftUI

struct ShapeMorphingView: View {
    var systemImage: String
    var fontSize: CGFloat
    var color: Color = .white
    var duration: CGFloat = 0.5
    @State private var newImage  : String = ""
    @State private var radius  : CGFloat = 0
    @State private var animatedRadiusValue  : CGFloat = 0
    

    var body: some View {
        GeometryReader{
            let size = $0.size
            Canvas{ ctx, size in
                ctx.addFilter(.alphaThreshold(min: 0.5,color: color))
                ctx.addFilter(.blur(radius: animatedRadiusValue))
                ctx.drawLayer { ctx1 in
                    if let resolvedImageView = ctx.resolveSymbol(id: 0) {
                        ctx1.draw(resolvedImageView, at: CGPoint(x: size.width/2, y: size.height/2))
                    }
                }
            } symbols: {
                ImageView(size: size).tag(0)
            }
        }
        .onAppear{
            if newImage == "" {
                newImage = systemImage
            }
        }
        .onChange(of: systemImage){ newValue in
            newImage = newValue
            withAnimation(.linear(duration: 0.2).speed(2)){
                radius = 12
            }
        }
        .animationProgress(endValue: radius){
            value in animatedRadiusValue = value
            
            if value >= 6{
                withAnimation(.linear(duration: 0.2).speed(2)){
                    radius = 0
                }
            }
        }
    }
    
    @ViewBuilder
    func ImageView(size: CGSize) -> some View{
        if newImage != ""{
            Image(newImage) // Use the image name directly
                        .resizable() // Make the image resizable
                        .aspectRatio(contentMode: .fit) // Ensure the aspect ratio is maintained
                        .frame(width: size.width, height: size.height)
                        .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.9, blendDuration: 0.9), value : newImage)
                        .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.9, blendDuration: 0.9), value : fontSize)
        }
    }
}

#Preview {
    DarkLightView()
}
