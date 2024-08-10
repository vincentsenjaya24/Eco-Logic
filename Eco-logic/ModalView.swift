import SwiftUI

struct ModalView: View {
    @StateObject var speechRecognizer = SpeechRecognizer()
    @Binding var isRecording: Bool
    @Binding var color: Color
    @Binding var speechText: String
    @Binding var speechAction: SpeechAction

    var body: some View {
        VStack {
            Spacer()
            Text("\((isRecording == false) ? "" : ((speechRecognizer.transcript == "") ? "Speak Now" : speechRecognizer.transcript))")
                .frame(width: 300, height: 200, alignment: .center)
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(2)
            Spacer()
        }
        .onAppear {
            speechRecognizer.transcribe()
            color = .red
        }
        .onDisappear {
            color = .gray
            speechRecognizer.stopTranscribing()
            speechText = speechRecognizer.transcript.lowercased()
            // Menetapkan speechAction sesuai dengan kata kunci
            if ["wake up", "get up","wake","up"].contains(speechText) {
                speechAction = .update
            } else {
                speechAction = .noUpdate
            }
        }
    }
}
