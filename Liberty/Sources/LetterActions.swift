//
//  LettersActions.swift
//  Liberty
//
//  Created by Yota Odaka on 2018/07/27.
//  Copyright © 2018 Yota Odaka. All rights reserved.
//

import Foundation
import SceneKit

extension Liberty {
  
  class LetterActions {
    
    static func rotateLetter(lettersNode: Liberty.LettersNode,
                             at index: Int,
                             duration seconds: TimeInterval,
                             by euler: SCNVector3,
                             timingMode: SCNActionTimingMode = .linear) -> SCNAction {
      
      print(lettersNode.eulerAngles)
      var startEuler = lettersNode.eulerAngles
      let action = SCNAction.customAction(
        duration: seconds,
        action: {(lettersNode: SCNNode, elapsed: CGFloat) -> Void  in
          let elapsedRatio = elapsed / CGFloat(seconds)
          var i = index
          if lettersNode.childNodes.count <= i {
            i = lettersNode.childNodes.count - 1
          }
          if i < 0 {
            return
          }
          let node: SCNNode = lettersNode.childNodes[index]
          let diffEuler = euler * Float(elapsedRatio)
          node.eulerAngles = diffEuler + startEuler
          if elapsedRatio == 1.0 {
            startEuler = node.eulerAngles
          }
      })
      switch timingMode {
      case .easeIn:
        action.timingMode = .easeIn
      case .easeOut:
        action.timingMode = .easeOut
      case .easeInEaseOut:
        action.timingMode = .easeInEaseOut
      default:
        action.timingMode = .linear
      }
      return action
    }
    
  }
} // extension Liberty.LetersNode
