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
        self.testAdd()
        self.testRemoveLast()
        self.testInsert()
        self.testRemove()
        self.testReplaceObject()
        // set
        self.testAddSet()
    }
    
    func testAdd() {
        let date = Date()
        let array = SynchronizedArray()
        DispatchQueue.global().sync {
            for i in 0..<100000 {
                array.addObjects(from: [i])
            }
        }
        
        DispatchQueue.global().async {
            for i in 100000..<200000 {
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
    
    func testRemoveLast() {
        let array: SynchronizedArray = [1,2,3,4,5,6,7,8,9]
        DispatchQueue.concurrentPerform(iterations: 6, execute: {value in
            array.removeLastObject()
        })
    }
    
    func testInsert() {
        let array: SynchronizedArray = [1,2,3,4,5,6,7,8,9]
        array.insert(4, at: 2)
        array[2] as! Int == 4 ? print("pass") : print("false")
    }
    
    func testRemove() {
        let array: SynchronizedArray = [1,2,3,4,5,6,7,8,9]

        DispatchQueue.concurrentPerform(iterations: 3, execute: {value in
             array.removeObject(at: 4)
        })
        array == [1,2,3,4,8,9] ? print("pass") : print("false")
    }
    

    
    func testReplaceObject() {
        let array: SynchronizedArray = [1,2,3,4,5,6,7,8,9]
        DispatchQueue.concurrentPerform(iterations: 3, execute: {value in
            array.replaceObject(at: 1, with: 10)
        })
        array == [1,10,3,4,5,6,7,8,9] ? print("pass") : print("false")
    }
    
    func testAddSet() {
        var set: SynchronizedSet = [1,2,3,4]
        print(set)
    }
    
    
    
    
    
//    func testIndexOfObject {
//
//    }

    
}



