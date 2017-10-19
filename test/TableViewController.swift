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
    @IBOutlet weak var backgroundImageViewContainer: UIView!
    @IBOutlet weak var effectView: UIVisualEffectView!
    @IBOutlet weak var profileView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iconView.clipsToBounds = true
        iconView.layer.borderColor = UIColor.white.cgColor
        iconView.layer.cornerRadius = 3

        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refresh(_:)), for: .primaryActionTriggered)
        
        effectView.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        UIApplication.shared.statusBarStyle = .lightContent
        let navbar = navigationController!.navigationBar
        navbar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navbar.setBackgroundImage(UIImage(), for: .default)
        navbar.shadowImage = UIImage()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollViewDidScroll(tableView)
    }

    @objc func refresh(_ sender: Any) {
        refreshControl?.endRefreshing()
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if profileView.window == nil {
            return
        }
        
        effectView.alpha = max(0.0, min(1.0, -(scrollView.contentOffset.y + scrollView.adjustedContentInset.top) / 80.0))
        
        let bottomRight = profileView.convert(profileView.bounds, to: view.window)
        let frameInWindow = CGRect(x: 0, y: 0, width: bottomRight.maxX, height: bottomRight.maxY)
        backgroundImageViewContainer.frame = backgroundImageViewContainer.superview!.convert(frameInWindow, from: view.window)

        let navbar = navigationController!.navigationBar
        let navbarFrameInWindow = navbar.convert(navbar.bounds, to: view.window)
        let progress = ((navbarFrameInWindow.maxY - bottomRight.minY) / navbarFrameInWindow.height)

        let alpha = max(0.0, min(1.0, progress))
        let white = 1 - alpha
        navbar.setBackgroundImage(minimumImage(color: UIColor.groupTableViewBackground.withAlphaComponent(alpha)), for: .default)
        navbar.titleTextAttributes = [.foregroundColor: UIColor(white: white, alpha: 1)]

        if alpha > 0.5 {
            UIApplication.shared.statusBarStyle = .default
        } else {
            UIApplication.shared.statusBarStyle = .lightContent
        }
    }
}

func minimumImage(color: UIColor) -> UIImage {
    UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
    color.setFill()
    UIBezierPath(rect: CGRect(x: 0, y: 0, width: 1, height: 1)).fill()
    let image = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    return image
}
