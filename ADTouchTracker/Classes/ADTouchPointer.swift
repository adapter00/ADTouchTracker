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
    open static func startTracking() {
        self.sharedInstance.enableTracking = true
    }
    /// End Tracking
    open static func stopTracking() {
        self.sharedInstance.enableTracking = false
    }
    
    /// Is Tracking
    open static var tracking:Bool {
        return self.sharedInstance.enableTracking
    }
    
    open static func sendEvent(from:UIEvent) {
        return self.sharedInstance.sendEvent(from: from)
    }
    
    //MARK: private methods
    
    
    // did swizzled `SendEvent` and `swizzleEvent`
    private var methodSwizzled = false
    
    /// Singleton instance
    private static var sharedInstance = ADTouchTracker()
    
    /// Enable Tracking Mode
    private(set) var enableTracking: Bool = false {
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
    private func sendEvent(from : UIEvent) {
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
