//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Roberth Diorges on 24/01/2018.
//  Copyright © 2018 Roberth Diorges. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

  // MARK: - Variables
  var audioRecorder: AVAudioRecorder!
  
  // MARK: - Properties
  @IBOutlet weak var recordButton: UIButton!
  @IBOutlet weak var statusRecordingLabel: UILabel!
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }

  // MARK: - IBActions
  @IBAction func recordAudioButton_Clicked(_ sender: UIButton) {
    
  }
  
  // MARK: - Misc
  func recordAudio() {
    
  }
  
  //MARK: - AVAudioRecorderDelegate
  func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    print("teste")
  }
}

