//
//  SoundButtonView.swift
//  BigTimer
//
//  Created by 鳥居克哉 on 2021/04/04.
//

import SwiftUI

struct SoundButtonView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    var body: some View {
        Image(systemName: timerViewModel.alermOn ? "speaker.wave.2.fill": "speaker.slash.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
            .onTapGesture {
                timerViewModel.switchSoundStatus()
            }
    }
}

struct SoundButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SoundButtonView()
    }
}
