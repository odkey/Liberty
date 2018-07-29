//
//  Liberty.swift
//  Liberty
//
//  Created by Yota Odaka on 2018/07/23.
//  Copyright © 2018 Yota Odaka. All rights reserved.
//

#if os(iOS)
  
  import UIKit
  typealias XView = UIView
  typealias XImage = UIImage
  typealias XColor = UIColor
  typealias XFont = UIFont
  typealias XBezierPath = UIBezierPath
  typealias XScrollView = UIScrollView
  typealias XViewController = UIViewController
  
#elseif os(macOS)
  
  import Cocoa
  typealias XView = NSView
  typealias XImage = NSImage
  typealias XColor = NSColor
  typealias XFont = NSFont
  typealias XBezierPath = NSBezierPath
  typealias XScrollView = NSScrollView
  typealias XViewController = NSViewController

#endif

public class Liberty {
  
}

extension Liberty {
  
  public enum LettersHorizontalAlignType {
    
    case left
    case center
    case right
    
  }
  
  internal static func printLog(_ groupName: String, message: String) {
    print("[Liberty.\(groupName)] \(message)")
  }
  
} // extension Liberty
