//
//  ContentView.swift
//  SUI
//
//  Created by Игорь Девин on 02.05.2024.
//


import AVFoundation
import SwiftUI

struct PlayerView: View {
    
    // MARK: - Constants
    
    private enum Constants {
        static let backgraundColor = "backgraundColor"
        static let backButton = "backward.end.fill"
        static let playButton = "play.circle.fill"
        static let pauseButton = "pause.circle.fill"
        static let nextButton = "forward.end.fill"
        static let saveButton = "square.and.arrow.down"
        static let shareButton = "arrowshape.turn.up.right.fill"
        static let titleAlert = "Поделиться?"
    }
    
    @ObservedObject var playerViewModel = PlayerViewModel()
    var body: some View {
        GeometryReader{_ in
            VStack{
                albomPicture
                trackInfo
                slider
                playerControl
            }
        }.background(Color(Constants.backgraundColor))
    }
    
    @State private var progress: Float = 0
    var slider: some View {
        HStack{
            Slider(value: Binding(get: {
                progress
            }, set: { newValue in
                progress = newValue
                playerViewModel.setTime(value: newValue)
            }), in: 0...playerViewModel.maxDuration)
            Text("\(playerViewModel.maxDuration.rounded() / 60)".replacingOccurrences(of: ".", with: ":", options: .literal))
        }
        .foregroundColor(.white)
        .padding()
    }
    
    @State var isPlay = false
    var playerControl: some View {
        HStack{
            Spacer()
            Button(action: {
                playerViewModel.previuTrack()
            }, label: {
                Image(systemName: Constants.backButton)
                    .frame(width: 60, height: 80)
            })
            Spacer()
            Button(action: {
                !isPlay ? playerViewModel.play() : playerViewModel.stop()
                isPlay.toggle()
            }, label: {
                Image(systemName: !isPlay ? Constants.playButton : Constants.pauseButton)
                    .frame(width: 60, height: 80)
            })
            Spacer()
            Button(action: {
                playerViewModel.nextTrack()
            }, label: {
                Image(systemName: Constants.nextButton)
                    .frame(width: 60, height: 80)
            })
            Spacer()
        }.tint(.white)
    }
    
    var albomPicture: some View {
        Image(playerViewModel.currentTrack?.image ?? "")
            .resizable()
            .frame(width: 280, height: 280)
    }
    
    @State private var actionSheetCall = false
    @State private var isAlert = false
    var trackInfo: some View {
        HStack{
            Image(playerViewModel.currentTrack?.avatar ?? "")
                .resizable()
                .frame(width: 60, height: 60)
                .clipShape(Circle())
            VStack{
                Text(playerViewModel.currentTrack?.trackName ?? "")
                Text(playerViewModel.currentTrack?.artistName ?? "")
            }
            Spacer()
            Button {
                actionSheetCall.toggle()
            } label: {
                Image(systemName: Constants.saveButton)
            }
            Button {
                isAlert.toggle()
            } label: {
                Image(systemName: Constants.shareButton)
            }
        }
        .foregroundColor(.white)
        .padding()
        .confirmationDialog("", isPresented: $actionSheetCall) {
        } message: {
            if let text = playerViewModel.currentTrack?.trackName {
                Text("\(text)  - сохранен в папку загрузки")
            }
        }
        .alert(Constants.titleAlert, isPresented: $isAlert) {
            Button("Да"){}
            Button("Нет"){}
        }
    }
}

#Preview {
    PlayerView()
}


