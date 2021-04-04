//
//  SoundModel.swift
//  BigTimer
//
//  Created by 宮下知也 on 2021/04/04.
//

import Foundation
import AudioToolbox 

class SoundModel: ObservableObject{
    @Published var isVibrationOn: Bool = true
    @Published var isAlarmOn: Bool = true
    @Published var soundID: SystemSoundID = 1151
    @Published var soundName: String = "Beat"
}
