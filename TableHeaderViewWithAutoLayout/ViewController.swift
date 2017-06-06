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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseId")
        
        let customView = Bundle.main.loadNibNamed("\(CustomTableHeaderView.self)", owner: nil, options: nil)!.first as! CustomTableHeaderView
        customView.label.text = "Wow, what now it doesn't matter how many lines will have, since we use AutoLayout elegantly.\nActually, try to rotate the device, it updates gracefully. Read it in more details at https://medium.com/@aunnnn/table-header-view-with-autolayout-13de4cfc4343"
        customView.imageView.image = #imageLiteral(resourceName: "headerview.png")
        
        // 1.
        self.tableView.setTableHeaderView(headerView: customView)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 2.
        if self.tableView.shouldUpdateHeaderViewFrame() {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseId", for: indexPath)
        cell.textLabel?.text = "Index \(indexPath)"
        return cell
    }
}
extension UITableView {
    func setTableHeaderView(headerView: UIView) {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.tableHeaderView = headerView
        
        // ** Must setup AutoLayout after set tableHeaderView.
        headerView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        headerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    func shouldUpdateHeaderViewFrame() -> Bool {
        guard let headerView = self.tableHeaderView else { return false }
        let oldSize = headerView.bounds.size        
        // Update the size
        headerView.layoutIfNeeded()
        let newSize = headerView.bounds.size
        return oldSize != newSize
    }
}
