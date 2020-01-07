//
//  ViewController.swift
//  sound_Demo
//
//  Created by MacStudent on 2020-01-07.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var volumnSlider: UISlider!
    @IBOutlet weak var scrubber: UISlider!
    var player = AVAudioPlayer()
    let path = Bundle.main.path(forResource: "bach", ofType: "mp3")
    var timer = Timer()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        do{
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path!))
            scrubber.maximumValue = Float(player.duration)
        }catch{
            print(error)
        }
    }

    @IBAction func stopSound(_ sender: UIButton) {
        player.stop()
        timer.invalidate()
        player.currentTime = 0
    }
    @IBAction func pauseSound(_ sender: UIBarButtonItem) {
        player.pause()
        timer.invalidate()
    }
   
    @IBAction func playSound(_ sender: UIBarButtonItem) {
        player.play()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateScrubber), userInfo: nil, repeats: true)
    }
    @objc func updateScrubber() {
        scrubber.value = Float(player.currentTime)
    }
    @IBAction func volumnChanged(_ sender: UISlider) {
        player.volume = volumnSlider.value
    }
    
    @IBAction func scrubberMoved(_ sender: UISlider) {
            player.currentTime = TimeInterval(scrubber.value)
        player.play()    
    }
}

