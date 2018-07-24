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
    private var letterNodes_: [SCNNode]!
    
    public var letters: Letters {
      get {
        return self.letters_
      }
      
      set(letters) {
        // Adjust colors count
        var colors: [NSColor]! = letters.colors
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
          for _ in 0..<(letters.letters.count - letters.fontNames.count) {
            fontNames.removeLast()
          }
        }
     
        // Adjust depths count
        var depths: [CGFloat]! = letters.depths
        if letters.depths.count < letters.depths.count {
          guard let lastDepth = letters.depths.last else {
            return
          }
          for _ in letters.depths.count..<letters.letters.count {
            depths.append(lastDepth)
          }
        }
        else if letters.depths.count > letters.letters.count {
          for _ in letters.depths.count..<letters.letters.count {
            depths.removeLast()
          }
        }
        
        self.letters_.letters = letters.letters
        self.letters_.colors = colors
        self.letters_.fontNames = fontNames
        self.letters_.depths = depths
      }
    }
    
    override init() {
      super.init()
    }
    
    init(letters: Letters) {
      super.init()
      self.letters_ = letters
      for (i, letter) in self.letters_.letterArray.enumerated() {
        let textGeo = SCNText(string: letter, extrusionDepth: self.letters.depths[i])
        let node = SCNNode(geometry: textGeo)
        self.addChildNode(node)
      }
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
    
  }
  
}
