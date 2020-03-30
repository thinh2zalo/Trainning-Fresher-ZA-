//
//  SynChronizedSet.swift
//  TheadSafeCollection
//
//  Created by vincent on 3/30/20.
//  Copyright © 2020 vincent. All rights reserved.
//

import UIKit

class SynchronizedSet<T: Hashable> {
  
  private let queue = DispatchQueue(label: "thread_safe_access_set_queue", attributes: .concurrent)
    
  private var storage: Set<T> = []
  
  func contains(_ item: T) -> Bool {
    var containsItem: Bool!
    queue.sync {
      containsItem = self.storage.contains(item)
    }
    return containsItem
  }
  
  func insert(_ item: T) {
    queue.async(flags: .barrier) {
      self.storage.insert(item)
    }
  }
  
  func remove(_ item: T) {
    queue.async(flags: .barrier) {
      self.storage.remove(item)
    }
  }
  
  func removeAll() {
    queue.async(flags: .barrier) {
      self.storage.removeAll()
    }
  }
  
}
