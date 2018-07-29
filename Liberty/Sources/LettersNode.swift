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
      var offset: CGFloat = 0
      for (i, node) in self.letterNodes_.enumerated() {
        switch self.letters_.horizontalAlignType {
        case .left:
          guard let (min, max) = node.geometry?.boundingBox else {
            return
          }
          let width = (max - min).x
          offset += width * self.letters.letterSpaces[i]
          print("[offset]\(offset)")
          node.transform = SCNMatrix4MakeTranslation(offset, 0, 0)
          print(node.transform)
          offset += width
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
