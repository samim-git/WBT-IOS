//
//  CustomActionBarView.swift
//  Wbt
//
//  Created by Hafizullah Samim on 5/3/21.
//

import Foundation
import UIKit
class CustomActionBarView:UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    var itemSelectedDelegation:ItemSelectedDelegation!
    var titleComps:(title:String,font:UIFont,titleColor:UIColor) = ("",Style.titleNormalFont,Style.colorTextPrimary){
        didSet{
            self.titleView.text = self.titleComps.title
            self.titleView.font = self.titleComps.font
            self.titleView.textColor = self.titleComps.titleColor
        }
    }
    var menuItems:[MenuItem] = []{
        didSet{
            self.menuview.reloadData()
        }
    }
    var direction:Direction = .trailing{
        didSet{
            switch direction {
            case .leading:
                self.makeLeading()
                break
            case .left:
                self.makeLeft()
                break
            case .right:
                self.makeRight()
                break
            default:
                self.makeTrailing()
            }
        }
    }
    let cellId = "cellIdForEachCell"
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
        view.backgroundColor = UIColor.clear
        view.register(ActionBarCell.self, forCellWithReuseIdentifier: self.cellId)
        return view
    }()
    
    var titleView:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = Style.normalBoldFont
        lbl.backgroundColor = UIColor.clear
        return lbl
    }()
    let backBtn:UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor.clear
        btn.isHidden = true
        return btn
    }()
    var backBtnLeadingConstraint:NSLayoutConstraint!
    var backBtnTrailingConstraint:NSLayoutConstraint!
    var backBtnLeftConstraint:NSLayoutConstraint!
    var backBtnRightConstraint:NSLayoutConstraint!
    var backBtnWidthConstraint:NSLayoutConstraint!
    var backBtnWidthConstraintConstatn:NSLayoutConstraint!
    
    var titleViewLeadingConstraint:NSLayoutConstraint!
    var titleViewTrailingConstraint:NSLayoutConstraint!
    var titleViewLeftConstraint:NSLayoutConstraint!
    var titleViewRightConstraint:NSLayoutConstraint!
    var titleViewCenterXConstraint:NSLayoutConstraint!
    
    var menuViewLeadingConstraintForLeading:NSLayoutConstraint!
    var menuViewTrailingConstraintForLeading:NSLayoutConstraint!
    var menuViewLeadingConstraintForTrailing:NSLayoutConstraint!
    var menuViewTrailingConstraintForTrailing:NSLayoutConstraint!
    var menuViewLeftConstraint:NSLayoutConstraint!
    var menuViewRightConstraint:NSLayoutConstraint!
    var menuViewWidthConstraint:NSLayoutConstraint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(containerView)
        containerView.addSubview(menuview)
        containerView.addSubview(titleView)
        containerView.addSubview(backBtn)
        containerView.addFullContaintAnchor(to: self)
        
        //default constraint....
        self.backBtnLeadingConstraint = backBtn.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 10)
        self.backBtnLeadingConstraint.isActive = true
        backBtn.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        backBtn.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
        self.backBtnWidthConstraintConstatn = backBtn.widthAnchor.constraint(equalToConstant: 0)
        self.backBtnWidthConstraintConstatn.isActive = true
        
        self.titleViewLeadingConstraint = titleView.leadingAnchor.constraint(equalTo: backBtn.trailingAnchor,constant: 10)
        self.titleViewLeadingConstraint.isActive = true
        self.titleView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor).isActive = true
        
        self.menuViewLeadingConstraintForTrailing = menuview.leadingAnchor.constraint(equalTo: titleView.trailingAnchor,constant: 10)
        self.menuViewLeadingConstraintForTrailing.isActive = true
        self.menuViewTrailingConstraintForTrailing = menuview.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -10)
        self.menuViewTrailingConstraintForTrailing.isActive = true
        menuview.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
        menuview.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
        
        
        //for theming----
        
        menuview.transform = CGAffineTransform.init(rotationAngle: (-(CGFloat)(Double.pi)))
        
        
        
        
//
        
        
//        menuview.addFullContaintAnchor(to: containerView, padding: (0,0,0,0))
        
    }
    private func makeTrailing(){
//        self.backBtnLeadingConstraint.isActive = true
//        self.backBtnWidthConstraint.isActive = true
//        self.titleViewLeadingConstraint.isActive = true
//        self.menuViewLeadingConstraintForLeading.isActive = true
//        self.menuViewTrailingConstraintForLeading.isActive = true
    }
    private func makeLeading(){
        //deactive default constraint
        self.backBtnLeadingConstraint.isActive = false
        self.titleViewLeadingConstraint.isActive = false
        self.menuViewLeadingConstraintForTrailing.isActive = false
        self.menuViewTrailingConstraintForTrailing.isActive = false
        
        self.backBtnTrailingConstraint = backBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -10)
        self.backBtnTrailingConstraint.isActive = true
        
        self.titleViewTrailingConstraint = titleView.trailingAnchor.constraint(equalTo: backBtn.leadingAnchor,constant: -10)
        self.titleViewTrailingConstraint.isActive = true
        
        
        self.menuViewLeadingConstraintForLeading = menuview.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 10)
        self.menuViewLeadingConstraintForLeading.isActive = true
        self.menuViewTrailingConstraintForLeading = menuview.trailingAnchor.constraint(equalTo: titleView.leadingAnchor,constant: -10)
        self.menuViewTrailingConstraintForLeading.isActive = true
        
        menuview.transform = CGAffineTransform.init(rotationAngle: 0)
        self.menuview.reloadData()
    }
    
    private func makeLeft(){
        self.backBtnLeadingConstraint.isActive = false
        self.titleViewLeadingConstraint.isActive = false
        self.menuViewLeadingConstraintForTrailing.isActive = false
        self.menuViewTrailingConstraintForTrailing.isActive = false
        
        self.backBtnRightConstraint = backBtn.rightAnchor.constraint(equalTo: containerView.rightAnchor,constant: -10)
        self.backBtnRightConstraint.isActive = true
        
        self.titleViewRightConstraint = titleView.rightAnchor.constraint(equalTo: backBtn.leftAnchor,constant: -10)
        self.titleViewRightConstraint.isActive = true
        
        self.menuViewLeftConstraint = menuview.leftAnchor.constraint(equalTo: containerView.leftAnchor,constant: 10)
        self.menuViewLeftConstraint.isActive = true
        self.menuViewRightConstraint = menuview.rightAnchor.constraint(equalTo: titleView.leftAnchor,constant: -10)
        self.menuViewRightConstraint.isActive = true
        
        menuview.transform = CGAffineTransform.init(rotationAngle: 0)
        self.menuview.reloadData()
        
    }
    
    private func makeRight(){
        self.backBtnLeadingConstraint.isActive = false
        self.titleViewLeadingConstraint.isActive = false
        self.menuViewLeadingConstraintForTrailing.isActive = false
        self.menuViewTrailingConstraintForTrailing.isActive = false
        
        
        self.backBtnLeftConstraint = backBtn.leftAnchor.constraint(equalTo: containerView.leftAnchor,constant: 10)
        self.backBtnLeftConstraint.isActive = true
        
        self.titleViewLeftConstraint = titleView.leftAnchor.constraint(equalTo: backBtn.rightAnchor,constant: 10)
        self.titleViewLeftConstraint.isActive = true
        
        self.menuViewLeftConstraint = menuview.leftAnchor.constraint(equalTo: titleView.rightAnchor,constant: 10)
        self.menuViewLeftConstraint.isActive = true
        self.menuViewRightConstraint = menuview.rightAnchor.constraint(equalTo: containerView.rightAnchor,constant: -10)
        self.menuViewRightConstraint.isActive = true
    }
    func moveTitleToCenter(){
        self.titleViewLeadingConstraint.isActive = false
        
        self.titleViewCenterXConstraint = titleView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor)
        self.titleViewCenterXConstraint.isActive = true
        
    }
    
    func showBackBtn(withIcon:UIImage){
        self.backBtnWidthConstraintConstatn.isActive = false
        
        self.backBtnWidthConstraint = backBtn.widthAnchor.constraint(equalTo: self.backBtn.heightAnchor)
        self.backBtnWidthConstraint.isActive = true
        self.backBtn.isHidden = false
        self.backBtn.setImage(withIcon, for: .normal)
    }
    
    func showHint(_ withColor:UIColor = UIColor.red,_ toItem:Int,_ shouldSHow:Bool = true){
        self.menuItems[toItem].hintColor = withColor
        self.menuItems[toItem].showHint = shouldSHow
        self.menuview.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuItems.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellId, for: indexPath) as! ActionBarCell
        cell.item = self.menuItems[indexPath.item]
        if self.direction == .leading || self.direction == .left{
            cell.transform = CGAffineTransform(rotationAngle: 0)
        }else{
            cell.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.itemSelectedDelegation != nil{
            self.itemSelectedDelegation.onItemSelected!(index: self.menuItems[indexPath.item].id!)
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
private class ActionBarCell:UICollectionViewCell{
//    override var isSelected: Bool{
//        didSet{
//            if isSelected{
//                iconView.tintColor = Style.mainColor
//                menuLbl.textColor = Style.mainColor
//            }else{
//                iconView.tintColor = Style.grayColor
//                menuLbl.textColor = Style.grayColor
//            }
//        }
//    }
    var item:MenuItem! = nil{
        didSet{
            if let item = item{
                if let title = item.title{
                    self.menuLbl.text = title
                }
                if let img = item.icon{
                    self.iconView.image = img.withRenderingMode(.alwaysTemplate)
                }
                if item.iconTintColor != UIColor.clear{
                    self.iconView.tintColor = item.iconTintColor
                }else{
                    //
                }
                self.menuLbl.textColor = item.textColor
                if item.showHint{
                    self.hintView.isHidden = false
                    self.hintView.backgroundColor = item.hintColor
                }else{
                    self.hintView.isHidden = true
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
        view.tintColor = Style.colorTextGray
        view.contentMode = .scaleToFill
        return view
    }()
    let menuLbl:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        lbl.textColor = Style.colorTextGray
        lbl.font = Style.smallFont
        return lbl
    }()
    let hintView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(containrView)
        containrView.addFullContaintAnchor(to: self)
        containrView.makeViewLabaled(view: iconView, lblView: menuLbl, direction: .top, padding: (10,10,10,10), lblPadding: 0,lblHeight:0)
        
        contentView.addSubview(hintView)
        hintView.heightAnchor.constraint(equalToConstant: 10).isActive = true
        hintView.widthAnchor.constraint(equalToConstant: 10).isActive = true
        hintView.layer.cornerRadius = 5
        
        
        hintView.centerXAnchor.constraint(equalTo: iconView.trailingAnchor).isActive = true
        hintView.centerYAnchor.constraint(equalTo: iconView.topAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
