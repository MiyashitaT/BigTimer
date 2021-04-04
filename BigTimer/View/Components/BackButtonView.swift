//
//  BackButton.swift
//  BigTimer
//
//  Created by 鳥居克哉 on 2021/04/04.
//

import SwiftUI

struct BackButtonView: View {
    var body: some View {
        Image(systemName: "arrow.backward")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 40, height: 40)
    }
}

struct BackButtonView_previews: PreviewProvider {
    static var previews: some View {
        BackButtonView()
    }
}
