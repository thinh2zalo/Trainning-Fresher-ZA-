//
//  SynchronizedArray.swift
//  TheadSafeCollection
//
//  Created by vincent on 3/30/20.
//  Copyright © 2020 vincent. All rights reserved.
//

import UIKit

class SynchronizedArray<Element> {
    private let queue = DispatchQueue(label: "thread_safe_access_array_queue", attributes: .concurrent)
    private var array = [Element]()
}

// MARK: - InMutable
extension SynchronizedArray {
    //TODO: implement InMutable for Array
}
    

// MARK: - Mutable
extension SynchronizedArray {
    func append(_ element:Element){
        queue.async (flags: .barrier) {
            self.array.append(element)
        }
    }
    
    func append( _ elements: [Element]) {
        queue.async  (flags: .barrier){
            self.array += elements
        }
    }
    
    func insert( _ element: Element, at index: Int) {
        queue.async (flags: .barrier) {
            self.array.insert(element, at: index)
        }
    }
    
    func remove(at index: Int, completion: ((Element) -> Void)? = nil) {
        queue.async(flags: .barrier){
            let element = self.array.remove(at: index)
            
            DispatchQueue.main.async {
                completion?(element)
            }
        }
    }
}
