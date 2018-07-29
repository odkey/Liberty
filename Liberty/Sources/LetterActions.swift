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
    private static var callCountForMoveLetter = 0
    
    static func moveLetter(lettersNode: Liberty.LettersNode,
                           at index: Int,
                           duration seconds: TimeInterval,
                           by distance: SCNVector3,
                           timingMode: SCNActionTimingMode = .linear) -> SCNAction? {
      
      if index < 0 || lettersNode.childNodes.count <= index {
        Liberty.printLog("LetterActions.rotateLetter", message: "Out of index")
        return nil
      }
      let node: SCNNode = lettersNode.childNodes[index]
      var startPosition = SCNVector3Zero
      let action = SCNAction.customAction(duration: seconds, action: {(lettersNode: SCNNode, elapsed: CGFloat) -> Void in
        if callCountForMoveLetter == 0 {
          startPosition = node.position
        }
        let elapsedRatio = elapsed / CGFloat(seconds)
        let diffPosition = distance * Float(elapsedRatio)
        node.position = startPosition + diffPosition
        callCountForMoveLetter++
        if elapsedRatio == 1.0 {
          callCountForMoveLetter = 0
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
    
    private static var callCountForRotateLetter = 0
    
    static func rotateLetter(lettersNode: Liberty.LettersNode,
                             at index: Int,
                             duration seconds: TimeInterval,
                             by euler: SCNVector3,
                             timingMode: SCNActionTimingMode = .linear) -> SCNAction? {
      if index < 0 || lettersNode.childNodes.count <= index {
        Liberty.printLog("LetterActions.rotateLetter", message: "Out of index")
        return nil
      }
      let node: SCNNode = lettersNode.childNodes[index]
      var startEuler = SCNVector3Zero//node.eulerAngles
      let action = SCNAction.customAction(
        duration: seconds,
        action: {(lettersNode: SCNNode, elapsed: CGFloat) -> Void  in
          if callCountForRotateLetter == 0 {
            startEuler = node.eulerAngles
          }
          let elapsedRatio = elapsed / CGFloat(seconds)
          
          let diffEuler = euler * Float(elapsedRatio)
          node.eulerAngles = startEuler + diffEuler
          callCountForRotateLetter++
          if elapsedRatio == 1.0 {
            callCountForRotateLetter = 0
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
