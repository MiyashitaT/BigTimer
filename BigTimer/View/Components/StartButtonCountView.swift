//
//  StartButton_CountView.swift
//  BigTimer
//
//  Created by 鳥居克哉 on 2021/04/04.
//

import SwiftUI

struct StartButtonCountView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    var body: some View {
        Image(systemName: timerViewModel.isRunning ? "pause.circle" : "play.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 120, height: 120)
            .onTapGesture {
                timerViewModel.pushedButtun()
        }
    }
}

struct StartButtonCountView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonCountView()
    }
}
