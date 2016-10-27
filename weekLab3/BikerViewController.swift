//
//  BikerViewController.swift
//  weekLab3
//
//  Created by user on 10/25/16.
//  Copyright © 2016 Jean. All rights reserved.
//

import UIKit

class BikerViewController: UIViewController {
    
    var bikerOriginalCenter: CGPoint!
    

    @IBOutlet weak var bikerImageVIew: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapBiker(_ sender: AnyObject) {
        let alertController = UIAlertController(title: "Yo dude", message: "watchYa Step", preferredStyle: .alert)
            let sorryAction = UIAlertAction(title: "Sorry bro", style: .default, handler: nil)
            alertController.addAction(sorryAction)
            present(alertController,animated: true, completion: nil)
        
    }

    @IBAction func didPanBiker(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        
        if sender.state == .began {
            bikerOriginalCenter = bikerImageVIew.center

        } else if sender.state == .changed{
                bikerImageVIew.center = CGPoint()
        } else if sender.state == .ended{
            
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
