//
//  ViewController.swift
//  Poke3d
//
//  Created by Nicolas Dolinkue on 19/04/2022.
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
        
        //damos mas luz
        sceneView.autoenablesDefaultLighting = true
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration cambiamos el inicio por el track de la imagen
        let configuration = ARWorldTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Pokemon Cards", bundle: Bundle.main) {
            
            configuration.detectionImages = imageToTrack
            
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
    
    
    // el anchor es el objeto que se detecta, y el SCNNode es el objeto 3D que se da al detectar
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            
            
            
            // le damos la dimencion, y el tamano sale del mismo que tiene la imagen por eso el .w y .h
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            
            //hacemos transparente
            plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.5)
            
            
            let planeNode = SCNNode(geometry: plane)
            
            // con esto rotamos la imagen generada en 3D a 90grados para que siga la carta
            planeNode.eulerAngles.x = -.pi/2
            
            
            
            node.addChildNode(planeNode)
            
            // con referenceImage.name sacamos el nombre que reconoce la camara
            if imageAnchor.referenceImage.name == "eevee" {
                
                // traemos el modelo 3D del poke
                if let pokeScene = SCNScene(named: "art.scnassets/eevee.scn") {
                    
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        
                        pokeNode.eulerAngles.x = .pi/2
                        
                        planeNode.addChildNode(pokeNode)
                        
                    }
                    
                }
                
                
            } else if imageAnchor.referenceImage.name == "oddish" {
                
                // traemos el modelo 3D del poke
                if let pokeScene = SCNScene(named: "art.scnassets/oddish.scn") {
                    
                    if let pokeNode = pokeScene.rootNode.childNodes.first {
                        
                        pokeNode.eulerAngles.x = .pi/2
                        
                        planeNode.addChildNode(pokeNode)
                        
                    }
                    
                }
                
                
            }
            
            
         
            
            
            
        }
        
        
        return node
        
    }
}
