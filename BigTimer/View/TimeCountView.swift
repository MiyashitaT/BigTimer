//
//  TimeCountView.swift
//  BigTimer
//
//  Created by 鳥居克哉 on 2021/04/04.
//

import SwiftUI

struct TimeCountView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    var body: some View {
        ZStack{
            VStack{
                Spacer()
                if timerViewModel.isTimer{
                    ScreenButtonView()
                } else {
                    StartButtonView()
                }
            }
            VStack{
                HStack{
                    if timerViewModel.isTimer{
                        BackButtonView()
                            .padding(EdgeInsets(
                                top: 20,
                                leading: 20,
                                bottom: 0,
                                trailing: 0
                            ))
                    }
                    Spacer()
                    SoundButtonView()
                        .padding(EdgeInsets(
                            top: 20,
                            leading: 0,
                            bottom: 0,
                            trailing: 20
                        ))
                }
                Spacer()
            }
            VStack{
                if timerViewModel.isTimer{
                    TimeTextView()
                } else {
                    PickerView()
                }
            }
        }
        .onReceive(timerViewModel.timer) { _ in
            timerViewModel.run()
        }
    }
}

struct TimeCountView_Previews: PreviewProvider {
    static var previews: some View {
        TimeCountView()
    }
}
