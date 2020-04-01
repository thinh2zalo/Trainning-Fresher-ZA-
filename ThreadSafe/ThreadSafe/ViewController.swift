//
//  ViewController.swift
//  ThreadSafe
//
//  Created by vincent on 3/30/20.
//  Copyright © 2020 vincent. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let date = Date()
        
        var array = SynchronizedArray()

    
        DispatchQueue.global().async {
            for i in 0..<10 {
                array.add(i)
            }
        }
       
        //
        DispatchQueue.global().async {
            for i in 10..<20 {
                array.add(i)
            }
        }
        
        DispatchQueue.global().asyncAfter(deadline:  .now() + 1.0) {
            var total = 0
            for a in array {
                total += a as! Int
            }
            NSLog("TIME:\(Date().timeIntervalSince(date)), TOTAL: \(total)")
        }
   }
    
    
    
    
}

