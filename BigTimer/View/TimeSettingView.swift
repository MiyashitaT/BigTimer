//
//  TimeSettingView.swift
//  BigTimer
//
//  Created by 鳥居克哉 on 2021/04/04.
//

import SwiftUI

struct TimeSettingView: View {
    var body: some View {
        ZStack{
            VStack{
                HStack{
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
                PickerView()
                StartButtonView()
                .padding(EdgeInsets(
                    top: 50,
                    leading: 30,
                    bottom: 30,
                    trailing: 30
                ))
            }
        }
    }
}

struct TimeSettingView_Previews: PreviewProvider {
    static var previews: some View {
        TimeSettingView()
    }
}
