import SwiftUI
import CoreMotion
import Lottie

class MotionManager: ObservableObject {
    let motionManager = CMMotionManager()
    @Published var x = 0.0
    @Published var y = 0.0
    @Published var z = 0.0
    
    init() {
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
            guard let motion = data?.attitude else { return }
            self?.x = motion.roll
            self?.y = motion.pitch
            self?.z = motion.yaw
        }
    }
}

struct GyroscopeView: View {
    @StateObject private var motion = MotionManager()
    @State private var scrollToOffset: CGFloat = 0
    
    @State private var isNavigationLinkClicked = false
    var body: some View {
        NavigationView{
            VStack{
//                    Text(motion.y <= -0.5 ? "HelloWorld \(motion.y)" : "hell")
                    Spacer()
                        if motion.y < -0.5 { // Conditionally show the LottieView based on motion.y value
                            NavigationLink(
                                destination: AirplaneModeView().navigationBarBackButtonHidden(true)
                            ){
                                    ZStack {
                                        LottieView(animation: .named("BirdAnimation"))
                                                            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                                                                        .rotationEffect(Angle(degrees: 180))
                                    }
                            }
                        }
                    
                
            }.onAppear {
                HapticManager.instance.notification(type: .success)
            }
            .background(
                Image("DeepSea")
                .resizable()
                .scaledToFill()
                .offset(y:motion.y * 300)
                .edgesIgnoringSafeArea(.vertical)
                .frame(minWidth: 500)
            ) .onDisappear {
                // Stop gyro measurement when navigating away
                motion.motionManager.stopDeviceMotionUpdates()
            }
            }
        }
        
        
}

#Preview {
    GyroscopeView()
}
