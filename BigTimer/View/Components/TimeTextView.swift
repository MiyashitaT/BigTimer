//
//  TimeTextView.swift
//  BigTimer
//
//  Created by 鳥居克哉 on 2021/04/04.
//

import SwiftUI

struct TimeTextView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel
    
    var body: some View {
        GeometryReader{geometry in
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Text(timerViewModel.timeLeftStr)
                        .font(.custom("DSEG7ClassicMini-Bold", size: timerViewModel.calcTimeSize(height: geometry.size.height, width: geometry.size.width)))
                        .foregroundColor(self.timerViewModel.isStopping ? .red : .primary)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct TimeTextView_Previews: PreviewProvider {
    static var previews: some View {
        TimeTextView()
    }
}
