//
//  ViewController.swift
//  ADTouchTracker
//
//  Created by adapter00 on 11/06/2016.
//  Copyright (c) 2016 adapter00. All rights reserved.
//

import UIKit
import ADTouchTracker

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var dataSource:[TestCell] = [.alert,.resetTracking,.modalViewController,.pushNaviagtion]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return dataSource.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Identifer") {
            cell.textLabel?.text = dataSource[indexPath.row].rawValue
            return  cell
        }else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "Identifier")
            cell.textLabel?.text = dataSource[indexPath.row].rawValue 
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource[indexPath.row].testAction(viewController: self)
    }
}

enum TestCell:String {
   case alert = "alert", resetTracking="resetTracking",modalViewController="modalViewController",pushNaviagtion = "pushNavigation"
    func testAction(viewController:UIViewController) {
        switch self {
        case .alert:
            let alert = UIAlertController(title: "Alert", message: "Test message", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "close", style: UIAlertActionStyle.cancel, handler: {_ in}))
            viewController.present(alert, animated: true, completion: nil)
        case .pushNaviagtion:
            if let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PushViewController") as? PushViewController {
                viewController.navigationController?.pushViewController(next, animated: true)
            }
        case .modalViewController:
            if let next = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NextViewController") as? NextViewController {
                next.title = self.rawValue
                viewController.present(next, animated: true, completion: nil)
            }
        case .resetTracking:
            ADTouchTracker.sharedInstance.enableTracking ? ADTouchTracker.sharedInstance.stopTracking():ADTouchTracker.sharedInstance.startTracking()
        }
    }
}
