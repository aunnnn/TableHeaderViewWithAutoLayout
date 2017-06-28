# TableHeaderViewWithAutoLayout
Example of how to use AutoLayout with table header view. 

It comes with UITableView's extension that helps you do this easily.

There are two examples:
1. using UITableView (with header view Xib) 
2. using UITableViewController (all in storyboard).

Requirements: Xcode 8, Swift 3, iOS 9+ (use anchors)

More detail [here](https://medium.com/@aunnnn/table-header-view-with-autolayout-13de4cfc4343)

![alt gif](http://g.recordit.co/6NIcSgwwSF.gif)


## How to use
1. In viewDidLoad()
```swift
// 1. Setup AutoLayout (do this instead of setting constraints via storyboard)
self.tableView.setTableHeaderView(headerView: self.tableView.tableHeaderView!)

// 2. Initial layout update
self.tableView.updateHeaderViewFrame()
```

2. (Optional) In viewWillTransition(to size: with coordinator:)
```swift
override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)

    // 3. Update layout every time device is rotated.
    DispatchQueue.main.async {
        self.tableView.updateHeaderViewFrame()
    }
}
```
