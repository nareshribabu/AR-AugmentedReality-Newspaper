//
//  ViewController.swift
//  ARNewspaper
//  Created by Nareshri Babu on 2020-05-06.
//  Copyright © 2020 Nareshri Babu. All rights reserved.
//  This app was created for learning purposes.
//  All images were only used for learning purposes and do not belong to me.
//  All sounds were only used for learning purposes and do not belong to me.
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
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()

        if let trackedImages = ARReferenceImage.referenceImages(inGroupNamed: "NewsPaperImages", bundle: Bundle.main) {
            
            configuration.trackingImages = trackedImages
            
            configuration.maximumNumberOfTrackedImages = 2
            
            
        }
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        //anchor is the image that it found
        //renderer function is a delegate method so it gets called automatically
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {

            if imageAnchor.referenceImage.name == "harrypotter" {
                //add sk video
                let videoNode = SKVideoNode(fileNamed: "harrypotter.mp4")
                
                videoNode.play()
                
                let videoScene = SKScene(size: CGSize(width: 480, height: 360))
                
                videoScene.addChild(videoNode)
                
                videoNode.position = CGPoint(
                    x: videoScene.size.width / 2,
                    y: videoScene.size.height / 2)
                
                videoNode.yScale = -1.0
                
                //creating a plan overlay on top of the found image
                let plane = SCNPlane(
                    width: imageAnchor.referenceImage.physicalSize.width,
                    height: imageAnchor.referenceImage.physicalSize.height)
                
                plane.firstMaterial?.diffuse.contents = videoScene
                
                let planeNode = SCNNode(geometry: plane)
                
                planeNode.eulerAngles.x = -.pi / 2
                
                node.addChildNode(planeNode)
            }
            
            if imageAnchor.referenceImage.name == "prof" {
                
                //add sk video
                let videoNode = SKVideoNode(fileNamed: "prof.mp4")
                
                videoNode.play()
                
                let videoScene = SKScene(size: CGSize(width: 480, height: 360))
                
                videoScene.addChild(videoNode)
                
                videoNode.position = CGPoint(
                    x: videoScene.size.width / 2,
                    y: videoScene.size.height / 2)
                
                videoNode.yScale = -1.0
                
                //creating a plan overlay on top of the found image
                let plane = SCNPlane(
                    width: imageAnchor.referenceImage.physicalSize.width,
                    height: imageAnchor.referenceImage.physicalSize.height)
                
                plane.firstMaterial?.diffuse.contents = videoScene
                
                let planeNode = SCNNode(geometry: plane)
                
                planeNode.eulerAngles.x = -.pi / 2
                
                node.addChildNode(planeNode)
                
                
            }
        }
            
        return node
    }
    
    
}
