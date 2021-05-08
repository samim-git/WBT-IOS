//
//  Enums.swift
//  Wbt
//
//  Created by Hafizullah Samim on 5/3/21.
//

import Foundation
enum Gender: Int {
    case male = 1, female = 2;
}
enum Direction: Int{
    case top = 1, leading = 2, bottom = 3,trailing = 4,left = 5, right = 6
}
enum ZoomType {
    case IN, OUT;
}
enum ZoomDirection {
    case LEFT_DOWN, LEFT_UP, RIGHT_UP, RIGHT_DOWN;
}
