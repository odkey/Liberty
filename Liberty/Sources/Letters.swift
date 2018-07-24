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
    
    private var letters_: [String]! = ["A"]
    private var colors_: [NSColor]! = [NSColor.lightGray]
    private var fontNames_: [String]! = []
    private var depths_: [CGFloat]! = [0.1]
 
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
    
    public var colors: [NSColor]! {
      get {
        return self.colors_
      }
      
      set(colors) {
        if colors.count == 0 {
          print("Colors must be not less than 1")
          return
        }
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
