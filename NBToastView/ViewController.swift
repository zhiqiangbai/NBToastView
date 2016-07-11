//
//  ViewController.swift
//  NBToastView
//
//  Created by NapoleonBai on 16/7/8.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

import UIKit


class ViewController: UITableViewController {
    
    let cellArrayTitles : Array = ["默认显示","修改背景颜色","修改圆角和文字颜色",]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = 55.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArrayTitles.count
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            NBToastView.restoredConfig()
            NBToastView.showToast("默认设置Toast", duration: 2)
        case 1:
            NBToastView.restoredConfig()
            NBToastView.setBgColor(UIColor.orangeColor().colorWithAlphaComponent(0.6))
            NBToastView.showToast("自定义背景色", duration: 2)
        case 2:
            NBToastView.restoredConfig()
            NBToastView.setCornerRadius(8)
            NBToastView.setTextColor(UIColor.whiteColor())
            NBToastView.showToast("修改圆角和文字颜色", duration: 2)
            
        default: break
            
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell")!
      
        cell.textLabel?.text = cellArrayTitles[indexPath.row]
        
        return cell
    }

    
}

