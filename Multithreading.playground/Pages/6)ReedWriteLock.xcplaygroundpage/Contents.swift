import UIKit
import Foundation

//-----------------/pthread_rwlock/-----------------//Unix
class ReadWriteLock {
    private var lock = pthread_rwlock_t()
    private var attribute = pthread_rwlockattr_t()
    
    private var globalProperty: Int = 0
    init() {
        pthread_rwlock_init(&lock, &attribute)
    }
    
    public var workProperty: Int {
        get {
            pthread_rwlock_wrlock(&lock)
            let temp = globalProperty
            pthread_rwlock_unlock(&lock)
            return temp
        }
        set {
            pthread_rwlock_wrlock(&lock)
            globalProperty  = newValue
            pthread_rwlock_unlock(&lock)
        }
    }
}
//-----------------/SpinLock/-----------------// > IOS: 10.0
/*
class SpinLock {
    private var lock = OS_SPINLOCK_INIT
    var array = [Int]()
    func somefunc() {
        OSSpinLockLock(&lock)
        array.append(1)
        OSSpinlockUnlock(&lock)
    }
 }
 */
//-----------------/UnfairLock/-----------------// < IOS: 10.0
class UnfairLock {
    private var lock = os_unfair_lock_s()
    var array = [Int]()
    func someFunc() {
        os_unfair_lock_lock(&lock)
        array.append(1)
        os_unfair_lock_unlock(&lock)
    }
}
//-----------------/Synchronized/-----------------// Obj C
class SynchronizedOnjc {
    private let lock = NSObject()
    
    var array = [Int]()
    func someFunc() {
        objc_sync_enter(lock)
        array.append(1)
        objc_sync_exit(lock)
    }
}
