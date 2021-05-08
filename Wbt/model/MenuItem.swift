//
//  MenuItem.swift
//  Wbt
//
//  Created by Hafizullah Samim on 5/3/21.
//

import UIKit
struct MenuItem{
    var title:String?
    var id:Int?
    var icon:UIImage?
    var iconTintColor:UIColor = Style.colorPrimaryExtraLight
    var iconActiveTintColor:UIColor = Style.colorTextPrimary
    var textColor:UIColor = Style.colorTextGray
    var textActiveColor:UIColor = Style.colorTextPrimary
    var isSelected:Bool = false
    var showHint:Bool = false
    var hintColor:UIColor = UIColor.red
}
