//
//  MusicSelectView.swift
//  BigTimer
//
//  Created by 鳥居克哉 on 2021/04/04.
//

import SwiftUI

struct SoundSelectView: View {
    var body: some View {
        NavigationLink(destination: SoundListView()) {
            HStack {
                //設定項目名
                Text("アラーム音")
                Spacer()
                //現在選択中のアラーム音
                Text("hoge")
            }
        }
    }
}

struct SoundSelectView_Previews: PreviewProvider {
    static var previews: some View {
        SoundSelectView()
    }
}
