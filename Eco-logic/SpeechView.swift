import SwiftUI
import SwiftUISpeechToText

struct SpeechView: View {
    
    @State private var speechText: String = ""
    @State private var buttonEnabled = true
    @State private var speechAction: SpeechAction = .update
    @State private var imageSleep = "sleep1"
    @State private var color: Color = .gray
    let imageWakeAction = ["sleep1", "stand", "stand2", "stand3"]
    private let delayInSeconds = 0.5
    @State private var timer: Timer?
    let speechWord = ["wake up","get up","wake","up"] // Change to let
    @State private var isModalVisible = false // State for showing/hiding modal
    @State private var isButton2Visible = false
    
    var body: some View {
        VStack {
            ZStack {

                VStack {
                    Image("bg-build")
                        .resizable()
                        .scaledToFill()
                        .frame(width: .screenWidth, height: .screenHeight/1.5)
                }.edgesIgnoringSafeArea(.all) .padding(.bottom, 333)
                VStack{
                    Image("Image 2")
                        .resizable()
                        .frame(width: 500)
                }.edgesIgnoringSafeArea(.all) .padding(.bottom, 205)
                VStack{
                    Image("lamp")
                        .resizable()
                        .frame(width: 300, height: 300)
                }.padding(.top, 160)
                
                if isButton2Visible {
                    VStack {
                        NavigationLink(destination: BrightnessView()) {
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
                        .padding(.bottom, 500)
                        .foregroundColor(Color(hex: 0x17141A))
                    }
                }
                
                ZStack {
                    
                    VStack {
                        HStack {
                            GeometryReader { geometry in
                                Image(self.imageSleep)
                                    .resizable()
                                    .frame(width: 300, height: 300)
                                    .animation(Animation.easeInOut(duration: 1).delay(1))
                                    .alignmentGuide(HorizontalAlignment.trailing) { _ in
                                        geometry.size.width / 1.5
                                    }
                                    .alignmentGuide(VerticalAlignment.center) { _ in
                                        geometry.size.height / 80
                                    }
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .rotationEffect(.degrees(0))
                            }.padding(.top, 200)
                        }
                        VStack {
                            Spacer()
                            HStack(alignment: .bottom) {
                                Spacer()
                                SpellCastButton(
                                    micIconWidth: 45,
                                    micIconHeight: 55,
                                    isRecording: false,
                                    color: .gray,
                                    speechText: $speechText,
                                    speechAction: $speechAction
                                )
                                Spacer()
                            }.padding(.bottom, 20)
                        }
                        .onChange(of: speechAction) { newValue in
                            if speechWord.contains(speechText.lowercased()) && newValue == .update {
                                print("Detected speech word: \(speechText.lowercased())")
                                print("Speech word list: \(speechWord)")
                                updateImage()
                            } else {
                                print("no update")
                                resetImage()
                            }
                        }
                    }
                }
            }
            .padding()
        } .navigationBarBackButtonHidden(true)
        .sheet(isPresented: $isModalVisible) {
            ModalView(
                isRecording: $buttonEnabled,
                color: $color,
                speechText: $speechText,
                speechAction: $speechAction
            )
        }.background(Color(hex: 0xf29883)) .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
    
    func updateImage() {
            print("Update image is called") // Pemeriksaan apakah fungsi dipanggil
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: delayInSeconds, repeats: true) { timer in
           
                    if let currentIndex = imageWakeAction.firstIndex(of: imageSleep) {
                        let nextIndex = (currentIndex + 1) % imageWakeAction.count
                        imageSleep = imageWakeAction[nextIndex]
                        
                        if nextIndex == imageWakeAction.count - 1 {
                            timer.invalidate()
                        }
                        buttonEnabled = nextIndex < imageWakeAction.count - 1
            }
        }
        isButton2Visible = true
    }
    
    func resetImage() {
        DispatchQueue.global().async {
            timer?.invalidate()
            imageSleep = "sleep1"
            DispatchQueue.main.async {
                buttonEnabled = true
            }
        }
    }
    
    struct SpeechRecognitionGame_Previews: PreviewProvider {
        static var previews: some View {
            SpeechView()
        }
    }
}
