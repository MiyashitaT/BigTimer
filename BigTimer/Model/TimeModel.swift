//
//  File.swift
//  BigTimer
//
//  Created by 宮下知也 on 2021/04/04.
//

import Foundation

class TimerModel: ObservableObject{
    var displayedTimeFormat: TimeFormat = .min1
    var setTime: Int = 0
    var timeLeft: Int = 0
    var timerStatus: TimerStatus = .ready
}
