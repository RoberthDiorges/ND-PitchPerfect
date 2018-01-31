//
//  RecordSoundViewController.swift
//  PitchPerfect
//
//  Created by Roberth Diorges on 24/01/2018.
//  Copyright © 2018 Roberth Diorges. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundViewController: UIViewController {
    
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
        if isStopAudio {
            configureUI(.stop)
        } else {
            configureUI(.record)
        }
    }
    
    // MARK: - Misc
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == recordingFilterSegueIdentifier {
            let destinationViewController = segue.destination as! PlaySoundsViewController
            let recorderAudioURL = sender as! URL
            destinationViewController.recordedAudioURL = recorderAudioURL
        }
    }
}

