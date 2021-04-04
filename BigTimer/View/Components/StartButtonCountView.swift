//
//  StartButton_CountView.swift
//  BigTimer
//
//  Created by 鳥居克哉 on 2021/04/04.
//

import SwiftUI

struct StartButtonCountView: View {
    var body: some View {
        Image(systemName: "play.circle")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 100, height: 100)
    }
}

struct StartButtonCountView_Previews: PreviewProvider {
    static var previews: some View {
        StartButtonCountView()
    }
}
