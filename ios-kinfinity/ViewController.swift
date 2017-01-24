//
//  ViewController.swift
//  ios-kinfinity
//
//  Created by Kashif Khan on 1/24/17.
//  Copyright © 2017 Kashif Khan. All rights reserved.
//

import UIKit

class MainViewController: UIViewController , UIGestureRecognizerDelegate{
    var button = UIButton()
    let WINDOW_WIDTH = UIScreen.main.bounds.width
    let WINDOW_HEIGHT = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.8, green: 0.5,blue: 0.3,alpha: 1.0)
        
        // button
        button = UIButton(frame: CGRect( x: 0, y: 0, width: 150, height: 50) )
        button.center = CGPoint( x: WINDOW_WIDTH/2, y: WINDOW_HEIGHT/2 )
        button.backgroundColor = UIColor(red: 0.4, green: 0.6,blue: 1.0, alpha: 1.0)
        button.setTitle("To Infinity", for: .normal)
    
        button.addTarget(self, action: #selector(gotoInfinity), for: .touchUpInside)
        
        self.view.addSubview(button)
        
 
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func gotoInfinity()
    {
        let controller = InfinityViewController()
        controller.photosArray = ["mspa.jpg","mspb.jpg","mspc.jpg","mspd.jpg","mspe.jpg"]
        controller.title = "Infinity"
        show(controller, sender: self)
    }

}

