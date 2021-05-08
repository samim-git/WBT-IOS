//
//  HomeViewController.swift
//  Wbt
//
//  Created by Hafizullah Samim on 5/2/21.
//

import UIKit

class HomeViewController: UITabBarController, UITabBarControllerDelegate {

    
    lazy var customTabBarItem:CustomTabBarMenu = {
        let view = CustomTabBarMenu()
        view.itemSelectedDelegation = self
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Style.colorPrimaryLight
        view.dropTopSmallShadow()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Style.colorPrimaryExtraDark
        
        self.view.addSubview(customTabBarItem)
        customTabBarItem.addToFullBottom(to: self.view, height: Statics.tabBarHeight,considerSafeArea:true)
        self.setupTapItems()
        self.createMenuItems()

        // Do any additional setup after loading the view.
    }
    
    func setupTapItems(){
        let itemCategoryVc = HomePageViewController()
        let itemCategoryVc2 = HomePageViewController()
        let itemCategoryVc3 = MeViewController()
        self.viewControllers = [itemCategoryVc,itemCategoryVc2,itemCategoryVc3]
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }
}


extension HomeViewController:ItemSelectedDelegation{
    func onItemSelected(index: Int) {
        self.selectedIndex = index
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
    func createMenuItems(){
        let menuItems:[MenuItem] = [
            MenuItem(title: "tab1".localized, id: 0, icon: #imageLiteral(resourceName: "home"),isSelected:true),
            MenuItem(title: "tab2".localized, id: 1, icon: #imageLiteral(resourceName: "heart")),
            MenuItem(title: "tab3".localized, id: 2, icon: #imageLiteral(resourceName: "user")),
        ]
        self.customTabBarItem.menuItems = menuItems
        self.customTabBarItem.defaultIndex = 0
    }
    
    
    
    
    
    func testAuth(){
        
    }
}
