//
//  StartButton_CountView.swift
//  BigTimer
//
//  Created by 鳥居克哉 on 2021/04/04.
//

import SwiftUI

struct ScreenButtonView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    var body: some View {
        GeometryReader{geometry in
            VStack{
                Color.clear.contentShape(Rectangle())
                    .onTapGesture {
                        timerViewModel.pushedButton()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

struct ScreenButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenButtonView()
    }
}
