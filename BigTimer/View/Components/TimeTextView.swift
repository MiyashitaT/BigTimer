//
//  TimeTextView.swift
//  BigTimer
//
//  Created by 鳥居克哉 on 2021/04/04.
//

import SwiftUI

struct TimeTextView: View {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        Text("11:19")
            .font(.custom("DSEG7ClassicMini-Bold", size: self.screenWidth * 0.2))
    }
}

struct TimeTextView_Previews: PreviewProvider {
    static var previews: some View {
        TimeTextView()
    }
}
