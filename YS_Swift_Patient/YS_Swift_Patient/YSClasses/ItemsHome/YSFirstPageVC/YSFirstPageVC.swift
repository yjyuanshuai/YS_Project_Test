//
//  YSFirstPageVC.swift
//  YSYBPatient_Test
//
//  Created by YJ on 17/5/5.
//  Copyright © 2017年 YJ. All rights reserved.
//

import UIKit

class YSFirstPageVC: YSRootVC, UITableViewDelegate, UITableViewDataSource {
    
    var firstPageTableView:UITableView?
    var dataArr = [AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.initDataAndUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initDataAndUI() -> () {
        self.navigationItem.title = "我的首页"
    }
    
    func createTableView() -> () {
        firstPageTableView = UITableView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeightNoStatusAndNav), style: UITableViewStyle.grouped)
        firstPageTableView?.delegate = self
        firstPageTableView?.dataSource = self
        self.view.addSubview(firstPageTableView!)
    }
    
    // UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataArr.count;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < dataArr.count {

            return 0;
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "CellID");
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}



