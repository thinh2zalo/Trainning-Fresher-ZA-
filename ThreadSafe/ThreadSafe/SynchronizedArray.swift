//
//  SynchronizedArray.swift
//  TheadSafeCollection
//
//  Created by vincent on 3/30/20.
//  Copyright © 2020 vincent. All rights reserved.
//
import Foundation
import UIKit
class SynchronizedArray: NSMutableArray {
    var bmLock = BMLock()
    private var _array: NSMutableArray!
    
    override convenience init() {
        self.init(capacity: 0)
    }
    
    override init(capacity numItems: Int) {
        self._array = NSMutableArray(capacity: numItems)
        super.init()
    }
    
    required init?(coder: NSCoder) {
        self._array = NSMutableArray()
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func add(_ anObject: Any) {
        bmLock.synchronized({
            self._array.add(anObject)
        })
    }
    
    override func insert(_ anObject: Any, at index: Int) {
        bmLock.synchronized({
            self._array.insert(anObject, at: index)
        })
    }
    
    override func removeObject(at index: Int) {
        bmLock.synchronized {
            self._array.removeObject(at: index)
        }
    }
    
    override func removeLastObject() {
        bmLock.synchronized {
            self._array.removeLastObject()
        }
    }
    
    override func replaceObject(at index: Int, with anObject: Any) {
        bmLock.synchronized {
            self._array.replaceObject(at: index, with: anObject)
        }
    }
}


//// MARK: - InMutable
extension SynchronizedArray {
    override var count: Int {
        return  bmLock.synchronized({
            return self._array.count
        })
    }
    
    override func object(at index: Int) -> Any {
        return bmLock.synchronized({
            return self._array.object(at: index)
        })
    }
    
    override var lastObject: Any? {
        return bmLock.synchronized({
            return  self._array.lastObject
        })
    }
    
    override var firstObject: Any? {
        return bmLock.synchronized({
            return  self._array.firstObject
        })
    }
    
    override func objectEnumerator() -> NSEnumerator {
        return bmLock.synchronized({
            return self.objectEnumerator()
        })
    }
    
    func reversed() -> [Any] {
        return bmLock.synchronized({
            return self._array.reversed()
        })
    }
    
    override func reverseObjectEnumerator() -> NSEnumerator {
        return bmLock.synchronized({
            self._array.reverseObjectEnumerator()
        })
    }
}

//// MARK: - Mutable

extension SynchronizedArray {
    override func addObjects(from otherArray: [Any]) {
        bmLock.synchronized {
            self._array.addObjects(from: otherArray)
        }
    }
    
    override func exchangeObject(at idx1: Int, withObjectAt idx2: Int) {
        bmLock.synchronized {
            self._array.exchangeObject(at: idx1, withObjectAt: idx2)
        }
    }
    
    override func removeAllObjects() {
        bmLock.synchronized {
            self._array.removeAllObjects()
        }
    }
    
    override func remove(_ anObject: Any, in range: NSRange) {
        bmLock.synchronized {
            self._array.remove(anObject, in: range)
        }
    }
    
    override func removeObject(identicalTo anObject: Any, in range: NSRange) {
        bmLock.synchronized {
            self._array.removeObject(identicalTo: anObject, in: range)
        }
    }
    
    override func removeObjects(in otherArray: [Any]) {
        bmLock.synchronized {
            self._array.removeObjects(in: otherArray)
        }
    }
    
    override func removeObjects(in range: NSRange) {
        bmLock.synchronized {
            self._array.removeObjects(in: range)
        }
    }
    
    override func replaceObjects(in range: NSRange, withObjectsFrom otherArray: [Any], range otherRange: NSRange) {
        bmLock.synchronized {
            self._array.replaceObjects(in: range, withObjectsFrom: otherArray, range: otherRange)
        }
    }
    
    override func replaceObjects(in range: NSRange, withObjectsFrom otherArray: [Any]) {
        bmLock.synchronized {
            self._array.replaceObjects(in: range, withObjectsFrom: otherArray)
        }
    }
    
    override func setArray(_ otherArray: [Any]) {
        bmLock.synchronized {
             self._array.setArray(otherArray)
        }
    }
    
    override func sort(using comparator: Selector) {
        bmLock.synchronized({
            self._array.sort(using: comparator)
        })
    }
    
    override func insert(_ objects: [Any], at indexes: IndexSet) {
        bmLock.synchronized({
            self._array.insert(objects, at: indexes)
        })
    }
    
    override func removeObjects(at indexes: IndexSet) {
        bmLock.synchronized({
            self._array.removeObjects(at: indexes)
        })
    }
    
    override func replaceObjects(at indexes: IndexSet, with objects: [Any]) {
        bmLock.synchronized({
            self._array.replaceObjects(at: indexes, with: objects)
        })
    }
    
}

extension SynchronizedArray {
    override func adding(_ anObject: Any) -> [Any] {
        return  bmLock.synchronized({
            return self._array.adding(anObject)
        })
    }
    
    override func addingObjects(from otherArray: [Any]) -> [Any] {
        return bmLock.synchronized({
            return self.addingObjects(from: otherArray)
        })
    }
    
    override func componentsJoined(by separator: String) -> String {
        return bmLock.synchronized({
            return self._array.componentsJoined(by: separator)
        })
    }
    
    override func index(of anObject: Any) -> Int {
        return bmLock.synchronized({
            return self._array.index(of: anObject)
        })
    }
    
    override func index(of anObject: Any, in range: NSRange) -> Int {
        return bmLock.synchronized({
            return self._array.index(of: anObject, in: range)
        })
    }
    
    override func contains(_ anObject: Any) -> Bool {
        return bmLock.synchronized({
            self._array.contains(anObject)
        })
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        return bmLock.synchronized({
            return self._array.isEqual(object)
        })
    }
    
    override var sortedArrayHint: Data {
        return bmLock.synchronized({
            return self._array.sortedArrayHint
        })
    }
    
    override func sortedArray(_ comparator: @convention(c) (Any, Any, UnsafeMutableRawPointer?) -> Int, context: UnsafeMutableRawPointer?) -> [Any] {
        return bmLock.synchronized({
            return self._array.sortedArray(comparator, context: context)
        })
    }
    
    override func sortedArray(_ comparator: @convention(c) (Any, Any, UnsafeMutableRawPointer?) -> Int, context: UnsafeMutableRawPointer?, hint: Data?) -> [Any] {
        return bmLock.synchronized({
            return self._array.sortedArray(comparator, context: context, hint: hint)
        })
    }
    
    override func sortedArray(using comparator: Selector) -> [Any] {
        return bmLock.synchronized({
            return self._array.sortedArray(using: comparator)
        })
    }
    
    override func subarray(with range: NSRange) -> [Any] {
        return bmLock.synchronized({
            return self._array.subarray(with: range)
        })
    }
}


