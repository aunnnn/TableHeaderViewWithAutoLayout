//
//  TableViewController.swift
//  TableHeaderViewWithAutoLayout
//
//  Created by Wirawit Rueopas on 6/28/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    @IBOutlet weak var customHeaderView: UIView!
    @IBOutlet weak var customLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customLabel.text = "This blue view is header view created in storyboard, embed inside UITableViewController. Check out the file and see the topmost view.\n\nAlso try to rotate this to check that the multiline label works."
        
        // 1. Setup AutoLayout
        self.tableView.setTableHeaderView(headerView: self.tableView.tableHeaderView!)
        
        // 2. First layout update
        self.tableView.updateHeaderViewFrame()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // 3. Update layout every time device frame is changed.
        DispatchQueue.main.async {
            self.tableView.updateHeaderViewFrame()
        }
    }
}
