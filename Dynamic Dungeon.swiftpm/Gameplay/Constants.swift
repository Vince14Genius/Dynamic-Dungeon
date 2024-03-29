//
//  Constants.swift
//  
//
//  Created by Vincent C. on 5/10/23.
//

import Foundation

enum Dimensions {
    static let width: CGFloat = 720
    static let height: CGFloat = 1280
    static let size = CGSize(width: width, height: height)
    static let widthHalf  = width / 2
    static let heightHalf = height / 2
}

enum GameParameters {
    static let squareSide = Dimensions.width / 6

    static let initialSpeedDuration = 0.7
    
    /// The reciprocal of this value is the xScore at which the speed doubles (duration halves)
    static let scoreToAdditionalSpeedMultiplier = 0.025
    
    static let initialStunAttackChance = 0.01
    static let stunAttackChanceLimit = 0.1
    static let scoreToAdditionalStunAttackChanceMultiplier = 0.0005
    
    static let wallAttackChance = 0.005
    
    static let rowGenerationsNeededPerStar = 3
    
    static let stunDuration = 1.0
    static let stunDurationWithSuperpower = 0.25
    static let stunAttackWindupTime = 1.2
    static let stunAttackAppearDuration = 0.5
}

enum KeyCodes {
    static let esc  : UInt16 = 53
    static let a    : UInt16 = 0
    static let s    : UInt16 = 1
    static let d    : UInt16 = 2
    static let w    : UInt16 = 13
    static let left : UInt16 = 123
    static let right: UInt16 = 124
    static let down : UInt16 = 125
    static let up   : UInt16 = 126
}

enum ZIndices {
    static let labels : CGFloat = 15
    static let tiles   : CGFloat = 1
    static let walls   : CGFloat = 1.1
    static let effects : CGFloat = 2
    static let hero    : CGFloat = 3
    static let enemy   : CGFloat = 4
    static let shadows : CGFloat = 10
}
