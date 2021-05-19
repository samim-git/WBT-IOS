//
//  SuggistionView.swift
//  Wbt
//
//  Created by Hafizullah Samim on 5/11/21.
//

import UIKit
class BookSuggistionView:UICollectionView,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate{
    var discountCellId = "discountCell"
//    var discountedItems:[Item] = []{
//        didSet{
//            self.getRandomColor()
//            self.reloadData()
//        }
//    }
    var bgColors:[UIColor] = []
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout2 = UICollectionViewFlowLayout()
        layout2.scrollDirection = .horizontal
        super.init(frame: frame, collectionViewLayout: layout2)
        self.delegate = self
        self.dataSource = self
        self.register(ForMeDiscountItemCell.self, forCellWithReuseIdentifier: self.discountCellId)
        self.backgroundColor = UIColor.clear
        
        self.getRandomColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
//        self.discountedItems.count
        9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.discountCellId, for: indexPath) as! ForMeDiscountItemCell
        print("this is len: \(bgColors.count)")
        cell.backroundOverlayColor = bgColors[indexPath.item]
//        cell.item = discountedItems[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("in bunnnnner: \(self.frame.size)")
        print("in bunnnnner: \(self.frame)")
        return CGSize(width: self.frame.height * 1.5, height: self.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    let colors:[UIColor] = [
        UIColor(r:133, g:133, b:133).withAlphaComponent(0.7),
        UIColor(r:179, g:156, b:87).withAlphaComponent(0.7),
        UIColor(r:61, g:126, b:161).withAlphaComponent(0.7),
        UIColor(r:143, g:11, b:57).withAlphaComponent(0.7),
        UIColor(r:0, g:25, b:99).withAlphaComponent(0.7),
        UIColor(r:184, g:110, b:0).withAlphaComponent(0.7),
        UIColor.black.withAlphaComponent(0.7)
    ]
    func getRandomColor(){
        
        
        for _ in 0..<10{
            self.bgColors.append(colors.randomElement()!)
        
        }
    }
}
class ForMeDiscountItemCell:UICollectionViewCell{
    var backroundOverlayColor:UIColor!{
        didSet{
            self.layerContainer.backgroundColor = self.backroundOverlayColor
        }
    }
//    var item:Item = Item(){
//
//        didSet{
//            print("items-: \(item)")
//            if self.item.isFooterObject{
////                self.nameLbl.isHidden = true
////                self.imgView.isHidden = true
////                self.priceLbl.isHidden = true
////                self.backroundOverlayColor = UIColor.white
//            }else{
//                if let name = item.name{
//                    self.nameLbl.text = name
//                }
//                if let img = item.imgs{
//                    print("immmmmmmg: \(img)")
//                    if img.count > 0{
//                        self.imgView.setImageFromUrl(urlStr: "products/"+img[0], placeholder: #imageLiteral(resourceName: "ic_basket"))
//                    }
//                }
//                if let discountPercentage = item.discountPercentage{
//                    self.priceLbl.text = "\(discountPercentage) Off"
//                }
//                if let discountedPrice = item.discountedPrice{
//                    self.discountedPriceLbl.text = "\(discountedPrice) AFN"
//                }
//            }
//        }
//    }
    let containerViwe:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Style.colorPrimaryLight
        view.dropMdShadow()
        view.layer.cornerRadius = 6
        return view
    }()
    let imgView:UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.image = #imageLiteral(resourceName: "book")
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
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
        lbl.font = Style.titleBoldFont
        return lbl
    }()
    let priceLbl:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = Style.colorTextPrimary
        lbl.font = Style.bigBoldFont
        return lbl
    }()
    let discountedPriceLbl:UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = Style.colorTextPrimary
        lbl.font = Style.normalBoldFont
        return lbl
    }()
    let layerContainer:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        return view
    }()
    let lblContainer:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(containerViwe)
        containerViwe.addSubview(imgView)
        containerViwe.addSubview(layerContainer)
        
//        containerViwe.addTwoVerPortion(view1: imgView, view2: infoContainer, heightForView1: -1, padding: (5,5,5,5),viewSpacing: 10)
        containerViwe.addToVerCenter(view: lblContainer, height: 115, padding: (10,10))
        lblContainer.addChildsToVerticalStack(viewsComps: [(nameLbl,55,(0,0,0,0)),(priceLbl,30,(0,0,0,0)),(discountedPriceLbl,30,(0,0,0,0))])
        self.setupConstraint()
    }
    
    func setupConstraint(){
        containerViwe.addFullContaintAnchor(to: self, padding: (2,3,2,3))
        imgView.addFullContaintAnchor(to: containerViwe)
        layerContainer.addFullContaintAnchor(to: containerViwe)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
