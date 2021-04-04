//
//  TimerViewModel.swift
//  BigTimer
//
//  Created by 宮下知也 on 2021/04/04.
//

import Foundation
import AudioToolbox

class TimerViewModel: ObservableObject, Identifiable{
    @Published var hourSelection = 0
    @Published var minSeledction = 0
    @Published var secSelection = 0
    let timerModel = TimerModel()
    let soundModel = SoundModel()
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    func setTimer(){
        timerModel.setTime = Double(hourSelection * 3600 + minSeledction * 60 + secSelection)
        timerModel.timeLeft = timerModel.setTime
        
        if timerModel.timeLeft < 60 {
            timerModel.displayedTimeFormat = .sec
        } else if timerModel.timeLeft < 3600 {
            timerModel.displayedTimeFormat = .min
        } else {
            timerModel.displayedTimeFormat = .hr
        }
    }
    
    func displayTimer() -> String {
        let hr = Int(timerModel.timeLeft) / 3600
        let min = Int(timerModel.timeLeft) % 3600 / 60
        let sec = Int(timerModel.timeLeft) % 3600 % 60

        switch timerModel.displayedTimeFormat {
            case .hr:
                return String(format: "%02d:%02d:%02d", hr, min, sec)
            case .min:
                return String(format: "%02d:%02d", min, sec)
            case .sec:
                return String(format: "%02d", sec)
        }
    }
    
    func run(){
        guard self.timerModel.timerStatus == .running else { return }
        
        if self.timerModel.timeLeft > 0 {
            self.timerModel.timeLeft -= 1
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
}
