//
//  ADTouchTracker.swift
//  ADTouchTracker
//
//  Created by adapter00 on 2016/08/11.
//  Copyright © 2016年 adapter00. All rights reserved.
//

import Foundation
import UIKit


/// Build Tracking Pointer View
open class ADTouchTracker {
    /// Start Tracking
    open func startTracking() {
        self.enableTracking = true
    }
    /// End Tracking
    open func stopTracking() {
        self.enableTracking = false
    }
    
    // did swizzled `SendEvent` and `swizzleEvent`
    private var methodSwizzled = false 
    
    /// Singleton instance
    open static var sharedInstance = ADTouchTracker()
    
    /// Enable Tracking Mode
    open private(set) var enableTracking: Bool = false {
        didSet {
            guard let keyWindow = UIApplication.shared.keyWindow else {
                return
            }
            if enableTracking {
                keyWindow.swizzle()
            }else {
                keyWindow.swizzle()
                NotificationCenter.default.removeObserver(self)
                TouchViewBuilder.sharedInstance.buildByPoint(nil)
            }
        }
    }
    
    fileprivate init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationDidBecome), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    /// Build touch view from UIEvent
    internal func buildTouchView(from : UIEvent) {
        if from.type == UIEventType.touches {
            guard let keyWindow = UIApplication.shared.keyWindow,let touches = from.allTouches else {
                return
            }
            TouchViewBuilder.sharedInstance.buildByPoint(touches.filter{ !($0.phase == UITouchPhase.cancelled || $0.phase == UITouchPhase.ended)}.flatMap{ return $0.location(in: keyWindow)}).forEach{
                keyWindow.addSubview($0)
            }
        }
    }
    
    //MARK: AppDelegate Notification
    
    /// Notification From App Become
    @objc func applicationDidBecome() {
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return
        }
        if enableTracking && !methodSwizzled {
            keyWindow.swizzle()
            methodSwizzled = true
        }
    }
    
}
