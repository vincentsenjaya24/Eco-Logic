import SwiftUI
import Network
import Lottie
import CoreHaptics

class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "Monitor")
    @Published var isActive = false
    @Published var isExpensive = false
    @Published var isConstrained = false
    @Published var connectionType: NWInterface.InterfaceType = .other
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isActive = path.status == .satisfied
                self.isExpensive = path.isExpensive
                self.isConstrained = path.isConstrained
                
                let connectionTypes: [NWInterface.InterfaceType] = [.cellular, .wifi, .wiredEthernet]
                self.connectionType = connectionTypes.first(where: path.usesInterfaceType) ?? .other
            }
        }
        
        monitor.start(queue: queue)
    }
}
class HapticManager{
    static let instance = HapticManager()
    func notification(type: UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    } 
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct AirplaneModeView: View {
    @StateObject private var networkMonitor = NetworkMonitor()
    @State private var counter = 0
    
    var body: some View {
        NavigationView{
            VStack {
                if !networkMonitor.isActive {
                    NavigationLink(destination: FinalView().navigationBarBackButtonHidden(true)){
                        LottieView(animation: .named("airdrop"))
                            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                    }
                }
                Spacer()
                ZStack {
                    if !networkMonitor.isActive {
                        LottieView(animation: .named("airplane"))
                            .playbackMode(.playing(.toProgress(1, loopMode: .loop)))
                    } else {
                        LottieView(animation: .named("airplane"))
                        
                    }
                }.onAppear {
                    HapticManager.instance.notification(type: .success)
                }
            }
            .background(.white) // Set background color here
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    struct AirplaneModeView_Previews: PreviewProvider {
        static var previews: some View {
            AirplaneModeView()
        }
    }
}
