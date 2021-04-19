//
//  BigTimerApp.swift
//  BigTimer
//
//  Created by 宮下知也 on 2021/04/04.
//

import SwiftUI

@main
struct BigTimerApp: App {
    @EnvironmentObject var timerViewModel: TimerViewModel
    var body: some Scene {
        WindowGroup {
            TimeCountView()
                .environmentObject(TimerViewModel())
        }
    }
}
