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
    @IBOutlet weak var progressView: UIProgressView!
    
    let hardnessMinutes = [
        "Soft": 5,
        "Medium": 7,
        "Hard": 12
    ]
    
    var player: AVAudioPlayer? = nil
    
    let granularitySeconds: Double = 1.0
    var timer: Timer? = nil
    
    var secondsHardness:Int = 0
    var secondsRemaining: Int = 0
    var isProcess: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(withTimeInterval: granularitySeconds, repeats: true, block: { (Timer) in
            self.doTick()
        })
        
        progressView.progress = 0
    }
    
    func doTick() {
        if isProcess {
            let progressPercents = (Float(secondsHardness) - Float(secondsRemaining)) / Float(secondsHardness)
            
            progressView.progress = progressPercents
            
            print("\(secondsRemaining) seconds remaining")
            
            secondsRemaining -= 1
            
            if secondsRemaining < 0 {
                isProcess = false
                
                playAlarm()
                
                print("timer is not active")
            }
        } else {
            //timer?.invalidate()
        }
    }
    
    func playAlarm() {
        player = try? AVAudioPlayer(contentsOf: Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")!)
        player?.play()
    }
    
    func activateCountdownTimer(initSeconds: Int) {
        secondsHardness = initSeconds
        secondsRemaining = secondsHardness
        
        isProcess = true
        print("timer is active")
    }
    
    @IBAction func onHardnessSelected(_ sender: UIButton) {
        print(sender.currentTitle!)
        
        let selectedHardness = sender.currentTitle!
        
        let secondsInterval: Int = hardnessMinutes[selectedHardness]! * 60
        
        print("START COOKING...")
        
        activateCountdownTimer(initSeconds: secondsInterval)
    }
    
}
