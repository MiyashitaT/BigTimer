//
//  File.swift
//  BigTimer
//
//  Created by 宮下知也 on 2021/04/04.
//

import Foundation

class TimerModel: ObservableObject{
    @Published var displayedTimeFormat: TimeFormat = .min
    @Published var setTime: Double = 0
    @Published var timeLeft: Double = 0
    @Published var timerStatus: TimerStatus = .ready
    @Published var isSetting: Bool = false
}
