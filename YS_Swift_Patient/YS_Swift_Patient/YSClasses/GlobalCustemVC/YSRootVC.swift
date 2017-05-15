//
//  YSRootVC.swift
//  YSYBPatient_Test
//
//  Created by YJ on 17/5/5.
//  Copyright © 2017年 YJ. All rights reserved.
//

import UIKit

class YSRootVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.commonUISetting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func commonUISetting() -> () {
        self.view.backgroundColor = kDefaultBackgroundColor

        let backBtn:UIButton = UIButton(type: .custom)
        backBtn.frame = CGRect(x: 0, y: 0, width: 60, height: 40)
        backBtn.setImage(UIImage(named: "hx_back_green"), for: .normal)
        backBtn.setTitle(" 返回", for: .normal)

        self.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backBtn)

        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName:UIFont.systemFont(ofSize: 20.0), NSForegroundColorAttributeName:UIColor.white]
    }

    // MARK: - 重写方法
    // 这个方法 Swift 3 后不再是方法，而变成了属性
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
