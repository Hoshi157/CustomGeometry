//
//  ViewController.swift
//  CustomGeometry
//
//  Created by 福山帆士 on 2020/08/08.
//  Copyright © 2020 福山帆士. All rights reserved.
//

import UIKit
import SceneKit

class ViewController: UIViewController {
    
    private let mySceneView: SCNView = {
        let sceneView = SCNView()
        return sceneView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setupSceneView()
        
        settingView()
        
        let scene = SCNScene()
        mySceneView.scene = scene
        
        addCameraNode(scene: scene)
        
        createNode(scene: scene)
    }
    
    func setupSceneView() {
        mySceneView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(mySceneView)
        let mySceneViewConstraits = [
            mySceneView.topAnchor.constraint(equalTo: view.topAnchor),
            mySceneView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mySceneView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mySceneView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(mySceneViewConstraits)
    }
    
    func settingView() {
        mySceneView.backgroundColor = #colorLiteral(red: 0.1298420429, green: 0.1298461258, blue: 0.1298439503, alpha: 1)
        mySceneView.autoenablesDefaultLighting = true
        mySceneView.allowsCameraControl = true
        mySceneView.showsStatistics = true
    }
    
    func addCameraNode(scene: SCNScene) {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 11)
        scene.rootNode.addChildNode(cameraNode)
    }
    
    func createNode(scene: SCNScene) {
        let harf = Float(2)
        
        let vertices = [
            SCNVector3(-harf, harf, harf), // 手前の4点 0
            SCNVector3(-harf, -harf, harf), // 1
            SCNVector3(harf, harf, harf), // 2
            SCNVector3(harf, -harf, harf), // 3
            
            SCNVector3(-harf, harf, -harf), // 奥の4点 4
            SCNVector3(-harf, -harf, -harf), // 5
            SCNVector3(harf, harf, -harf), // 6
            SCNVector3(harf, -harf, -harf) // 7
        ]
        
        let verticesSource = SCNGeometrySource(vertices: vertices)
        let faceSource = polygonCreate()
        let customGeometry = SCNGeometry(sources: [verticesSource], elements: [faceSource])
        let node = SCNNode(geometry: customGeometry)
        scene.rootNode.addChildNode(node)
        
        for vertex in vertices {
            let sphereGeometry = SCNSphere(radius: 0.3)
            let node = SCNNode(geometry: sphereGeometry)
            node.position = vertex
            scene.rootNode.addChildNode(node)
        }
    }
    
    func polygonCreate() -> SCNGeometryElement {
        // 半時計周りに指定するところが前
        let indices: [Int32] = [
            0, 1, 2, // 2行で1面 前
            2, 1, 3,
            
            2, 3, 6, // 右
            6, 3, 7,
            
            4, 1, 0, // 左
            4, 5, 1,
            
            6, 5, 4, // 奥
            7, 5, 6,
            
            0, 2, 4, // 上
            4, 2, 6,
            
            3, 1, 5, // 下
            5, 7, 3
        ]
        
        let faceSource = SCNGeometryElement(indices: indices, primitiveType: .triangles)
        return faceSource
    }
    
    
    
    
    


}

