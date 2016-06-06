//
//  NKOverdueController.swift
//  NKBill
//
//  Created by nick on 16/6/3.
//  Copyright © 2016年 NickChen. All rights reserved.
//

import UIKit

class NKOverdueController: NKBaseViewController {

    private lazy var tableView : NKBaseTableView = {
        var tv = NKBaseTableView(frame: CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.height - 64 - 44 - 30), style: .Grouped)
        tv.backgroundColor = Constant.Color.BGColor
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    private var items = NKLibraryAPI.sharedInstance.getOverdueItems()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.addSubview(tableView)
        self.tableView.tableHeaderView = UIView(frame: CGRectMake(0, 0, 0, CGFloat.min ))
        tableView.registerCellNib(NKScheduleCell)
        NKLibraryAPI.sharedInstance.updateUIWith(String(self)) { [unowned self]() -> Void in
            self.tableView.reloadData()
        }
    }
    
}

extension NKOverdueController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(NKScheduleCell.identifier) as! NKScheduleCell
         cell.item = items[indexPath.row]
        return cell
    }
    
}

extension NKOverdueController : UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
//        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        UIAlertManager.showAcitonSheet(items[indexPath.row],state: State.Overdue)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return NKScheduleCell.height()
    }
}
