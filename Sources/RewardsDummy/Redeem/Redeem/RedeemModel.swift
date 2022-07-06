//
//  EarnModel.swift
//  IXFIStage
//
//  Created by Akshay Patel on 22/06/22.
//  Copyright © 2022 Jainesh. All rights reserved.
//

import Foundation
import UIKit

enum RedeemCollectionType: Int {
    case comingSoon = 0
    case soldOut
    case none
    
    
    init(val: Int) {
        if let check = RedeemCollectionType(rawValue: val) {
            self = check
        }else{
            self = .none
        }
    }
    
}
