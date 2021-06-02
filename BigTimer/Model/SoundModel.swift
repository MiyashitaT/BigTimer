//
//  SoundModel.swift
//  BigTimer
//
//  Created by 宮下知也 on 2021/04/04.
//

import Foundation
import AudioToolbox 

class SoundModel: ObservableObject{
    var isAlarmOn: Bool = true
    var soundID: SystemSoundID = 1151
    var soundName: String = "Beat"
}
