//
//  TimeSettingView.swift
//  BigTimer
//
//  Created by 鳥居克哉 on 2021/04/04.
//

import SwiftUI

struct TimeSettingView: View {
    var body: some View {
            VStack{
                PickerView()
                StartButtonView()
            }
    }
}

struct TimeSettingView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSettingView()
    }
}
