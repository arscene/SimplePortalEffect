//
//  Extensions.swift
//  Portal
//
//  Created by Luc Francey on 29.10.18.
//  Copyright © 2018 Luc Francey. All rights reserved.
//

import Foundation
import SceneKit
import ARKit

var width : CGFloat = 0.02
var height : CGFloat = 1
var length : CGFloat = 1

var doorLength : CGFloat = 0.3

func createBox(isDoor : Bool) -> SCNNode{
    let node  = SCNNode()
    
    let firstBox = SCNBox(width: width, height: height, length: isDoor ? doorLength : length, chamferRadius: 0)
    let firstBoxNode = SCNNode(geometry: firstBox)
    firstBoxNode.renderingOrder = 200
    
    node.addChildNode(firstBoxNode)

    
    let maskedBox = SCNBox(width: width, height: height, length: isDoor ? doorLength : length, chamferRadius: 0)
    //maskedBox.firstMaterial?.diffuse.contents = UIColor.white
    //maskedBox.firstMaterial?.transparency = 0.000001
    maskedBox.firstMaterial?.colorBufferWriteMask = []
    
    let maskedBoxNode = SCNNode(geometry: maskedBox)
    maskedBoxNode.renderingOrder = 100
    maskedBoxNode.position = SCNVector3.init(width, 0, 0)
    
    node.addChildNode(maskedBoxNode)
    
    return node
}

extension FloatingPoint{
    var degreesToRadians : Self{
        return self * .pi / 180
    }
    
    var radiansToDegree : Self{
        return self * 180 / .pi
    }
}
