//
//  YSRegistVC.swift
//  YSYBPatient_Test
//
//  Created by YJ on 17/5/8.
//  Copyright © 2017年 YJ. All rights reserved.
//

import UIKit

class YSRegistOrForgetPassVC: YSRootVC {

    var currentType:Enum_LoginPushVCType = Enum_LoginPushVCType.pushToForget
    var account:String? = ""

    init(currentType:Enum_LoginPushVCType, account:String?) {
        self.currentType = currentType
        if account == nil {
            self.account = ""
        }
        else {
            self.account = account
        }
        super.init(nibName: nil, bundle: nil)
    }

    init(currentType:Enum_LoginPushVCType) {
        self.currentType = currentType
        self.account = ""
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (self.navigationController?.isNavigationBarHidden)! {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        self.createUIAndData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func createUIAndData() -> () {
        switch currentType {
        case .pushToForget:
            self.createForgetPassWordUI()
        case .pushToRegist:
            self.createRegistUI()
        }
    }

    func createForgetPassWordUI() -> () {
        self.title = "找回密码"
    }

    func createRegistUI() -> () {
        self.title = "注册"
    }
}
