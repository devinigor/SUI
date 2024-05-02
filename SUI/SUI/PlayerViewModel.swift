//
//  PlayerViewModel.swift
//  SUI
//
//  Created by Игорь Девин on 02.05.2024.
//

import Foundation
import AVFoundation

final class PlayerViewModel: ObservableObject {
    @Published public var maxDuration: Float = 0.0
    private var player: AVAudioPlayer?
    private var songModel: [SongModel] = [.init(image: "em",
                                                artistName: "Eminem",
                                                trackName: "Sing for the Moment",
                                                avatar: "emAvatar"),
                                          .init(image: "emTwo",
                                                artistName: "Eminem",
                                                trackName: "Lose yourself",
                                                avatar: "secondEmAvatar")]
    @Published var currentTrack: SongModel?
    
    public func play() {
        playSong(model: songModel[0])
        player?.play()
    }
    
    public func stop() {
        player?.stop()
    }
    
    public func nextTrack() {
        playSong(model: songModel[1])
        player?.play()
    }
    
    public func previuTrack() {
        play()
    }
    
    public func setTime(value: Float) {
        guard let time = TimeInterval(exactly: value) else { return }
        player?.currentTime = time
        player?.play()
    }
    
    private func playSong(model: SongModel) {
        guard let audioPath = Bundle.main.path(forResource: model.trackName, ofType: "mp3") else { return }
        do{
            try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            currentTrack = model
            maxDuration = Float(player?.duration ?? 0.0)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
