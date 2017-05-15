//
//  YSTabBarController.swift
//  YSYBPatient_Test
//
//  Created by YJ on 17/5/5.
//  Copyright © 2017年 YJ. All rights reserved.
//

import UIKit

class YSTabBarController: UITabBarController {
    //
    var firstPageNav:UINavigationController = UINavigationController()
    var healthFileNav:UINavigationController = UINavigationController()
    var noticeNav:UINavigationController = UINavigationController()
    var healthEduNav:UINavigationController = UINavigationController()
    var meNav:UINavigationController = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.createAllNavs()
        
        self.selectedIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // 创建 Navs
    func createAllNavs() -> () {
        // 首页
        let firstPageVC:YSFirstPageVC = YSFirstPageVC()

        var f_unselected = UIImage(named: "tab_firstpage_selected")
        f_unselected = f_unselected?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

        firstPageVC.tabBarItem = UITabBarItem(title:"首页", image:UIImage(named:"tab_firstpage_unselected"), selectedImage: f_unselected)
        firstPageNav = UINavigationController(rootViewController:firstPageVC)

        // 健康档案
        let healthFileVC:YSHealthFileVC = YSHealthFileVC()

        var hf_unselected = UIImage(named:"tab_healthfile_selected")
        hf_unselected = hf_unselected?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

        healthFileVC.tabBarItem = UITabBarItem(title:"健康档案", image:UIImage(named:"tab_healthfile_unselected"), selectedImage: hf_unselected)
        healthFileNav = UINavigationController(rootViewController:healthFileVC)

        // 消息
        let noticeVC:YSNoticeVC = YSNoticeVC()

        var n_unselected = UIImage(named:"tab_notice_selected")
        n_unselected = n_unselected?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

        noticeVC.tabBarItem = UITabBarItem(title:"消息", image:UIImage(named:"tab_notice_unselected"), selectedImage: n_unselected)
        noticeNav = UINavigationController(rootViewController:noticeVC)

        // 健康教育
        let healthEduVC:YSHealthEduVC = YSHealthEduVC()

        var he_unselected = UIImage(named:"tab_healthedu_selected")
        he_unselected = he_unselected?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

        healthEduVC.tabBarItem = UITabBarItem(title:"健康教育", image:UIImage(named:"tab_healthedu_unselected"), selectedImage: he_unselected)
        healthEduNav = UINavigationController(rootViewController:healthEduVC)

        // 我
        let meVC:YSMeVC = YSMeVC()

        var m_unselected = UIImage(named:"tab_me_selected")
        m_unselected = m_unselected?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

        meVC.tabBarItem = UITabBarItem(title:"我", image:UIImage(named:"tab_me_unselected"), selectedImage: m_unselected)
        meNav = UINavigationController(rootViewController:meVC)
        
        self.viewControllers = [firstPageNav, healthFileNav, noticeNav, healthEduNav, meNav]

        // 去掉分割线
//        self.tabBar.clipsToBounds = true

        self.tabBar.tintColor = kMainColor
    }
}
