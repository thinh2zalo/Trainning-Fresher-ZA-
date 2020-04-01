//
//  BMLock.swift
//  ThreadSafe
//
//  Created by vincent on 3/31/20.
//  Copyright © 2020 vincent. All rights reserved.
//

import UIKit


protocol Lock {
    func lock()
    func unlock()
}

class BMLock:NSLocking {
    
    private let _lock:NSLocking = {
        if #available(iOS 10.0, tvOS 10.0, *) {
            return _OSUnfairLock()
        } else {
            return _OSSpinLock()
        }
    }()
    
    private final class _OSUnfairLock: NSLocking, Lock  {
        
        private var _lock = os_unfair_lock()
        
        func lock() {
            os_unfair_lock_lock(&_lock)
        }
        
        func unlock() {
            os_unfair_lock_unlock(&_lock)
        }
    }
    @available(iOS, deprecated: 10.0)
    @available(tvOS, deprecated: 10.0)
    private final class _OSSpinLock: NSLocking, Lock {
        
        private var _lock = OS_SPINLOCK_INIT
        
        func lock() {
            OSSpinLockLock(&_lock)
        }
        
        func unlock() {
            OSSpinLockUnlock(&_lock)
        }
    }
    
    
    public func lock() {
        _lock.lock()
    }
    
    public func unlock() {
        _lock.unlock()
    }
    
    
    
   public func synchronized<T>(_ closure: () -> T) -> T {
           lock(); defer { unlock() }
           return closure()
       }
    
    public func synchronized(_ closure: () -> Void) {
        lock(); defer { unlock() }
        return closure()
    }
    
}
