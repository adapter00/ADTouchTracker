//
//  TouchView.swift
//  Pods
//
//  Created by adapter00 on 2016/11/06.
//
//

import Foundation
import UIKit

/// Touch View Builder, Hold and Remove view instance
internal class TouchViewBuilder {
    static let sharedInstance = TouchViewBuilder()
    fileprivate let viewSize = CGSize(width: 40, height: 40)
    fileprivate var viewHolder = [TapFingerView]()
    fileprivate init() { }
    
    func buildByPoint(_ points:[CGPoint]?) -> [TapFingerView] {
        guard let p = points else{
            self.viewHolder.forEach{ $0.removeFromSuperview()}
            return [TapFingerView]()
        }
        self.viewHolder.forEach{ $0.removeFromSuperview()}
        self.viewHolder = p.flatMap{
            let view = TapFingerView(frame: CGRect(origin: $0, size: viewSize))
            view.center = $0
            return view
        }
        return self.viewHolder
    }
}


protocol TapConfig {
    var viewBackGroundColor: UIColor? { get }
}

/// Touch View
internal class TapFingerView:UIView,TapConfig {
    var viewBackGroundColor: UIColor? {
        return UIColor(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.5)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = viewBackGroundColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = min(self.frame.width, self.frame.height) / 2
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("you need not called")
    }
}
