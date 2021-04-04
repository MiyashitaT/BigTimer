//
//  TimeCountView.swift
//  BigTimer
//
//  Created by 鳥居克哉 on 2021/04/04.
//

import SwiftUI

struct TimeCountView: View {
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    BackButtonView()
                        .padding(EdgeInsets(
                            top: 20,        
                            leading: 20,
                            bottom: 0,
                            trailing: 0
                        ))
                    Spacer()
                }
                Spacer()
            }
            VStack{
              TimeTextView()
            }
        }
    }
}

struct TimeCountView_Previews: PreviewProvider {
    static var previews: some View {
        TimeCountView()
    }
}
