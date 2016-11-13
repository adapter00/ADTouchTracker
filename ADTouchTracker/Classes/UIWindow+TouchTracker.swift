//
//  UIWindow+TouchTracker.swift
//  Pods
//
//  Created by adapter00 on 2016/11/06.
//
//

import Foundation
import UIKit

extension UIWindow {
    /// swizzled Event from  `UIApplication.sendEvent(_)` and Repoonder Chain
    func swizzleEvent(event:UIEvent) {
        ADTouchTracker.sendEvent(from: event)
        swizzleEvent(event: event)
    }
    
    /// method swizzle for pointer
    func swizzle() {
        let method:Method = class_getInstanceMethod(object_getClass(self), #selector(UIApplication.sendEvent(_:)))
        let selfEvent: Method = class_getInstanceMethod(object_getClass(self), #selector(self.swizzleEvent(event:)))
        method_exchangeImplementations(method, selfEvent)
    }
}
