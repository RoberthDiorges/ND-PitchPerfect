//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Roberth Diorges on 25/01/2018.
//  Copyright © 2018 Roberth Diorges. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
  
  //MARK: - References
  @IBOutlet weak var stopButton: UIButton!
  @IBOutlet weak var fastButton: UIButton!
  @IBOutlet weak var highPitchButton: UIButton!
  @IBOutlet weak var reverbButton: UIButton!
  @IBOutlet weak var slowButton: UIButton!
  @IBOutlet weak var lowPitchButton: UIButton!
  @IBOutlet weak var echoButton: UIButton!
  
  //MARK: - Variables
  var recordedAudioURL: URL!
  var audioFile: AVAudioFile!
  var audioEngine: AVAudioEngine!
  var audioPlayerNode: AVAudioPlayerNode!
  var stopTimer: Timer!
  
  enum ButtonType: Int {
    case fast = 0, echo, vader, slow, reverb, chipmunk
  }
  
  //MARK: - Life cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupAudio()
  }
  
  //MARK: - IBActions
  @IBAction func hearSound(_ sender: UIButton) {
    switch (ButtonType(rawValue: sender.tag)!) {
    case .fast:
      playSound(rate: 1.5)
    case .echo:
      playSound(echo: true)
    case .vader:
      playSound(pitch: -1000)
    case .slow:
      playSound(rate: 0.5)
    case .reverb:
      playSound(reverb: true)
    case .chipmunk:
      playSound(pitch: 1000)
    }
    configureUI(.playing)
  }
  
  @IBAction func stopSoundButton_Clicked(_ sender: UIButton) {
    stopAudio()
  }
  
  @IBAction func recordNewSoundButton_Clicked(_ sender: UIButton) {
    self.navigationController?.popToRootViewController(animated: true)
  }
}
