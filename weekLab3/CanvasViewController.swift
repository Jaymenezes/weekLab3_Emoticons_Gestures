//
//  CanvasViewController.swift
//  weekLab3
//
//  Created by user on 10/25/16.
//  Copyright © 2016 Jean. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var trayView: UIView!
    @IBOutlet weak var pigImage: UIImageView!
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUpOffset: CGFloat!

    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    var originalFaceCenter: CGPoint!
    
    
    
    
    @IBOutlet weak var arrowImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        trayUpOffset = 190
        trayDown = trayView.center
        trayUp = CGPoint(x: trayView.center.x ,y: trayView.center.y - trayUpOffset)
        
//        trayDownOffset = 190
//        trayUp = trayView.center
//        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        return true
    }
    
    func didTaphNewlyCreatedFaces(sender: UITapGestureRecognizer) {
        
       newlyCreatedFace = sender.view as! UIImageView
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.8, options: [], animations: {
            
            self.newlyCreatedFace.transform = self.newlyCreatedFace.transform.scaledBy(x: 1.5, y: 1.5)

        }) { (Bool) in
            UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                
                self.newlyCreatedFace.transform = self.newlyCreatedFace.transform.scaledBy(x: 0.1, y: 0.1)
                
            }) { (Bool) in
                self.newlyCreatedFace.removeFromSuperview()

            }
        }
        

    }
    
    
    func didPinchNewlyCreatedFaces(sender: UIPinchGestureRecognizer) {
        // get the scale value from the pinch gesture recognizer
        //        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(didPinchNewlyCreatedFaces(sender:)))
        //
        //        pinchGestureRecognizer.delegate = self
        
        let scale = sender.scale
        newlyCreatedFace.transform = newlyCreatedFace.transform.scaledBy(x: scale, y: scale)
        sender.scale = 1
        
    }
    
    func didRotateNewlyFaces(sender: UIRotationGestureRecognizer) {
        // get the scale value from the pinch gesture recognizer
        
        
        
        let rotation = sender.rotation
        
        newlyCreatedFace.transform = newlyCreatedFace.transform.rotated(by: rotation)
        sender.rotation = 0
    }
    
    
    
    func didPanNewlyFaces(sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: view)
        
        //
        //        let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(didPinchNewlyCreatedFaces(sender:)))
        //        let rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(didRotateNewlyFaces(sender:)))
        //
        //
        //
        //        pinchGestureRecognizer.delegate = self
        //
        //        self.newlyCreatedFace.isUserInteractionEnabled = true
        //        self.newlyCreatedFace.isMultipleTouchEnabled = true
        //        self.newlyCreatedFace.addGestureRecognizer(pinchGestureRecognizer)
        //        self.newlyCreatedFace.addGestureRecognizer(rotateGestureRecognizer)
        
        
        if sender.state == .began {
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            UIView.animate(withDuration: 0.3){
                self.newlyCreatedFace.transform = self.newlyCreatedFace.transform.scaledBy(x: 1.2, y: 1.2)
            }
            
            
            
            
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
            
        } else if sender.state == .ended {
            UIView.animate(withDuration: 0.1){
                self.newlyCreatedFace.transform = self.newlyCreatedFace.transform.scaledBy(x: 0.8, y: 0.8)
                
            }
        }
        
    }
    
    
    @IBAction func panSmileyFaces(_ sender: UIPanGestureRecognizer) {
        
        let location = sender.location(in: view)
        
        let translation = sender.translation(in: view)


        
  
        
        
        
        //
        
        if sender.state == .began {
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPanNewlyFaces(sender:)))
            
            let pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(didPinchNewlyCreatedFaces(sender:)))
            let rotateGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(didRotateNewlyFaces(sender:)))
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTaphNewlyCreatedFaces(sender:)))
            let imageView = sender.view as! UIImageView
            rotateGestureRecognizer.delegate = self

            
            
            
            
            
            
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFace.center.x += trayView.frame.origin.x
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            UIView.animate(withDuration: 0.3){
                self.newlyCreatedFace.transform = self.newlyCreatedFace.transform.scaledBy(x: 1.3, y: 1.3)
            }
            self.newlyCreatedFace.isUserInteractionEnabled = true
            self.newlyCreatedFace.isMultipleTouchEnabled = true
            
            self.newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            self.newlyCreatedFace.addGestureRecognizer(pinchGestureRecognizer)
            self.newlyCreatedFace.addGestureRecognizer(rotateGestureRecognizer)
            self.newlyCreatedFace.addGestureRecognizer(tapGestureRecognizer)

            
            
            
        } else if sender.state == .changed {
            
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
            
        } else if sender.state == .ended {
            
            if location.y > 395 {
                UIView.animate(withDuration: 0.4, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.7, options: [], animations: {
                    
                    let imageView = sender.view as! UIImageView
                    
                                        self.newlyCreatedFace.center = imageView.center
                                        self.newlyCreatedFace.center.y += self.trayView.frame.origin.y
                                        self.newlyCreatedFace.center.x += self.trayView.frame.origin.x
                                        self.newlyCreatedFace.transform = self.newlyCreatedFace.transform.scaledBy(x: 0.8, y: 0.8)
                }) { (Bool) in
                                    self.newlyCreatedFace.removeFromSuperview()

                }
                
                
            } else {
                
                                    self.newlyCreatedFace.transform = self.newlyCreatedFace.transform.scaledBy(x: 0.7, y: 0.7)
            }


        }
        
    
}




@IBAction func panTray(_ sender: UIPanGestureRecognizer) {
    let location = sender.location(in: view)

    let translation = sender.translation(in: view)

    if sender.state == .began {
        trayOriginalCenter = trayView.center
       
        
        
    } else if sender.state == .changed {
        print(location)
        if location.y < 350 {
                trayView.center = CGPoint(x: trayOriginalCenter.x, y: 667 + (translation.y / 10))
        } else {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        }
        
        
    } else if sender.state == .ended {
        
        let velocity = sender.velocity(in: view)
        
        if velocity.y > -100 {
            UIView.animate(withDuration: 0.7, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                
                self.trayView.center = self.trayDown
                self.arrowImage.transform = self.arrowImage.transform.rotated(by:CGFloat(-180 * M_PI / 180))
                
            }) { (Bool) in
                
            }
            
            
        } else if velocity.y < 100 {
            UIView.animate(withDuration: 0.7, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
                
                self.trayView.center = self.trayUp
                self.arrowImage.transform = self.arrowImage.transform.rotated(by:CGFloat(180 * M_PI / 180))
                
                
            }) { (Bool) in
                
            }
            
        }
        
    }
    
}




@IBAction func didPressAnimatePig(_ sender: AnyObject) {
    
    
    
    
    UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 100, options: [], animations: {
        self.pigImage.transform = self.pigImage.transform.translatedBy(x: 0, y: -250)
    }) { (Bool) in
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 1, initialSpringVelocity: 100, options: [], animations: {
            self.pigImage.transform = CGAffineTransform.identity
            }, completion: { (Bool) in
                
        })
        
        
    }
    
}


@IBAction func didTapMoveDown(_ sender: AnyObject) {
    
    UIView.animate(withDuration: 0.7, delay: 0.3, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: [], animations: {
        
        
        
        self.trayView.transform = self.trayView.transform.translatedBy(x: 0, y: -180)
        
    }) { (Bool) in
        
    }

}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

}
