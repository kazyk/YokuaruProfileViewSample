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
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var profileView: UIView!
    
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

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bottomRight = profileView.convert(profileView.bounds, to: nil)
        let frameInWindow = CGRect(x: 0, y: 0, width: bottomRight.maxX, height: bottomRight.maxY)
        backgroundImageView.frame = backgroundImageView.superview!.convert(frameInWindow, from: nil)
    }
}

