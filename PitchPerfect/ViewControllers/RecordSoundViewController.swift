//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by Roberth Diorges on 24/01/2018.
//  Copyright © 2018 Roberth Diorges. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController, AVAudioRecorderDelegate {
  
  // MARK: - Variables
  var isStopAudio = false
  var audioRecorder: AVAudioRecorder!
  var audioSession = AVAudioSession.sharedInstance()
  let recordingFilterSegueIdentifier = "recordingFilterSegueIdentifier"
  
  // MARK: - Properties
  @IBOutlet weak var recordButton: UIButton!
  @IBOutlet weak var statusRecordingLabel: UILabel!
  
  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    verifyAccessMicrophone()
  }
  
  // MARK: - IBActions
  @IBAction func recordAudioButton_Clicked(_ sender: UIButton) {
    setupUIButton()
  }
  
  // MARK: - Misc
  func recordAudio() {
    do {
      try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions .defaultToSpeaker)
      try audioSession.setActive(true)
    } catch let error {
      print(error.localizedDescription)
    }
    
    do {
      try audioRecorder = AVAudioRecorder(url: getDocumentsDirectory(), settings: [:])
      audioRecorder.isMeteringEnabled = true
      audioRecorder.delegate = self
      audioRecorder.prepareToRecord()
      audioRecorder.record()
    } catch {
      print(error.localizedDescription)
    }
  }
  
  func verifyAccessMicrophone() {
    switch audioSession.recordPermission() {
    case AVAudioSessionRecordPermission .granted:
      print("granted")
      
    case AVAudioSessionRecordPermission .denied:
      displayAlert(title: "Permissão microfone", message: "Por favor, habilite o uso do microfone", titleAction: "Abrir configurações")
      
    case AVAudioSessionRecordPermission .undetermined:
      audioSession.requestRecordPermission({ (granted) in
      
      })
    }
  }
  
  func setupUIButton() {
    if isStopAudio {
      let stopImage = UIImage(named: "Record.png")
      recordButton.setImage(stopImage, for: .normal)
      isStopAudio = false
      stopRecord()
    } else {
      let recordImage = UIImage(named: "Stop.png")
      recordButton.setImage(recordImage, for: .normal)
      isStopAudio = true
      recordAudio()
    }
  }
  
  func displayAlert(title:String, message:String, titleAction:String) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let actionOpenConfig = UIAlertAction(title: titleAction, style: .default) { (alertConfig) in
      if let settings = NSURL(string: UIApplicationOpenSettingsURLString) {
        UIApplication.shared.open(settings as URL)
      }
    }
    let actionCancel = UIAlertAction(title: "Cancelar", style: .destructive, handler: nil)
    alertController.addAction(actionOpenConfig)
    alertController.addAction(actionCancel)
    present(alertController, animated: true, completion: nil)
  }
  
  func stopRecord() {
    audioRecorder.stop()
    try! audioSession.setActive(false)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == recordingFilterSegueIdentifier {
      let destinationViewController = segue.destination as! PlaySoundsViewController
      let recorderAudioURL = sender as! URL
      destinationViewController.recordedAudioURL = recorderAudioURL
    }
  }
  
  func getDocumentsDirectory() -> URL {
    let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentDirectory = dirPaths[0]
    let audioFileName = ("newAudio.wav")
    let pathArray = [documentDirectory, audioFileName]
    let filePath = URL(string: pathArray.joined(separator: "/"))
    return filePath!
  }
  
  //MARK: - AVAudioRecorderDelegate
  func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    if flag {
      performSegue(withIdentifier: recordingFilterSegueIdentifier, sender: audioRecorder.url)
    } else {
      print("Erro ao gravar...")
    }
  }
}

