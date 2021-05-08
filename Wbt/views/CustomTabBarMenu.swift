//
//  CustomTabBarMenu.swift
//  Wbt
//
//  Created by Hafizullah Samim on 5/3/21.
//

import UIKit

class CustomTabBarMenu:UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var itemSelectedDelegation:ItemSelectedDelegation!
    var menuItems:[MenuItem] = []{
        didSet{
            self.menuview.reloadData()
        }
    }
    let cellId = "cellIdForEachCell"
    var defaultIndex:Int = 0{
        didSet{
            self.menuview.selectItem(at: IndexPath(item: self.defaultIndex, section: 0), animated: true, scrollPosition: .top)
        }
    }
    let containerView:UIView = {
        let view =  UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var menuview:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.dataSource = self
        view.selectItem(at: IndexPath(item: self.defaultIndex, section: 0), animated: true, scrollPosition: .top)
        view.backgroundColor = Style.colorPrimary
        view.register(TabItemCell.self, forCellWithReuseIdentifier: self.cellId)
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerView)
        containerView.addSubview(menuview)
        containerView.addFullContaintAnchor(to: self)
        menuview.addFullContaintAnchor(to: containerView, padding: (1.5,0,0,0))
        
    }
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 4
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellId, for: indexPath) as! TabItemCell
//        return cell
//    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! TabItemCell
        cell.item = self.menuItems[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.itemSelectedDelegation != nil{
            self.itemSelectedDelegation.onItemSelected!(index: self.menuItems[indexPath.item].id!)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width/CGFloat(self.menuItems.count), height: self.frame.height - 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
private class TabItemCell:UICollectionViewCell{
    override var isSelected: Bool{
        didSet{
            if isSelected{
                if let item = self.item{
                    iconView.tintColor = item.iconActiveTintColor
                    menuLbl.textColor = item.textActiveColor
                }
                
            }else{
                if let item = self.item{
                    iconView.tintColor = item.iconTintColor
                    menuLbl.textColor = item.textColor
                }
            }
        }
    }
    var item:MenuItem! = nil{
        didSet{
            if let item = item{
                if let title = item.title{
                    self.menuLbl.text = title
                }
                if let img = item.icon{
                    self.iconView.image = img.withRenderingMode(.alwaysTemplate)
                }
                self.iconView.tintColor = self.item.iconTintColor
                if item.isSelected{
                    iconView.tintColor = item.iconActiveTintColor
                    menuLbl.textColor = item.textActiveColor
                }else{
                    iconView.tintColor = item.iconTintColor
                    menuLbl.textColor = item.textColor
                }
            }
        }
    }
    let containrView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let iconView:UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = Style.colorPrimaryLight
        view.contentMode = .scaleToFill
        return view
    }()
    let menuLbl:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = Style.colorPrimaryLight
//        lbl.font = Style.colorTet
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(containrView)
        containrView.addFullContaintAnchor(to: self)
        containrView.makeViewLabaled(view: iconView, lblView: menuLbl, direction: .top, padding: (5,5,5,5), lblPadding: 3,lblHeight:20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

