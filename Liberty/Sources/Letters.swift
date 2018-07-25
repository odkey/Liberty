//
//  Letters.swift
//  Liberty
//
//  Created by Yota Odaka on 2018/07/23.
//  Copyright © 2018 Yota Odaka. All rights reserved.
//

import Foundation
import CoreGraphics
import SceneKit
import CoreFoundation

extension Liberty {

  class Letters {
    
    private var letters_: [String]! = ["A","B","C"]
    private var colors_: [XColor]! = [XColor.red, XColor.green, XColor.blue]
    private var fontNames_: [String]! = ["HelveticaNeue"]
    private var flatnesses_: [CGFloat]! = [0.001]
    private var depths_: [CGFloat]! = [0.01]
    private var letterSpaces_: [CGFloat]! = [0.0]
    private var letterSizes_: [CGFloat]! = [0.5]
 
    private var alignType_: LettersHorizontalAlignType! = .left
 
    public var letters: String! {
      get {
        var letters = ""
        for letter in self.letters_ {
          letters = letters + letter
        }
        return letters
      }
      
      set(letters) {
        if letters.count == 0 {
          print("Letters must be not less than 1 character")
          return
        }
        self.letters_ = []
        for letter in letters {
          self.letters_.append(String(letter))
        }
      }
    }
    
    public var letterArray: [String]! {
      get {
        return self.letters_
      }
      
      set(letters) {
        self.letters_ = letters
      }
    }
    
    public var colors: [XColor]! {
      get {
        return self.colors_
      }
      
      set(colors) {
        if colors.count == 0 {
          print("Colors must be not less than 1")
          return
        }
        self.colors_ = colors
      }
    }
    
    public var fontNames: [String]! {
      get {
        return self.fontNames_
      }
      
      set(fontNames) {
        if fontNames.count == 0 {
          print("Font names must be not less than 1")
          return
        }
        self.fontNames_ = fontNames
      }
    }
    
    public var flatnesses: [CGFloat]! {
      get {
        return self.flatnesses_
      }
      
      set(flatnesses) {
        if flatnesses.count == 0 {
          print("Flatnesses must be not less than 1")
          return
        }
        self.flatnesses_ = flatnesses
      }
    }
    
    public var depths: [CGFloat]! {
      get {
        return self.depths_
      }
      
      set(depths) {
        if depths.count == 0 {
          print("Depths must be not less than 1")
          return
        }
        self.depths_ = depths
      }
    }
    
    public var letterSpaces: [CGFloat]! {
      get {
        return self.letterSpaces_
      }
      
      set(spaces) {
        if spaces.count == 0 {
          print("Letter spaces must be not less than 1")
          return
        }
        self.letterSpaces_ = spaces
      }
    }
    
    public var letterSizes: [CGFloat]! {
      get {
        return self.letterSizes_
      }
      
      set(sizes) {
        if sizes.count == 0 {
          print("Letter sizes must be not less than 1")
          return
        }
        self.letterSizes_ = sizes
      }
    }
    
    public var horizontalAlignType: LettersHorizontalAlignType {
      get {
        return self.alignType_
      }
      
      set(alignType) {
        self.alignType_ = alignType
      }
    }
    
    public var lettersCount: Int {
      return self.letterArray.count
    }
    
    
    init() { }
    
    init(letters: String!) {
      self.letters = letters
    }

    func createLettersNode() -> LettersNode {
      return LettersNode(letters: self)
    }
    
  }

}

extension Liberty.Letters {

  
}
