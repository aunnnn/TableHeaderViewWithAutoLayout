//
//  TableHeaderView+AutoLayout.swift
//  TableHeaderViewWithAutoLayout
//
//  Created by Wirawit Rueopas on 6/28/2560 BE.
//  Copyright © 2560 Wirawit Rueopas. All rights reserved.
//

import UIKit

extension UITableView {
    
    /// Set table header view & add Auto layout.
    func setTableHeaderView(headerView: UIView) {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Set first.
        self.tableHeaderView = headerView
        
        // Then setup AutoLayout.
        headerView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    /// Enquire whether header view frame is changed.
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
    
    /// Update header view's frame immediately.
    func updateHeaderViewFrame() {
        if self.shouldUpdateHeaderViewFrame() {
            self.beginUpdates()
            self.endUpdates()
        }
    }
}
