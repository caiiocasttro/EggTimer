//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    let eggsTime = ["Soft": 30, "Medium": 420, "Hard": 720]
    var totalTime = 0
    var secondsPassed = 0
    var player: AVAudioPlayer!
    
    var time = Timer()
    
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        
        time.invalidate()
        let hardness = sender.currentTitle!
        totalTime = eggsTime[hardness]!
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
    
    }
    
    @objc func updateTime() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressBar.progress = percentageProgress
        } else {
            time.invalidate()
            titleLabel.text = "DONE"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.play()
        }
    }
}
