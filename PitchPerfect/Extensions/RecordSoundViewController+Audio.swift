//
//  RecordSoundViewController+Audio.swift
//  PitchPerfect
//
//  Created by Roberth Diorges on 31/01/2018.
//  Copyright © 2018 Roberth Diorges. All rights reserved.
//

import UIKit
import AVFoundation

extension RecordSoundViewController: AVAudioRecorderDelegate {
    
    enum StatusButton {
        case record, stop
    }
    
    // MARK: getDocumentsDirectory
    func getDocumentsDirectory() -> URL {
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentDirectory = dirPaths[0]
        let audioFileName = ("newAudio.wav")
        let pathArray = [documentDirectory, audioFileName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        return filePath!
    }
    
    // MARK: Functions UI
    func configureUI(_ statusButton: StatusButton) {
        switch(statusButton) {
        case .record:
            setPlayButtonRecordOrStop(record: true)
            isStopAudio = true
        case .stop:
            setPlayButtonRecordOrStop(record: false)
            isStopAudio = false
        }
    }
    
    func setPlayButtonRecordOrStop(record:Bool) {
        if record {
            let stopImage = UIImage(named: "Stop.png")
            recordButton.setImage(stopImage, for: .normal)
            recordAudio()
        } else {
            let recordImage = UIImage(named: "Record.png")
            recordButton.setImage(recordImage, for: .normal)
            stopRecord()
        }
    }
    
    // MARK: Permissions func
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
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: recordingFilterSegueIdentifier, sender: audioRecorder.url)
        } else {
            print("Erro ao gravar...")
        }
    }
    
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
    
    func stopRecord() {
        audioRecorder.stop()
        try! audioSession.setActive(false)
    }
}

