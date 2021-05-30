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
            ZStack{
                Image(systemName: "pause.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width/2, height: geometry.size.height/2)
                    .scaleEffect(!(!timerViewModel.aflag || timerViewModel.bflag)  ? 1.0 : 2.0)
                    .opacity((!timerViewModel.aflag || timerViewModel.bflag) ? 1.0 : 0)
                    .opacity(!(!timerViewModel.aflag || timerViewModel.bflag) ? 1.0 : 0)
                Image(systemName: "play.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width/2, height: geometry.size.height/2)
                    .scaleEffect(!(timerViewModel.aflag || !timerViewModel.bflag)  ? 1.0 : 2.0)
                    .opacity(timerViewModel.aflag || !timerViewModel.bflag ? 1.0 : 0)
                    .opacity(!(timerViewModel.aflag || !timerViewModel.bflag) ? 1.0 : 0)
                VStack{
                    Color.clear.contentShape(Rectangle())
                        .onTapGesture {
                            timerViewModel.pushedButton()
                            if !timerViewModel.isStopping{
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    self.timerViewModel.aflag.toggle()  // flagの変更がアニメーション化される
                                }
                                self.timerViewModel.bflag.toggle()
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
    }
}

struct ScreenButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ScreenButtonView()
    }
}
