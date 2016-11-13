//
//  NextViewContrller.swift
//  ADTouchTracker
//
//  Created by adapter00 on 2016/11/13.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

class NextViewController:UIViewController {
    var naviTitle:String?
    
    @IBAction func didClickClose(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        self.navigationController?.title = naviTitle
    }
}
