//
//  PlaySoundsViewController.swift
//  Trainnig App
//
//  Created by user on 03.08.2018.
//  Copyright © 2018 user. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    var soundPlayer: AVAudioPlayer?

    @IBAction func sound1(_ sender: UIButton) {
        playSound(noteName: "note1.wav")
    }
    @IBAction func sound2(_ sender: UIButton) {
        playSound(noteName: "note2.wav")
    }
    @IBAction func sound3(_ sender: UIButton) {
        playSound(noteName: "note3.wav")
    }
    @IBAction func sound4(_ sender: UIButton) {
        playSound(noteName: "note4.wav")
    }
    @IBAction func sound5(_ sender: UIButton) {
        playSound(noteName: "note5.wav")
    }
    @IBAction func sound6(_ sender: UIButton) {
        playSound(noteName: "note6.wav")
    }
    @IBAction func sound7(_ sender: UIButton) {
        playSound(noteName: "note7.wav")
    }

    func playSound(noteName: String) {

        let path = Bundle.main.path(forResource: noteName, ofType: nil)!
        let url = URL(fileURLWithPath: path)
        do {
            soundPlayer = try AVAudioPlayer(contentsOf: url)
            soundPlayer?.play()
        } catch {
            print("Error playing sound \(error)")
        }

    }

}
