//
//  SoundButtonView.swift
//  BigTimer
//
//  Created by 鳥居克哉 on 2021/04/04.
//

import SwiftUI

struct SoundButtonView: View {
    let soundOn = true
    var body: some View {
        if soundOn{
        Image(systemName: "speaker.wave.2.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
        } else {
            Image(systemName: "speaker.slash.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
        }
    }
}

struct SoundButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SoundButtonView()
    }
}
