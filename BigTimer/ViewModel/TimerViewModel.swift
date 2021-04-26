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
    @Published var hourSelection = 0
    @Published var minSelection = 0
    @Published var secSelection = 0
    @Published var timeLeftStr = ""
    @Published var timeLeftStrNum = 0.0
    let soundModel = SoundModel()
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func setTimer(){
        timerModel.setTime = Double(hourSelection * 3600 + minSelection * 60 + secSelection)
        timerModel.timeLeft = timerModel.setTime
        
        if timerModel.timeLeft < 60 {
            timerModel.displayedTimeFormat = .sec
        } else if timerModel.timeLeft < 3600 {
            timerModel.displayedTimeFormat = .min
        } else {
            timerModel.displayedTimeFormat = .hr
        }
    }
    
    func setTimeLeftStr(){
        let hr = Int(timerModel.timeLeft) / 3600
        let min = Int(timerModel.timeLeft) % 3600 / 60
        let sec = Int(timerModel.timeLeft) % 3600 % 60

        switch timerModel.displayedTimeFormat {
            case .hr:
                self.timeLeftStr = String(format: "%02d:%02d:%02d", hr, min, sec)
                self.timeLeftStrNum = 5.4
            case .min:
                self.timeLeftStr = String(format: "%02d:%02d", min, sec)
                self.timeLeftStrNum = 3.5
            case .sec:
                self.timeLeftStr = String(format: "%02d", sec)
                self.timeLeftStrNum = 1.8
        }
    }
    
    func run(){
        guard self.timerModel.timerStatus == .running else { return }
        
        if self.timerModel.timeLeft > 0 {
            self.timerModel.timeLeft -= 1
            self.setTimeLeftStr()
        } else {
            self.timerModel.timerStatus = .stopping
            if self.soundModel.isAlarmOn{
                AudioServicesPlayAlertSoundWithCompletion(self.soundModel.soundID, nil)
            }
            
            if self.soundModel.isVibrationOn{
                AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) {}
            }
            //2.5秒経過したらstoppedに
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.timerModel.timeLeft = self.timerModel.setTime
                //途中で停止押されて.readyになっている場合を排除
                if self.timerModel.timerStatus == .stopping {
                    self.timerModel.timerStatus = .stopped
                }
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
    
    func pushedButtun(){
        if timerModel.timerStatus == .ready {
            self.setTimer()
        }
        if self.timerModel.timeLeft != 0 && self.timerModel.timerStatus != .running {
            self.start()
        } else if self.timerModel.timerStatus == .running {
            self.pause()
        }
    }
    
    func isTimer() -> Bool{
        if timerModel.timerStatus == .ready {
            return false
        } else{
            return true
        }
    }
}
