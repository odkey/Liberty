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
        // Adjust colors count
        var colors: [XColor]! = letters.colors
        if letters.colors.count < letters.letters.count {
          guard let lastColor = letters.colors.last else {
            return
          }
          for _ in letters.colors.count..<letters.letters.count {
            colors.append(lastColor)
          }
        }
        else if letters.colors.count > letters.letters.count {
          for _ in 0..<(letters.colors.count - letters.letters.count) {
            colors.removeLast()
          }
        }
        
        // Adjust font names count
        var fontNames: [String]! = letters.fontNames
        if letters.fontNames.count < letters.letters.count {
          guard let lastFontName = letters.fontNames.last else {
            return
          }
          for _ in letters.fontNames.count..<letters.letters.count {
            fontNames.append(lastFontName)
          }
        }
        else if letters.fontNames.count > letters.letters.count {
          for _ in 0..<(letters.fontNames.count - letters.letters.count) {
            fontNames.removeLast()
          }
        }
        
        // Adjust depths count
        var depths: [CGFloat]! = letters.depths
        if letters.depths.count < letters.letters.count {
          guard let lastDepth = letters.depths.last else {
            return
          }
          for _ in letters.depths.count..<letters.letters.count {
            depths.append(lastDepth)
          }
        }
        else if letters.depths.count > letters.letters.count {
          for _ in 0..<(letters.depths.count - letters.letters.count) {
            depths.removeLast()
          }
        }
        
        // Adjust lettter spaces count
        var spaces: [CGFloat]! = letters.letterSpaces
        if letters.letterSpaces.count < letters.letters.count {
          guard let lastSpace = letters.letterSpaces.last else {
            return
          }
          for _ in letters.letterSpaces.count..<letters.letters.count {
            spaces.append(lastSpace)
          }
        }
        else if letters.letterSpaces.count > letters.letters.count {
          for _ in 0..<(letters.letterSpaces.count - letters.letters.count) {
            spaces.removeLast()
          }
        }
        
        // Adjust lettter spaces count
        var sizes: [CGFloat]! = letters.letterSizes
        if letters.letterSizes.count < letters.letters.count {
          guard let lastSize = letters.letterSizes.last else {
            return
          }
          for _ in letters.letterSizes.count..<letters.letters.count {
            sizes.append(lastSize)
          }
        }
        else if letters.letterSizes.count > letters.letters.count {
          for _ in letters.letterSizes.count..<letters.letters.count {
            sizes.removeLast()
          }
        }
        
        self.letters_.letters = letters.letters
        self.letters_.colors = colors
        self.letters_.fontNames = fontNames
        self.letters_.depths = depths
        self.letters_.letterSpaces = spaces
        self.letters_.letterSizes = sizes
        self.letters_.horizontalAlignType = letters.horizontalAlignType
        
        for i in 0..<self.letters_.lettersCount {
          self.letterNodes_.append(SCNNode())
        }
      }
    }
    
    override init() {
      super.init()
    }
    
    init(letters: Letters) {
      super.init()
      self.letters = letters
      self.letterNodes_ = []
      print("[letterArray]\(self.letters_.letterArray)")
      for (i, letter) in self.letters_.letterArray.enumerated() {
        let textGeo = SCNText(string: letter, extrusionDepth: self.letters.depths[i])
        textGeo.font = XFont(name: self.letters_.fontNames[i], size: self.letters_.letterSizes[i])
        let node = SCNNode(geometry: textGeo)
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
    
    
  }
  
}
