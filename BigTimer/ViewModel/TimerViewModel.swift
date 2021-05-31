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
    @Published var alermOn = true
    @Published var aflag = true
    @Published var bflag = false
    var timeLeftStrNum = 0.0
    let soundModel = SoundModel()
    let hourSec = 3600
    let minSec = 60
    let timeResolution = 10
    var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    func setTimer(){
        timerModel.setTime = hourSelection * hourSec + minSelection * minSec + secSelection
        timerModel.timeLeft = timerModel.setTime * timeResolution
        setTimeFormat(time_val: timerModel.setTime)
    }
    
    func setTimeFormat(time_val: Int){
        if time_val < 10 {
            timerModel.displayedTimeFormat = .sec1
        }else if time_val < minSec {
            timerModel.displayedTimeFormat = .sec2
        } else if time_val < minSec * 10 {
            timerModel.displayedTimeFormat = .min1
        } else if time_val < hourSec {
            timerModel.displayedTimeFormat = .min2
        } else if time_val < hourSec * 10 {
            timerModel.displayedTimeFormat = .hr1
        } else {
            timerModel.displayedTimeFormat = .hr2
        }
    }
    
    func setTimeLeftStr(){
        let hr = timerModel.timeLeft / timeResolution / hourSec
        let min = timerModel.timeLeft / timeResolution % hourSec / minSec
        let sec = timerModel.timeLeft / timeResolution % hourSec % minSec
        let decimal = timerModel.timeLeft % timeResolution
        
        setTimeFormat(time_val: timerModel.timeLeft / timeResolution)
        
        switch timerModel.displayedTimeFormat {
        case .hr2:
            self.timeLeftStr = String(format: "%02d:%02d:%02d", hr, min, sec)
            self.timeLeftStrNum = 5.6
        case .hr1:
            self.timeLeftStr = String(format: "%01d:%02d:%02d", hr, min, sec)
            self.timeLeftStrNum = 4.7
        case .min2:
            self.timeLeftStr = String(format: "%02d:%02d", min, sec)
            self.timeLeftStrNum = 3.7
        case .min1:
            self.timeLeftStr = String(format: "%01d:%02d", min, sec)
            self.timeLeftStrNum = 2.8
        case .sec2:
            self.timeLeftStr = String(format: "%02d.%01d", sec, decimal)
            self.timeLeftStrNum = 2.8
        case .sec1:
            self.timeLeftStr = String(format: "%01d.%01d", sec, decimal)
            self.timeLeftStrNum = 1.8
        }
    }
    
    func calcTimeSize(height: CGFloat, width: CGFloat) -> CGFloat{
        let width_size = width / CGFloat(self.timeLeftStrNum)
        let height_size = height / 1.05
        if width_size < height_size{
            return width_size
        } else{
            return height_size
        }
    }
    
    func run(){
        guard self.timerModel.timerStatus == .running else { return }
        
        if self.timerModel.timeLeft > 0 {
            self.timerModel.timeLeft -= 1
            self.setTimeLeftStr()
        } else {
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
                self.aflag = false
                self.bflag = true
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
            self.aflag = true
            self.bflag = false
        }
        if self.timerModel.timerStatus == .ready || self.timerModel.timerStatus == .stopped || self.timerModel.timerStatus == .pause {
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
    
    func switchSoundStatus() {
        soundModel.isAlarmOn.toggle()
        alermOn = soundModel.isAlarmOn
    }
}
