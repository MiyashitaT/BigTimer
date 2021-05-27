//
//  StartButton_CountView.swift
//  BigTimer
//
//  Created by 鳥居克哉 on 2021/04/04.
//

import SwiftUI

struct ScreenButtonView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    @State private var aflag = true // フラグの変更時にアニメーション
    @State private var bflag = false // pauseかplayの制御
    
    var body: some View {
        GeometryReader{geometry in
            ZStack{
                Image(systemName: "pause.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width/2, height: geometry.size.height/2)
                    .scaleEffect(!(!aflag || bflag)  ? 1.0 : 2.0)
                    .opacity((!aflag || bflag) ? 1.0 : 0)
                    .opacity(!(!aflag || bflag) ? 1.0 : 0)
                Image(systemName: "play.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width/2, height: geometry.size.height/2)
                    .scaleEffect(!(aflag || !bflag)  ? 1.0 : 2.0)
                    .opacity(aflag || !bflag ? 1.0 : 0)
                    .opacity(!(aflag || !bflag) ? 1.0 : 0)
                VStack{
                    Color.clear.contentShape(Rectangle())
                        .onTapGesture {
                            timerViewModel.pushedButton()
                            withAnimation(.easeInOut(duration: 0.5)) {
                                self.aflag.toggle()  // flagの変更がアニメーション化される
                            }
                            self.bflag.toggle()
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
