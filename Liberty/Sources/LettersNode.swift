//
//  LettersNode.swift
//  Liberty
//
//  Created by Yota Odaka on 2018/07/23.
//  Copyright © 2018 Yota Odaka. All rights reserved.
//

import Foundation
import SceneKit
import CoreFoundation

extension Liberty {
  
  class LettersNode: SCNNode {
    
    private var letters_: Letters! = Letters()
    private var letterNodes_: [SCNNode]! = []
    
    var letters: Letters {
      get {
        return self.letters_
      }
      
      set(letters) {
        // Adjust property amount
        let lettersCount = letters.lettersCount
        guard let colors = self.computeResizedPropertyArray(propertyArray: letters.colors, lettersCount: lettersCount),
              let fontNames = self.computeResizedPropertyArray(propertyArray: letters.fontNames, lettersCount: lettersCount),
              let flatnesses = self.computeResizedPropertyArray(propertyArray: letters.flatnesses, lettersCount: lettersCount),
              let depths = self.computeResizedPropertyArray(propertyArray: letters.depths, lettersCount: lettersCount),
              let spaces = self.computeResizedPropertyArray(propertyArray: letters.letterSpaces, lettersCount: lettersCount),
              let sizes = self.computeResizedPropertyArray(propertyArray: letters.letterSizes, lettersCount: lettersCount)
          else {
          return
        }
        self.letters_.letters = letters.letters
        self.letters_.colors = colors
        self.letters_.fontNames = fontNames
        self.letters_.flatnesses = flatnesses
        self.letters_.depths = depths
        self.letters_.letterSpaces = spaces
        self.letters_.letterSizes = sizes
        self.letters_.horizontalAlignType = letters.horizontalAlignType
        
        self.letterNodes_ = [SCNNode](repeating: SCNNode(), count: lettersCount)
      }
    }
    
    override init() {
      super.init()
      self.letters_ = Liberty.Letters()
      self.letterNodes_ = []
    }
    
    init(letters: Letters) {
      super.init()
      self.letters = letters
      self.letterNodes_ = []
      print("[letterArray]\(self.letters_.letterArray)")
      for (i, letter) in self.letters_.letterArray.enumerated() {
        // a b c d e f g h i j k l m n o p q r s t u v w x y z , . : ; ! ?
        let textGeo = SCNText(string: letter, extrusionDepth: self.letters.depths[i])
        textGeo.font = XFont(name: self.letters_.fontNames[i], size: self.letters_.letterSizes[i])
        textGeo.flatness = self.letters_.flatnesses[i]
        textGeo.firstMaterial?.diffuse.contents = self.letters_.colors[i]
        let node = SCNNode(geometry: textGeo)
        let (min, max) = node.boundingBox
        node.pivot = SCNMatrix4MakeTranslation(min.x + (max.x - min.x)/2,
                                               min.y + (max.y - min.y)/2,
                                               min.z + (max.z - min.z)/2)
        self.letterNodes_.append(node)
        self.addChildNode(node)
        
      }
      var offsetX: CGFloat = 0
      for (i, node) in self.letterNodes_.enumerated() {
        guard let letters =  self.letters_ else {
          Liberty.printLog("LettersNode.init", message: "Letters not found.")
          return
        }
        let letterStr = letters.letterArray[i]
        switch self.letters_.horizontalAlignType {
        case .left:
          let (min, max) = node.boundingBox
          let width = max.x - min.x
          Liberty.printLog("LettersNode.init", message: "letter: \(letterStr), width: \(width), width+space: \(width * self.letters.letterSpaces[i]), pivot:\(node.pivot.m41)")
          offsetX += width * self.letters.letterSpaces[i]
          offsetX += width / 2
          print("[offsetX]\(offsetX)")
          node.transform = SCNMatrix4MakeTranslation(offsetX, node.pivot.m42, 0)
          print(node.transform)
          offsetX += width/2
          print("")
        case .center:
          print("")
        case .right:
          print("")
        }
      }
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    public func getLetterNode(at index: Int) -> SCNNode? {
      if index < 0 || self.letterNodes_.count <= index {
        Liberty.printLog("LetterNode.getLetterNode", message: "Out of index.")
        return nil
      }
      return self.letterNodes_[index]
    }
    
    private func computeResizedPropertyArray<T>(propertyArray: [T],
                                        lettersCount: Int) -> [T]? {
      var properties = propertyArray
      if propertyArray.count < lettersCount {
        guard let last = properties.last else {
          return nil
        }
        for _ in propertyArray.count..<lettersCount {
          properties.append(last)
        }
      }
      else if propertyArray.count > lettersCount {
        for _ in propertyArray.count..<lettersCount {
          properties.removeLast()
        }
      }
      return properties
    }
    
  }
  
} // extension Liberty
