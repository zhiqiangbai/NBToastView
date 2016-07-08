//
//  ViewController.swift
//  NBToastView
//
//  Created by NapoleonBai on 16/7/8.
//  Copyright © 2016年 NapoleonBai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector:#selector(ViewController.show), userInfo: nil, repeats: true)
        NBToastView.setTextColor(UIColor.redColor())
        NBToastView.setBgColor(UIColor.blueColor().colorWithAlphaComponent(0.2))
        NBToastView.showToast("这就是一个测试", duration: 2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func show() {
        NBToastView.showToast("这就是一个测试", duration: 2)
    }
}

