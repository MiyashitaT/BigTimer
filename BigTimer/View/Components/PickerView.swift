//
//  PickerView.swift
//  BigTimer
//
//  Created by 鳥居克哉 on 2021/04/04.
//

import SwiftUI

struct PickerView: View {
    @EnvironmentObject var timerViewModel: TimerViewModel

    let screenWidth = UIScreen.main.bounds.width

    let screenHeight = UIScreen.main.bounds.height

    var hours = [Int](0..<24)

    var minutes = [Int](0..<60)

    var seconds = [Int](0..<60)
    
    var body: some View {
        HStack {
            PickerContent(
                text: "時間",
                time: self.hours,
                selection: self.$timerViewModel.hourSelection,
                screenWidth:  self.screenWidth,
                screenHeight: self.screenHeight
            )
            
            PickerContent(
                text: "分",
                time: self.minutes,
                selection: self.$timerViewModel.minSelection,
                screenWidth: self.screenWidth,
                screenHeight: self.screenHeight)
            
            PickerContent(
                text: "秒",
                time: self.seconds,
                selection: self.$timerViewModel.secSelection,
                screenWidth: self.screenWidth,
                screenHeight: self.screenHeight)
        }
    }
}

struct PickerContent: View{
    var text: String
    var time: [Int]
    @Binding var selection: Int
    let screenWidth: CGFloat
    let screenHeight: CGFloat
    
    var body: some View {
        HStack {
            Picker(selection: $selection, label: Text(text)) {
                ForEach(0 ..< time.count) { index in
                    Text("\(time[index])")
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(width: self.screenWidth * 0.2, height: self.screenWidth * 0.4)
            .clipped()
            .labelsHidden()
            
            Text(text)
                .font(.headline)
        }
    }
}

struct Picker_Previews: PreviewProvider {
    static var previews: some View {
        PickerView()
    }
}
