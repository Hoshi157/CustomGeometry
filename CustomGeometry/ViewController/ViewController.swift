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
            SCNVector3(-harf, harf, -harf), // 手前の4点
            SCNVector3(-harf, -harf, -harf),
            SCNVector3(harf, harf, -harf),
            SCNVector3(harf, -harf, -harf),
            
            SCNVector3(-harf, harf, harf), // 奥の4点
            SCNVector3(-harf, -harf, harf),
            SCNVector3(harf, harf, harf),
            SCNVector3(harf, -harf, harf)
        ]
        
        let verticesSource = SCNGeometrySource(vertices: vertices)
        let customGeometry = SCNGeometry(sources: [verticesSource], elements: [])
        let node = SCNNode(geometry: customGeometry)
        scene.rootNode.addChildNode(node)
        
        for vertex in vertices {
            let sphereGeometry = SCNSphere(radius: 0.3)
            let node = SCNNode(geometry: sphereGeometry)
            node.position = vertex
            scene.rootNode.addChildNode(node)
        }
    }
    
    
    
    


}

