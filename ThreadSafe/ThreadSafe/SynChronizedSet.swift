//
//  SynChronizedSet.swift
//  TheadSafeCollection
//
//  Created by vincent on 3/30/20.
//  Copyright © 2020 vincent. All rights reserved.
//

import UIKit

class SynchronizedSet:NSMutableSet {
    private var _storage: NSMutableSet!
    private let bmLock = BMLock()
    
    override init() {
        self._storage = NSMutableSet()
        super.init()
    }
    
    override init(capacity numItems: Int) {
        self._storage = NSMutableSet(capacity: numItems)
        super.init(capacity: numItems)
    }
    
    required init?(coder: NSCoder) {
        self._storage = NSMutableSet()
        super.init(coder: coder)
    }
    
    override func add(_ object: Any) {
        bmLock.synchronized({
            self._storage.add(object)
        })
    }

    
    override func remove(_ object: Any) {
        bmLock.synchronized({
            self._storage.remove(object)
        })
    }
}

extension SynchronizedSet {
    override var count: Int {
        return bmLock.synchronized({
            return self._storage.count
        })
    }
    
    override func member(_ object: Any) -> Any? {
        return bmLock.synchronized({
            return self._storage.member(object)
        })
    }
    
    override func objectEnumerator() -> NSEnumerator {
        return bmLock.synchronized({
            return self._storage.objectEnumerator()
        })
    }
    
}

extension SynchronizedSet {
    override var allObjects: [Any] {
        return bmLock.synchronized({
            return self._storage.allObjects
        })
    }
    
    override func anyObject() -> Any? {
        return bmLock.synchronized({
            return self._storage.anyObject()
        })
    }
    
    override func contains(_ anObject: Any) -> Bool {
        return bmLock.synchronized({
            return self._storage.contains(anyObject)
        })
    }
    
    override var description: String {
        return bmLock.synchronized({
            return self.description
        })
    }
    
    override func description(withLocale locale: Any?) -> String {
        return bmLock.synchronized({
            return self.description(withLocale: locale)
        })
    }
    
    override func intersects(_ otherSet: Set<AnyHashable>) -> Bool {
        return bmLock.synchronized({
            return self.intersects(otherSet)
        })
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        return bmLock.synchronized({
            return self.isEqual(object)
        })
    }
    
    override func isSubset(of otherSet: Set<AnyHashable>) -> Bool {
        return bmLock.synchronized({
            return self.isSubset(of: otherSet)
        })
    }
    
    
    override func adding(_ anObject: Any) -> Set<AnyHashable> {
        return bmLock.synchronized({
            return self._storage.adding(anyObject)
        })
    }
    
    
    override func addingObjects(from other: Set<AnyHashable>) -> Set<AnyHashable> {
        return bmLock.synchronized({
            return self._storage.addingObjects(from: other)
        })
    }
    
   
    override func addingObjects(from other: [Any]) -> Set<AnyHashable> {
        return bmLock.synchronized({
            return self._storage.addingObjects(from: other)
        })
    }
    
    
   
    override func enumerateObjects(_ block: (Any, UnsafeMutablePointer<ObjCBool>) -> Void) {
         bmLock.synchronized({
             self._storage.enumerateObjects(block)
        })
    }
    
   
    override func enumerateObjects(options opts: NSEnumerationOptions = [], using block: (Any, UnsafeMutablePointer<ObjCBool>) -> Void) {
         bmLock.synchronized({
             self._storage.enumerateObjects(options: opts, using: block)
        })
    }
}

extension SynchronizedSet {
    
    override func addObjects(from array: [Any]) {
        bmLock.synchronized({
            self._storage.addObjects(from: array)
        })
    }
    
    override func intersect(_ otherSet: Set<AnyHashable>) {
        bmLock.synchronized({
            self._storage.intersect(otherSet)
        })
    }
    
    //
    override func minus(_ otherSet: Set<AnyHashable>) {
        bmLock.synchronized({
            self._storage.minus(otherSet)
        })
    }
    
    override func removeAllObjects() {
        bmLock.synchronized({
            self._storage.removeAllObjects()
        })
    }
    
    override func union(_ otherSet: Set<AnyHashable>) {
        bmLock.synchronized({
            self._storage.union(otherSet)
        })
    }
    
    override func setSet(_ otherSet: Set<AnyHashable>) {
        bmLock.synchronized({
            self._storage.setSet(otherSet)
        })
    }
}
