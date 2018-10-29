//
//  ViewController.swift
//  Portal
//
//  Created by Luc Francey on 28.10.18.
//  Copyright © 2018 Luc Francey. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Create a new scene
        //let scene = SCNScene(named: "art.scnassets/InvisibleBox.scn")!
        let scene = SCNScene(named: "art.scnassets/ship.scn")! //Comment this line to use the inspector version
        
        // Set the scene to the view
        sceneView.scene = scene
        
        setupScene() //Comment this line to use the inspector version
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    func setupScene(){
        //If you want explanations on the code follow the tutorial made by Jared Davidson : https://www.youtube.com/watch?v=uuxXHAKA1WY
        let node = SCNNode()
        node.position = SCNVector3.init(0,0,0)
        
        let leftWall = createBox(isDoor: false)
        leftWall.position = SCNVector3.init((-length/2) + width,0,0)
        leftWall.eulerAngles = SCNVector3.init(0,180.0.degreesToRadians,0)
        
        let rightWall = createBox(isDoor: false)
        rightWall.position = SCNVector3.init((length/2) - width,0,0)
        
        let topWall = createBox(isDoor: false)
        topWall.position = SCNVector3.init(0,(height/2) - width,0)
        topWall.eulerAngles = SCNVector3.init(0,0,90.0.degreesToRadians)
        
        let bottomWall = createBox(isDoor: false)
        bottomWall.position = SCNVector3.init(0,(-height/2) + width,0)
        bottomWall.eulerAngles = SCNVector3.init(0,0,-90.0.degreesToRadians)
        
        let backWall = createBox(isDoor: false)
        backWall.position = SCNVector3.init(0,0,(-length/2) + width)
        backWall.eulerAngles = SCNVector3.init(0,90.0.degreesToRadians,0)
        
        let leftDoorWall = createBox(isDoor: true)
        leftDoorWall.position = SCNVector3.init((-length/2) + (doorLength/2),0,length/2-width)
        leftDoorWall.eulerAngles = SCNVector3.init(0,-90.0.degreesToRadians,0)
        
        let rightDoorWall = createBox(isDoor: true)
        rightDoorWall.position = SCNVector3.init((length/2) - (doorLength/2),0,length/2-width)
        rightDoorWall.eulerAngles = SCNVector3.init(0,-90.0.degreesToRadians,0)
        
        let light = SCNLight()
        light.type = .spot
        light.spotInnerAngle = 70
        light.spotOuterAngle = 120
        light.zNear = 0.0001
        light.zFar = 5
        light.castsShadow = false
        light.shadowRadius = 200
        light.shadowColor = UIColor.black.withAlphaComponent(0.3)
        light.shadowMode = .deferred
        
        let constraint = SCNLookAtConstraint(target: bottomWall)
        constraint.isGimbalLockEnabled = true
        
        let lightNode = SCNNode()
        lightNode.light = light
        lightNode.position = SCNVector3.init(0, 0.1, 0)
        lightNode.constraints = [constraint]
        
        node.addChildNode(lightNode)
        
        node.addChildNode(leftWall)
        node.addChildNode(rightWall)
        node.addChildNode(topWall)
        node.addChildNode(bottomWall)
        node.addChildNode(backWall)
        node.addChildNode(leftDoorWall)
        node.addChildNode(rightDoorWall)
        
        self.sceneView.scene.rootNode.addChildNode(node)
        
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
