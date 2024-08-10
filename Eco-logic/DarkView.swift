//
//  Home.swift
//  Height-DarkMode
//
//  Created by Vincent Senjaya on 30/04/24.
//

import SwiftUI

struct DarkView: View {
    @Environment(\.colorScheme) var colorScheme
    var size : CGSize
    @State private var isExpanded : Bool = true
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                let padding: CGFloat = 30
                let circleSize = (size.width - padding)/5
                ZStack{
                    ShapeMorphingView(systemImage: isExpanded ? "batfly" :  "batfly2", fontSize: isExpanded ? circleSize * 0.9 : 35, color: .black)
                    GroupedShareButtons(size: circleSize, fillColor: false)
                }.frame(height: circleSize)
                Spacer()
                
//                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
//                    Image(systemName: "arrow.right").background(.gray).foregroundColor(.black)
//                        .padding().controlSize(.large).font(.system(size: 30))
//                }).background(.gray)
                
                NavigationLink{
                    GyroscopeView().navigationBarBackButtonHidden(true)
                } label: {
                    Image(systemName: "arrow.right").background(.gray).foregroundColor(.black)
                        .padding().controlSize(.large).font(.system(size: 30))
                }.background(.gray)
                Spacer()
            }
        
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
            .background(Image(colorScheme == .dark ? "background_night" : "cave_dark").resizable().scaledToFill().edgesIgnoringSafeArea(.vertical))
        }
    }
    
    @ViewBuilder
    func GroupedShareButtons(size: CGFloat, fillColor: Bool = true) -> some View{
        Group{
//            ShareButton(size: size, tag: 0, icon: "batfly", showIcon: true){
//                return -size*2
//            }
//            ShareButton(size: size, tag: 0, icon: "batfly", showIcon: true){
//                return -size
//            }
            
            ShareButton(size: size, tag: 0, icon: "", showIcon: true){
                return 0
            }.zIndex(100).onAppear(perform: toggleShareButton)
        }
        .foregroundColor(fillColor ? .black : .clear)
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
    }
    
    @ViewBuilder
    func ShareButton(size: CGFloat, tag: Int, icon: String, showIcon: Bool, offset: @escaping()-> CGFloat) -> some View{
        Circle().frame(width: size, height: size).overlay{
            if icon != "" {
                Image(icon).resizable().renderingMode(.template).aspectRatio(contentMode: .fit).foregroundColor(.white).frame(width: size * 0.3)
                    .opacity(showIcon ? 1 : 0)
                    .scaleEffect(showIcon ? 1 : 0.001)
            }
        }
        .contentShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
        .offset(x: offset())
        .tag(tag)
    }
    
    func toggleShareButton(){
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
                   withAnimation(.interactiveSpring(response: 0.1, dampingFraction: 0.8, blendDuration: 0.4)) {
                       isExpanded.toggle()
                   }
        }
    }
}

#Preview {
    DarkLightView()
}
