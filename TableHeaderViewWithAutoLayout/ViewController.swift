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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseId")
        tableView.backgroundColor = .lightGray
        
        let customView = Bundle.main.loadNibNamed("\(CustomTableHeaderView.self)", owner: nil, options: nil)!.first as! CustomTableHeaderView
        customView.label.text = "Wow, now it doesn't matter how many lines we have, since we use AutoLayout!.\n\nTry to rotate the device, it should update correctly. Read it in more details at https://medium.com/@aunnnn/table-header-view-with-autolayout-13de4cfc4343"
        customView.imageView.image = #imageLiteral(resourceName: "headerview.png")
        customView.layer.borderColor = UIColor.blue.cgColor
        customView.layer.borderWidth = 2

        // 1.
        self.tableView.setTableHeaderView(headerView: customView, rootView: self.view)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var needUpdate = false
        
        // 2.
        needUpdate = self.tableView.shouldUpdateHeaderViewFrame()
        
        //
        // ...You may need to do begin/endUpdates due to other reasons.
        //
        
        // Update once in the end
        if needUpdate {
            self.tableView.beginUpdates()
            self.tableView.endUpdates()
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
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
    
    func setTableHeaderView(headerView: UIView, rootView: UIView) {
        headerView.translatesAutoresizingMaskIntoConstraints = false

        // Set first.
        self.tableHeaderView = headerView
        
        // Then setup AutoLayout.
        headerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    func shouldUpdateHeaderViewFrame() -> Bool {
        guard let headerView = self.tableHeaderView else { return false }
        let oldSize = headerView.bounds.size

        // Update the size of the header based on its internal content.
        headerView.layoutIfNeeded()
        let newSize = headerView.bounds.size
        
        // Trigger table view to know that header should be updated.
        let header = self.tableHeaderView
        self.tableHeaderView = header
        
        return oldSize != newSize
    }
}
