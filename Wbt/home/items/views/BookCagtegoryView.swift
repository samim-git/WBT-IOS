//
//  BookCagtegoryView.swift
//  Wbt
//
//  Created by Hafizullah Samim on 5/8/21.
//

import Foundation
import UIKit
import Shimmer
class BookCategoryView: UICollectionView,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate{
    var cellID = "categoryCellID"
    var suggistionCellId = "discountCell"
    var headerId = "headerReusableId"
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout2 = UICollectionViewFlowLayout()
        super.init(frame: frame, collectionViewLayout: layout2)
        self.delegate = self
        self.dataSource = self
        self.register(CategoryHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        self.register(SuggistionViewCell.self, forCellWithReuseIdentifier: self.suggistionCellId)
        self.register(CategoryCell.self, forCellWithReuseIdentifier: self.cellID)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.suggistionCellId, for: indexPath) as! SuggistionViewCell
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellID, for: indexPath) as! CategoryCell
//        cell.category = itemCategories[indexPath.item]
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width: self.frame.width, height: Statics.discountCellHeight)
        }
        if UIDevice.current.userInterfaceIdiom == .pad{
            return CGSize(width: self.frame.width/3, height: (self.frame.width/3)+Statics.categoryCellExtraHeight)
        }
        return CGSize(width: self.frame.width/2, height: (self.frame.width/2)+Statics.categoryCellExtraHeight)
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: self.headerId, for: indexPath) as! CategoryHeaderView
        if indexPath.section == 0{
            header.title = ""
        }else{
//            if bannerItems.count > 0{
//                header.title = "Categories"
//
//            }else{
//                header.title = ""
//            }
            header.title = "Category"
        }
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0{
            return CGSize(width: self.frame.width, height: 5)
        }
        return CGSize(width: self.frame.width, height: 65)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class CategoryHeaderView:UICollectionReusableView{
    var title:String = ""{
        didSet{
            self.titleLbl.text = self.title
        }
    }
    let titleLbl:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = Style.colorTextPrimary
        lbl.font = Style.normalBoldFont
        return lbl
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleLbl)
        titleLbl.addToFullBottom(to: self, padding: (0,10,0,10), height: 30, considerSafeArea: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CategoryCell: UICollectionViewCell {
    lazy var shimmerView:FBShimmeringView = {
        let view = FBShimmeringView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentView = self.containerViwePlaceHolder
        view.isShimmering = false
        view.shimmeringOpacity = 0.6
        view.shimmeringAnimationOpacity = 0.1
        view.isShimmering = false
        return view
    }()
    let containerViwe:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Style.colorPrimaryLight
        view.dropMdShadow()
        view.layer.cornerRadius = 6
        view.isHidden = false
        return view
    }()
    let imgView:UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.image = #imageLiteral(resourceName: "book")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = false
        return view
    }()
    let infoContainer:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let nameLbl:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Category Name"
        lbl.textColor = Style.colorTextPrimary
        lbl.font = Style.normalBoldFont
        lbl.textAlignment = .center
        return lbl
    }()
    let priceLbl:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "$345 - $2100"
        lbl.textColor = Style.colorTextPrimary
        lbl.font = Style.smallFont
        lbl.textAlignment = .center
        return lbl
    }()
    let lblContainer:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var bookmarkBtnContainer:UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.backgroundColor = Style.colorTextGray.withAlphaComponent(0.5)
        view.addTarget(self, action: #selector(bookMarkMe), for: .touchUpInside)
        return view
    }()
    let bookMarkIconView:UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = #imageLiteral(resourceName: "heart").withRenderingMode(.alwaysTemplate)
        view.contentMode = .scaleAspectFill
        view.tintColor = Style.colorPrimaryExtraLight
        view.isUserInteractionEnabled = false
        return view
    }()
    
    let containerViwePlaceHolder:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Style.colorPrimaryLight
        view.dropMdShadow()
        view.layer.cornerRadius = 6
        view.isHidden = false
        return view
    }()
    let imgViewPlaceHolder:UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        view.backgroundColor = Style.colorTextGray.withAlphaComponent(0.25)
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.isUserInteractionEnabled = false
        return view
    }()
    let infoContainerPlaceHolder:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let nameLblPlaceHolder:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = ""
        lbl.textColor = Style.colorPrimary.withAlphaComponent(0.3)
        lbl.font = Style.normalBoldFont
        lbl.backgroundColor = Style.colorPrimaryLight.withAlphaComponent(0.3)
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 2
        return lbl
    }()
    let priceLblPlaceHolder:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = ""
        lbl.backgroundColor = Style.colorPrimaryLight.withAlphaComponent(0.3)
        lbl.textColor = Style.colorTextGray.withAlphaComponent(0.3)
        lbl.font = Style.smallFont
        lbl.textAlignment = .center
        lbl.layer.cornerRadius = 2
        return lbl
    }()
    let lblContainerPlaceHolder:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.addSubview(shimmerView)
        self.addSubview(containerViwe)
//        self.addSubview(containerViwePlaceHolder)
        containerViwe.addTwoVerPortion(view1: imgView, view2: infoContainer, heightForView1: -1, padding: (5,5,5,5))
        infoContainer.addToVerCenter(view: lblContainer, height: 60, padding: (10,10))
        lblContainer.addChildsToVerticalStack(viewsComps: [(nameLbl,30,(0,0,0,0)),(priceLbl,30,(0,0,0,0))])
//
        containerViwe.addSubview(bookmarkBtnContainer)
        bookmarkBtnContainer.addSubview(bookMarkIconView)
//
//
//
//        containerViwePlaceHolder.addTwoVerPortion(view1: imgViewPlaceHolder, view2: infoContainerPlaceHolder, heightForView1: -1, padding: (5,5,5,5))
//        infoContainerPlaceHolder.addToVerCenter(view: lblContainerPlaceHolder, height: 60, padding: (10,10))
//        lblContainerPlaceHolder.addChildsToVerticalStack(viewsComps: [(nameLblPlaceHolder,30,(0,0,0,0)),(priceLblPlaceHolder,30,(6,15,0,15))])
//
        self.setupConstraint()
    }
    
    func setupConstraint(){
        
        containerViwe.addFullContaintAnchor(to: self, padding: (8,3,10,8))
        bookMarkIconView.addFullContaintAnchor(to: bookmarkBtnContainer,padding: (12,12,12,12))
        
        bookmarkBtnContainer.topAnchor.constraint(equalTo: imgView.topAnchor,constant: 10).isActive = true
        bookmarkBtnContainer.trailingAnchor.constraint(equalTo: imgView.trailingAnchor,constant: -10).isActive = true
        bookmarkBtnContainer.widthAnchor.constraint(equalToConstant: 50).isActive = true
        bookmarkBtnContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
//        containerViwePlaceHolder.addFullContaintAnchor(to: self, padding: (8,3,10,8))
//
//
//        shimmerView.addFullContaintAnchor(to: containerViwe,padding: (5,5,5,5))
    }
    
    @objc func bookMarkMe(){
//        if !self.category.isBookmarked{
//            self.bookMarkIconView.image = #imageLiteral(resourceName: "ic_loved").withRenderingMode(.alwaysTemplate)
//            self.bookMarkIconView.tintColor = Style.redColor
//            self.bookmarkBtnContainer.backgroundColor = Style.redLightColor.withAlphaComponent(0.4)
//        }else{
//            self.bookMarkIconView.image = #imageLiteral(resourceName: "ic_love").withRenderingMode(.alwaysTemplate)
//            self.bookMarkIconView.tintColor = Style.mainColorWhite
//            self.bookmarkBtnContainer.backgroundColor = Style.grayColor.withAlphaComponent(0.5)
//        }
//        self.category.isBookmarked = !self.category.isBookmarked
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SuggistionViewCell:UICollectionViewCell{

//    var bannerItems:[Item] = []{
//        didSet{
//            self.discounedCollectionView.discountedItems = self.bannerItems
//        }
//    }
    let containerViwe:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Style.colorPrimary
        view.dropMdShadow()
        view.layer.cornerRadius = 6
        return view
    }()

    var titleLbl:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "For You"
        lbl.textColor = Style.colorTextPrimary
        lbl.font = Style.normalBoldFont
        return lbl
    }()

    var discounedCollectionView:BookSuggistionView = {
        let view = BookSuggistionView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(containerViwe)
        containerViwe.addTwoVerPortion(view1: titleLbl, view2: discounedCollectionView, heightForView1: 30, padding: (10,6,6,6), viewSpacing: 5)
        self.setupConstraint()
    }

    func setupConstraint(){
        containerViwe.addFullContaintAnchor(to: self, padding: (15,3,10,8))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
