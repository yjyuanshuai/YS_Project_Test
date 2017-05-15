//
//  YSNavigationItemSetting.swift
//  YSYBPatient_Test
//
//  Created by YJ on 17/5/12.
//  Copyright © 2017年 YJ. All rights reserved.
//

import UIKit

class YSNavigationItemSetting: NSObject {

    func setBackItem(viewController:UIViewController, title:String, image:UIImage?) -> () {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(image, for: .normal)
        backBtn.setTitle(title, for: .normal)

        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backBtn)
    }


}
