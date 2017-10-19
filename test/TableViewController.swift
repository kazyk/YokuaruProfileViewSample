//
//  TableViewController.swift
//  test
//
//  Created by kazuyuki takahashi on 2017/10/19.
//  Copyright © 2017年 kazuyuki takahashi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    @IBOutlet weak var iconView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconView.clipsToBounds = true
        iconView.layer.borderColor = UIColor.white.cgColor
        iconView.layer.cornerRadius = 3
        iconView.layer.borderWidth = 2
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .primaryActionTriggered)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIApplication.shared.statusBarStyle = .lightContent
        let navbar = navigationController!.navigationBar
        navbar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
    }

    @objc func refresh(_ sender: Any) {
        refreshControl?.endRefreshing()
    }
}

