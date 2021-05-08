//
//  HomePageViewController.swift
//  Wbt
//
//  Created by Hafizullah Samim on 5/3/21.
//

import UIKit

class HomePageViewController: UIViewController {

    let statusBackgroundView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Style.colorPrimaryLight
        return view
    }()
    
    lazy var customActionBarView:CustomActionBarView = {
        let view = CustomActionBarView()
        view.itemSelectedDelegation = self
        view.backgroundColor = Style.colorPrimaryLight
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleComps = ("Donate a Book!",Style.titleSmBoldFont,Style.colorTextPrimary)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Style.colorPrimaryDark
        self.view.addActionBarViewWithStatus(viewComps: (customActionBarView,Statics.actionBarHeight),statusBarColor:Style.colorPrimaryLight,marginFromTop:20)
        self.createMenuItems()
        // Do any additional setup after loading the view.
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override var preferredStatusBarStyle: UIStatusBarStyle{
        .lightContent
    }

}

extension HomePageViewController:ItemSelectedDelegation{
    func createMenuItems(){
        let menuItems:[MenuItem] = [
            MenuItem(title: "Hafizullah Samim".localized, id: 0, icon: #imageLiteral(resourceName: "notifications"),iconTintColor:Style.colorTextPrimary)
        ]
        self.customActionBarView.menuItems = menuItems
    }
    func onItemSelected(index: Int) {
        
    }
}
