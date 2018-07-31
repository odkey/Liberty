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
    
    static func moveLetter(lettersNode: Liberty.LettersNode,
                           at index: Int,
                           duration seconds: TimeInterval,
                           from startPosition: SCNVector3,
                           by distance: SCNVector3,
                           timingMode: SCNActionTimingMode = .linear) -> SCNAction? {
      
      if index < 0 || lettersNode.childNodes.count <= index {
        Liberty.printLog("LetterActions.rotateLetter", message: "Out of index")
        return nil
      }
      let node: SCNNode = lettersNode.childNodes[index]
      let action = SCNAction.customAction(duration: seconds, action: {(lettersNode: SCNNode, elapsed: CGFloat) -> Void in
        let elapsedRatio = elapsed / CGFloat(seconds)
        let diffPosition = distance * Float(elapsedRatio)
        node.position = startPosition + diffPosition
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
    
    static func rotateLetter(lettersNode: Liberty.LettersNode,
                             at index: Int,
                             duration seconds: TimeInterval,
                             from startEuler: SCNVector3,
                             by euler: SCNVector3,
                             timingMode: SCNActionTimingMode = .linear) -> SCNAction? {
      if index < 0 || lettersNode.childNodes.count <= index {
        Liberty.printLog("LetterActions.rotateLetter", message: "Out of index")
        return nil
      }
      let node: SCNNode = lettersNode.childNodes[index]
      let action = SCNAction.customAction(
        duration: seconds,
        action: {(lettersNode: SCNNode, elapsed: CGFloat) -> Void  in
          let elapsedRatio = elapsed / CGFloat(seconds)
          let diffEuler = euler * Float(elapsedRatio)
          node.eulerAngles = startEuler + diffEuler
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
    
    static func scaleLetter(lettersNode: Liberty.LettersNode,
                             at index: Int,
                             duration seconds: TimeInterval,
                             from startScale: SCNVector3,
                             by scale: SCNVector3,
                             timingMode: SCNActionTimingMode = .linear) -> SCNAction? {
      if index < 0 || lettersNode.childNodes.count <= index {
        Liberty.printLog("LetterActions.scaleLetter", message: "Out of index")
        return nil
      }
      let node: SCNNode = lettersNode.childNodes[index]
      let action = SCNAction.customAction(
        duration: seconds,
        action: {(lettersNode: SCNNode, elapsed: CGFloat) -> Void  in
          let node = lettersNode.childNodes[index]
          let elapsedRatio = elapsed / CGFloat(seconds)
          let diffScale = scale * Float(elapsedRatio)
          node.scale = startScale + diffScale
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
