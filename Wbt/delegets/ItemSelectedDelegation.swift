//
//  ItemSelectedDelegation.swift
//  Wbt
//
//  Created by Hafizullah Samim on 5/3/21.
//

import Foundation
@objc protocol ItemSelectedDelegation {
    
    @objc optional func onItemSelected(index:Int)
    @objc optional func onItemSelected(index:Int,value:String)
}
