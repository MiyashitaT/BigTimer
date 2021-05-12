//
//  TimerViewModel.swift
//  BigTimer
//
//  Created by 宮下知也 on 2021/04/04.
//

import Foundation
import SwiftUI
import AudioToolbox

class TimerViewModel: ObservableObject{
    var timerModel = TimerModel()
    @Published var isTimer = false
    @Published var isRunning = false
    @Published var isStopping = false
    @Published var hourSelection = 0
    @Published var minSelection = 0
    @Published var secSelection = 0
    @Published var timeLeftStr = ""
    var timeLeftStrNum = 0.0
    let soundModel = SoundModel()
    let hourSec = 3600
    let minSec = 60
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func setTimer(){
        timerModel.setTime = Double(hourSelection * hourSec + minSelection * minSec + secSelection)
        timerModel.timeLeft = timerModel.setTime
        
        if timerModel.timeLeft < Double(minSec) {
            timerModel.displayedTimeFormat = .sec
        } else if timerModel.timeLeft < Double(minSec * 10) {
            timerModel.displayedTimeFormat = .min1
        } else if timerModel.timeLeft < Double(hourSec) {
            timerModel.displayedTimeFormat = .min2
        } else if timerModel.timeLeft < Double(hourSec * 10) {
            timerModel.displayedTimeFormat = .hr1
        } else {
            timerModel.displayedTimeFormat = .hr2
        }
    }
    
    func setTimeLeftStr(){
        let hr = Int(timerModel.timeLeft) / hourSec
        let min = Int(timerModel.timeLeft) % hourSec / minSec
        let sec = Int(timerModel.timeLeft) % hourSec % minSec
        
        switch timerModel.displayedTimeFormat {
        case .hr2:
            self.timeLeftStr = String(format: "%02d:%02d:%02d", hr, min, sec)
            self.timeLeftStrNum = 5.4
        case .hr1:
            self.timeLeftStr = String(format: "%01d:%02d:%02d", hr, min, sec)
            self.timeLeftStrNum = 4.5
        case .min2:
            self.timeLeftStr = String(format: "%02d:%02d", min, sec)
            self.timeLeftStrNum = 3.5
        case .min1:
            self.timeLeftStr = String(format: "%01d:%02d", min, sec)
            self.timeLeftStrNum = 2.7
        case .sec:
            self.timeLeftStr = String(format: "%02d", sec)
            self.timeLeftStrNum = 1.8
        }
    }
    
    func run(){
        guard self.timerModel.timerStatus == .running else { return }
        
        if self.timerModel.timeLeft > 1 {
            self.timerModel.timeLeft -= 1
            self.setTimeLeftStr()
        } else {
            self.timerModel.timeLeft -= 1
            self.setTimeLeftStr()
            self.timerModel.timerStatus = .stopping
            self.isStopping = true
            if self.soundModel.isAlarmOn{
                AudioServicesPlayAlertSoundWithCompletion(self.soundModel.soundID, nil)
            }
            
            if self.soundModel.isVibrationOn{
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
            }
            // 1.0秒経過したらstoppedに
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.timerModel.timeLeft = self.timerModel.setTime
                //途中で停止押されて.readyになっている場合を排除
                if self.timerModel.timerStatus == .stopping {
                    self.timerModel.timerStatus = .stopped
                }
                self.isStopping = false
                self.setTimer()
                self.setTimeLeftStr()
                self.timerModel.timerStatus = .ready
            }
        }
    }
    
    func start() {
        timerModel.timerStatus = .running
    }
    
    func pause() {
        timerModel.timerStatus = .pause
    }
    
    func reset() {
        timerModel.timerStatus = .ready
        timerModel.timeLeft = 0
    }
    
    func pushedButton(){
        if timerModel.timerStatus == .ready {
            self.setTimer()
            self.setTimeLeftStr()
        }
        if self.timerModel.timeLeft != 0 && self.timerModel.timerStatus != .running {
            self.start()
        } else if self.timerModel.timerStatus == .running {
            self.pause()
        }
        self.switchStatus()
    }
    
    func pushedBackButton(){
        self.reset()
        self.switchStatus()
    }
    
    func switchStatus(){
        self.switchIsTimer()
        self.switchIsRunning()
    }
    
    func switchIsRunning(){
        if timerModel.timerStatus == .running {
            isRunning = true
        } else {
            isRunning = false
        }
    }
    func switchIsTimer(){
        if timerModel.timerStatus == .ready {
            isTimer = false
        } else {
            isTimer = true
        }
    }
}
