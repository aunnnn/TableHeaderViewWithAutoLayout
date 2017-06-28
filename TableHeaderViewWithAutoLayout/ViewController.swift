//
//  ViewController.swift
//  TableHeaderViewWithAutoLayout
//
//  Created by Wirawit Rueopas on 6/6/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseId")
        tableView.backgroundColor = .lightGray
        
        let customView = Bundle.main.loadNibNamed("\(CustomTableHeaderView.self)", owner: nil, options: nil)!.first as! CustomTableHeaderView
        customView.label.text = "This red view is tableHeaderView set programmatically. Try rotating the device, finally the Autolayout works!"
        customView.imageView.image = #imageLiteral(resourceName: "headerview.png")
        customView.layer.borderColor = UIColor.blue.cgColor
        customView.layer.borderWidth = 2

        // 1. Set table header view programmatically
        self.tableView.setTableHeaderView(headerView: customView)
        
        // 2. Set initial frame
        self.tableView.updateHeaderViewFrame()
    }

    // View size is changed (e.g., device is rotated.)
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // 3. Update header view's frmame
        DispatchQueue.main.async {
            self.tableView.updateHeaderViewFrame()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseId", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        
        if indexPath.row == 0 {
            cell.textLabel?.text = "Tap to view an example using UITableViewController (storyboard)"
        } else {
            cell.textLabel?.text = "Dummy Index \(indexPath)"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let tbv = storyboard!.instantiateViewController(withIdentifier: "tableViewController")
            self.show(tbv, sender: nil)
        }
    }
    
}
