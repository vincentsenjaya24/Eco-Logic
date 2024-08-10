//
//  SpellCastButton.swift
//  CWC_AR
//

//

import SwiftUI

enum SpeechAction {
    case wakeup, update, noUpdate
}

struct SpellCastButton: View {
    var micIconWidth:CGFloat
    var micIconHeight:CGFloat
    @State var isRecording:Bool
    @State var color:Color
    @Binding var speechText:String
    @Binding var speechAction: SpeechAction
    
    @StateObject var speechRecognizer = SpeechRecognizer()
    
    
    public init(micIconWidth: CGFloat = 45, micIconHeight: CGFloat = 55, isRecording: Bool = false, color: Color = .gray, speechText: Binding<String>, speechAction: Binding<SpeechAction>) {
        self.micIconWidth = micIconWidth
        self.micIconHeight = micIconHeight
        self.isRecording = isRecording
        self.color = color
        self._speechText = speechText
        self._speechAction = speechAction
    }

        var body: some View {
            ZStack {
                Circle()
                    .foregroundColor(.black)
                    .frame(width: 100 + CGFloat(speechRecognizer.currentAudioLevel * 100), height: 100 + CGFloat(speechRecognizer.currentAudioLevel * 100))
                    .animation(.easeInOut, value: speechRecognizer.currentAudioLevel)
                Image(systemName: "mic.fill")
                    .resizable()
                    .frame(width: micIconWidth, height: micIconHeight)
                    .foregroundStyle(color)
                    .onTapGesture {
                        isRecording.toggle()
                    }
            }
            .frame(width: 200, height: 200)
            .onChange(of: isRecording) { newValue in
                if newValue {
                    speechRecognizer.transcribe()
                    color = .red
                } else {
                    color = .gray
                    speechRecognizer.stopTranscribing()
                    speechText = speechRecognizer.transcript.lowercased()
                    print(speechText)
                    // Menetapkan speechAction berdasarkan kata kunci
                    if ["wake up", "get up","wake","up"].contains(speechText) {
                        speechAction = .update
                    } else {
                        speechAction = .noUpdate
                    }
                    speechRecognizer.currentAudioLevel = 0
                }
            }

            }
        }

