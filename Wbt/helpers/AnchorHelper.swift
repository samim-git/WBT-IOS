//
//  AnchorHelper.swift
//  Wbt
//
//  Created by Hafizullah Samim on 5/3/21.
//

import Foundation
import UIKit
extension UIView{
    func addFullContaintAnchor(to:UIView,padding:(top:CGFloat,leading:CGFloat,bottom:CGFloat,trailing:CGFloat) = (0,0,0,0),isRtlNeeded:Bool = true){
        self.topAnchor.constraint(equalTo: to.topAnchor,constant: padding.top).isActive = true
        self.bottomAnchor.constraint(equalTo: to.bottomAnchor,constant: -padding.bottom).isActive = true
        if isRtlNeeded{
            self.leadingAnchor.constraint(equalTo: to.leadingAnchor,constant: padding.leading).isActive = true
            self.trailingAnchor.constraint(equalTo: to.trailingAnchor,constant: -padding.trailing).isActive = true
        }else{
            self.leftAnchor.constraint(equalTo: to.leftAnchor,constant: padding.leading).isActive = true
            self.rightAnchor.constraint(equalTo: to.rightAnchor,constant: -padding.trailing).isActive = true
        }
    }
    
    func addToFullBottom(to:UIView,padding:(top:CGFloat,leading:CGFloat,bottom:CGFloat,trailing:CGFloat) = (0,0,0,0),height:CGFloat = 0,isRtlNeeded:Bool = true,considerSafeArea:Bool = true,statusBackColor:UIColor = Style.colorPrimary){
        if considerSafeArea{
            let statusBackgroundView:UIView = {
                let view = UIView()
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = statusBackColor
                return view
            }()
            to.addSubview(statusBackgroundView)
            self.bottomAnchor.constraint(equalTo: to.safeAreaLayoutGuide.bottomAnchor,constant: -padding.bottom).isActive = true
            statusBackgroundView.leadingAnchor.constraint(equalTo: to.leadingAnchor).isActive = true
            statusBackgroundView.trailingAnchor.constraint(equalTo: to.trailingAnchor).isActive = true
            statusBackgroundView.bottomAnchor.constraint(equalTo: to.bottomAnchor).isActive = true
            statusBackgroundView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
        else{
            self.bottomAnchor.constraint(equalTo: to.bottomAnchor,constant: -padding.bottom).isActive = true
        }
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        if isRtlNeeded{
            self.leadingAnchor.constraint(equalTo: to.leadingAnchor,constant: padding.leading).isActive = true
            self.trailingAnchor.constraint(equalTo: to.trailingAnchor,constant: -padding.trailing).isActive = true
        }else{
            self.leftAnchor.constraint(equalTo: to.leftAnchor,constant: padding.leading).isActive = true
            self.rightAnchor.constraint(equalTo: to.rightAnchor,constant: -padding.trailing).isActive = true
        }
    }
    
    func addToFullTop(to:UIView,padding:(top:CGFloat,leading:CGFloat,bottom:CGFloat,trailing:CGFloat) = (0,0,0,0),height:CGFloat = 0,isRtlNeeded:Bool = true){
        
        self.topAnchor.constraint(equalTo: to.topAnchor,constant: padding.top).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        if isRtlNeeded{
            self.leadingAnchor.constraint(equalTo: to.leadingAnchor,constant: padding.leading).isActive = true
            self.trailingAnchor.constraint(equalTo: to.trailingAnchor,constant: -padding.trailing).isActive = true
        }else{
            self.leftAnchor.constraint(equalTo: to.leftAnchor,constant: padding.leading).isActive = true
            self.rightAnchor.constraint(equalTo: to.rightAnchor,constant: -padding.trailing).isActive = true
        }
    }
    
    
    func addToCenterOf(to:UIView,height:CGFloat,width:CGFloat,isCircle:Bool = false){
        self.centerXAnchor.constraint(equalTo: to.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: to.centerYAnchor).isActive = true
        self.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.widthAnchor.constraint(equalToConstant: width).isActive = true
        if isCircle{
            self.layer.cornerRadius = height/2
        }
    }
    
    func addToMiddleOfToViews(firstView:UIView,secondView:UIView,superView:UIView,isVer:Bool = true,isLtrNeeded:Bool = true,padding:(start:CGFloat,end:CGFloat) = (0,0)){
        let middView:UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        
        superview?.addSubview(middView)
        if isVer{
            middView.topAnchor.constraint(equalTo: firstView.bottomAnchor,constant: padding.start).isActive = true
            middView.bottomAnchor.constraint(equalTo: secondView.topAnchor,constant: padding.end).isActive = true
            self.centerYAnchor.constraint(equalTo: middView.centerYAnchor).isActive = true
        }else{
            if isLtrNeeded{
                middView.leadingAnchor.constraint(equalTo: firstView.trailingAnchor,constant: padding.start).isActive = true
                middView.trailingAnchor.constraint(equalTo: secondView.leadingAnchor,constant: padding.end).isActive = true
                self.centerXAnchor.constraint(equalTo: middView.centerXAnchor).isActive = true
            }else{
                middView.leftAnchor.constraint(equalTo: firstView.leftAnchor,constant: padding.start).isActive = true
                middView.rightAnchor.constraint(equalTo: secondView.rightAnchor,constant: padding.end).isActive = true
                self.centerXAnchor.constraint(equalTo: middView.centerXAnchor).isActive = true
            }
        }
    }
    
    func addChildsToVerticalStack(viewsComps:[(view:UIView,height:CGFloat,padding:(top:CGFloat,leading:CGFloat,bottom:CGFloat,trailng:CGFloat))],isRtlNeeded:Bool = true){
        var preView:UIView = viewsComps[0].view
        var i:Int = 0
        for viewCom in viewsComps{
            self.addSubview(viewCom.view)
            if i == 0{
                viewCom.view.topAnchor.constraint(equalTo: self.topAnchor,constant:viewCom.padding.top ).isActive = true
            }else{
                viewCom.view.topAnchor.constraint(equalTo: preView.bottomAnchor,constant: viewCom.padding.top).isActive = true
            }
            
            viewCom.view.heightAnchor.constraint(equalToConstant: viewCom.height).isActive = true
            if isRtlNeeded{
                viewCom.view.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: viewCom.padding.leading).isActive = true
                viewCom.view.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -viewCom.padding.trailng).isActive = true
            }else{
                viewCom.view.leftAnchor.constraint(equalTo: self.leftAnchor,constant: viewCom.padding.leading).isActive = true
                viewCom.view.rightAnchor.constraint(equalTo: self.rightAnchor,constant: viewCom.padding.trailng).isActive = true
            }
            preView = viewCom.view
            i += 1
        }
    }
    
    
    func makeViewLabaled(view:UIView,lblView:UIView,direction:Direction = .top,padding:(top:CGFloat,leading:CGFloat,bottom:CGFloat,trailing:CGFloat) = (0,0,0,0), lblPadding:CGFloat = 0,lblHeight:CGFloat = 0){
        addSubview(view)
        addSubview(lblView)
        switch direction {
        case .leading:

            view.topAnchor.constraint(equalTo: topAnchor,constant: padding.top).isActive = true
            view.leadingAnchor.constraint(equalTo: leadingAnchor,constant: padding.leading).isActive = true
            view.bottomAnchor.constraint(equalTo: lblView.topAnchor,constant: -padding.bottom).isActive = true
            view.widthAnchor.constraint(equalTo: view.heightAnchor).isActive = true
            
            lblView.leadingAnchor.constraint(equalTo: view.trailingAnchor,constant: lblPadding).isActive = true
            lblView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -padding.trailing).isActive = true
            lblView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: 0).isActive = true
            if lblHeight > 0{
                lblView.heightAnchor.constraint(equalToConstant: lblHeight).isActive = true
            }
            
            break
        case .trailing:
            view.topAnchor.constraint(equalTo: topAnchor,constant: padding.top).isActive = true
            view.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -padding.trailing).isActive = true
            view.bottomAnchor.constraint(equalTo: lblView.topAnchor,constant: -padding.bottom).isActive = true
            view.widthAnchor.constraint(equalTo: view.heightAnchor).isActive = true
            
            lblView.trailingAnchor.constraint(equalTo: view.leadingAnchor,constant: -lblPadding).isActive = true
            lblView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: padding.leading).isActive = true
            lblView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: 0).isActive = true
            if lblHeight > 0{
                lblView.heightAnchor.constraint(equalToConstant: lblHeight).isActive = true
            }
            break
        case.bottom:
            lblView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: padding.leading).isActive = true
            lblView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -padding.trailing).isActive = true
            lblView.topAnchor.constraint(equalTo: topAnchor,constant: padding.top).isActive = true
            if lblHeight > 0{
                lblView.heightAnchor.constraint(equalToConstant: lblHeight).isActive = true
            }
            
            view.topAnchor.constraint(equalTo: lblView.bottomAnchor,constant: lblPadding).isActive = true
            view.centerXAnchor.constraint(equalTo: centerXAnchor,constant: 0).isActive = true
            view.bottomAnchor.constraint(equalTo:bottomAnchor,constant: -padding.bottom).isActive = true
            view.widthAnchor.constraint(equalTo: view.heightAnchor).isActive = true
            break
        default:
            //
            lblView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: padding.leading).isActive = true
            lblView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -padding.trailing).isActive = true
            lblView.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -padding.bottom).isActive = true
            if lblHeight > 0{
                lblView.heightAnchor.constraint(equalToConstant: lblHeight).isActive = true
            }
            
            view.topAnchor.constraint(equalTo: topAnchor,constant: padding.top).isActive = true
            view.centerXAnchor.constraint(equalTo: centerXAnchor,constant: 0).isActive = true
            view.bottomAnchor.constraint(equalTo: lblView.topAnchor,constant: -lblPadding).isActive = true
            view.widthAnchor.constraint(equalTo: view.heightAnchor).isActive = true
            
        }
    }
    
    
    func addActionBarViewWithStatus(viewComps:(actionBarView:UIView,actionBarHeight:CGFloat),statusBarColor:UIColor = Style.colorPrimaryLight, isRtlNeeded:Bool = true, marginFromTop:CGFloat = 0){
        let statusBackgroundView:UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = statusBarColor
            return view
        }()
        self.addSubview(statusBackgroundView)
        self.addSubview(viewComps.actionBarView)
        
        if isRtlNeeded{
            viewComps.actionBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            viewComps.actionBarView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }else{
            viewComps.actionBarView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
            viewComps.actionBarView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        }
        
        viewComps.actionBarView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: marginFromTop).isActive = true
        viewComps.actionBarView.heightAnchor.constraint(equalToConstant: viewComps.actionBarHeight).isActive = true
        
        statusBackgroundView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        statusBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        statusBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        statusBackgroundView.bottomAnchor.constraint(equalTo: viewComps.actionBarView.topAnchor).isActive = true
        statusBackgroundView.backgroundColor = statusBarColor
    }
    
    
    func addTwoVerPortion(view1:UIView,view2:UIView,heightForView1:CGFloat = 0,heightForView2:CGFloat = 0,isRtlNeeded:Bool = true,padding:(top:CGFloat,leading:CGFloat,bottom:CGFloat,trailing:CGFloat) = (0,0,0,0),viewSpacing:CGFloat = 0){
        self.addSubview(view1)
        self.addSubview(view2)
        
        view1.topAnchor.constraint(equalTo: topAnchor,constant: padding.top).isActive = true
        view2.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -padding.bottom).isActive = true
        if isRtlNeeded{
            view1.leadingAnchor.constraint(equalTo: leadingAnchor,constant: padding.leading).isActive = true
            view1.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -padding.trailing).isActive = true
            
            view2.leadingAnchor.constraint(equalTo: leadingAnchor,constant: padding.leading).isActive = true
            view2.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -padding.trailing).isActive = true
        }else{
            view1.leftAnchor.constraint(equalTo: leftAnchor,constant: padding.leading).isActive = true
            view1.rightAnchor.constraint(equalTo: rightAnchor,constant: -padding.trailing).isActive = true
            
            view2.leftAnchor.constraint(equalTo: leftAnchor,constant: padding.leading).isActive = true
            view2.rightAnchor.constraint(equalTo: rightAnchor,constant: -padding.trailing).isActive = true
        }
        if heightForView1 == 0 && heightForView2 == 0{
            //equal size
            view1.bottomAnchor.constraint(equalTo: centerYAnchor,constant: -viewSpacing/2).isActive = true
            view2.topAnchor.constraint(equalTo: centerYAnchor,constant: viewSpacing/2).isActive = true
        }else if heightForView1 != 0{
            if heightForView1 == -1{
                view1.heightAnchor.constraint(equalTo: view1.widthAnchor,constant: -viewSpacing).isActive = true
            }else{
                view1.heightAnchor.constraint(equalToConstant: heightForView1).isActive = true
            }
            view2.topAnchor.constraint(equalTo: view1.bottomAnchor,constant: viewSpacing).isActive = true
        }else{
            if heightForView2 == -1{
                view2.heightAnchor.constraint(equalTo: view2.widthAnchor,constant: -viewSpacing).isActive = true
            }else{
                view2.heightAnchor.constraint(equalToConstant: heightForView2).isActive = true
            }
            view1.bottomAnchor.constraint(equalTo: view2.topAnchor,constant: -viewSpacing).isActive = true
        }
        
    }
    
    func addToVerCenter(view:UIView,height:CGFloat = 0,isRtlNeeded:Bool = true,padding:(leading:CGFloat,trailing:CGFloat) = (0,0)){
        self.addSubview(view)
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        view.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        if isRtlNeeded{
            view.leadingAnchor.constraint(equalTo: leadingAnchor,constant: padding.leading).isActive = true
            view.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -padding.trailing).isActive = true
        }else{
            view.leftAnchor.constraint(equalTo: leftAnchor,constant: padding.leading).isActive = true
            view.rightAnchor.constraint(equalTo: rightAnchor,constant: -padding.trailing).isActive = true
        }
    }
    
    
}
