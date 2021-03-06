//
//  GameViewController.swift
//  Liberty
//
//  Created by Yota Odaka on 2018/07/23.
//  Copyright © 2018 Yota Odaka. All rights reserved.
//

import SceneKit
import QuartzCore

class GameViewController: NSViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // create a new scene
    let scene = SCNScene(named: "art.scnassets/ship.scn")!
    
    // create and add a camera to the scene
    let cameraNode = SCNNode()
    cameraNode.camera = SCNCamera()
    scene.rootNode.addChildNode(cameraNode)
    
    // place the camera
    cameraNode.position = SCNVector3(x: 0, y: 0, z: 15)
    
    // create and add a light to the scene
    let lightNode = SCNNode()
    lightNode.light = SCNLight()
    lightNode.light!.type = .omni
    lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
    scene.rootNode.addChildNode(lightNode)
    
    // create and add an ambient light to the scene
    let ambientLightNode = SCNNode()
    ambientLightNode.light = SCNLight()
    ambientLightNode.light!.type = .ambient
    ambientLightNode.light!.color = NSColor.darkGray
    scene.rootNode.addChildNode(ambientLightNode)
    
    
    // retrieve the ship node
    let ship = scene.rootNode.childNode(withName: "ship", recursively: true)!
    
    
    // animate the 3d object
    ship.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))
    ship.isHidden = true
    
    let floorNode = SCNNode(geometry: SCNFloor())
//    scene.rootNode.addChildNode(floorNode)
    
    let letters = Liberty.Letters()
    letters.letters = "Lorem ipsum"
    letters.letterSpaces = [0.1]
    letters.letterSizes = [3]
    let lettersNode = letters.createLettersNode()
//    let lettersNode = Liberty.LettersNode(letters: letters)
    scene.rootNode.addChildNode(lettersNode)
    let rotateAction = SCNAction.group([
      Liberty.LetterActions.rotateLetter(lettersNode: lettersNode,at: 1, duration: 1, from: lettersNode.getLetterNode(at: 1)!.eulerAngles, by: SCNVector3(0, 0, CGFloat.pi*1.5), timingMode: .easeInEaseOut)!,
      Liberty.LetterActions.rotateLetter(lettersNode: lettersNode,at: 0, duration: 1, from: lettersNode.getLetterNode(at: 0)!.eulerAngles, by: SCNVector3(0, 0, CGFloat.pi*1.5), timingMode: .linear)!,
      ])
    let moveActionFore = Liberty.LetterActions.moveLetter(lettersNode: lettersNode, at: 2, duration: 1, from: lettersNode.getLetterNode(at: 2)!.position, by: SCNVector3(1, 0, 0), timingMode: .linear)!
    let moveActionBack = Liberty.LetterActions.moveLetter(lettersNode: lettersNode, at: 2, duration: 1, from: lettersNode.getLetterNode(at: 2)!.position + SCNVector3(1, 0, 0), by: SCNVector3(-1, 0, 0), timingMode: .linear)!
    let moveAction = SCNAction.sequence([ moveActionFore, moveActionBack ])
    
    let scaleAction = SCNAction.group([
        SCNAction.sequence([
            Liberty.LetterActions.scaleLetter(lettersNode: lettersNode, at: 1, duration: 0.8, from: lettersNode.getLetterNode(at: 1)!.scale, by: SCNVector3(1, 0.5, 0), timingMode: .easeInEaseOut)!,
            Liberty.LetterActions.scaleLetter(lettersNode: lettersNode, at: 1, duration: 0.4, from: lettersNode.getLetterNode(at: 1)!.scale + SCNVector3(1, 0.5, 0), by: SCNVector3(-1, -0.5, 0), timingMode: .easeInEaseOut)!,
          ]),
        SCNAction.sequence([
          Liberty.LetterActions.scaleLetter(lettersNode: lettersNode, at: 3, duration: 0.8, from: lettersNode.getLetterNode(at: 1)!.scale, by: SCNVector3(1, 0.5, 0), timingMode: .easeInEaseOut)!,
          Liberty.LetterActions.scaleLetter(lettersNode: lettersNode, at: 3, duration: 0.4, from: lettersNode.getLetterNode(at: 1)!.scale + SCNVector3(1, 0.5, 0), by: SCNVector3(-1, -0.5, 0), timingMode: .easeInEaseOut)!,
          ]),
        SCNAction.sequence([
          Liberty.LetterActions.scaleLetter(lettersNode: lettersNode, at: 7, duration: 0.8, from: lettersNode.getLetterNode(at: 1)!.scale, by: SCNVector3(1, 0.5, 0), timingMode: .easeInEaseOut)!,
          Liberty.LetterActions.scaleLetter(lettersNode: lettersNode, at: 7, duration: 0.4, from: lettersNode.getLetterNode(at: 1)!.scale + SCNVector3(1, 0.5, 0), by: SCNVector3(-1, -0.5, 0), timingMode: .easeInEaseOut)!,
          ]),
        SCNAction.sequence([
          Liberty.LetterActions.scaleLetter(lettersNode: lettersNode, at: 9, duration: 0.8, from: lettersNode.getLetterNode(at: 1)!.scale, by: SCNVector3(1, 0.5, 0), timingMode: .easeInEaseOut)!,
          Liberty.LetterActions.scaleLetter(lettersNode: lettersNode, at: 9, duration: 0.4, from: lettersNode.getLetterNode(at: 1)!.scale + SCNVector3(1, 0.5, 0), by: SCNVector3(-1, -0.5, 0), timingMode: .easeInEaseOut)!,
          ])
      ])
    
//    lettersNode.runAction(SCNAction.repeatForever(rotateAction))
//    lettersNode.runAction(SCNAction.repeatForever(moveAction))
    lettersNode.runAction(SCNAction.repeatForever(scaleAction))
    
    // retrieve the SCNView
    let scnView = self.view as! SCNView
    
    // set the scene to the view
    scnView.scene = scene
    
    // allows the user to manipulate the camera
    scnView.allowsCameraControl = true
    
    // show statistics such as fps and timing information
    scnView.showsStatistics = true
    
    // configure the view
    scnView.backgroundColor = NSColor.black
    
    // Add a click gesture recognizer
    let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(handleClick(_:)))
    var gestureRecognizers = scnView.gestureRecognizers
    gestureRecognizers.insert(clickGesture, at: 0)
    scnView.gestureRecognizers = gestureRecognizers
  }
  
  @objc
  func handleClick(_ gestureRecognizer: NSGestureRecognizer) {
    // retrieve the SCNView
    let scnView = self.view as! SCNView
    
    // check what nodes are clicked
    let p = gestureRecognizer.location(in: scnView)
    let hitResults = scnView.hitTest(p, options: [:])
    // check that we clicked on at least one object
    if hitResults.count > 0 {
      // retrieved the first clicked object
      let result = hitResults[0]
      
      // get its material
      let material = result.node.geometry!.firstMaterial!
      
      // highlight it
      SCNTransaction.begin()
      SCNTransaction.animationDuration = 0.5
      
      // on completion - unhighlight
      SCNTransaction.completionBlock = {
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        
        material.emission.contents = NSColor.black
        
        SCNTransaction.commit()
      }
      
      material.emission.contents = NSColor.red
      
      SCNTransaction.commit()
    }
  }
}
