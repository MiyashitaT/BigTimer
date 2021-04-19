//
//  TimeTextView.swift
//  BigTimer
//
//  Created by 鳥居克哉 on 2021/04/04.
//

import SwiftUI

struct TimeTextView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        Text(self.timerViewModel.displayTimer())
        .font(Font(UIFont.monospacedDigitSystemFont(ofSize: self.screenWidth * 0.3, weight: .bold)))
    }
}

struct TimeTextView_Previews: PreviewProvider {
    static var previews: some View {
        TimeTextView()
    }
}
