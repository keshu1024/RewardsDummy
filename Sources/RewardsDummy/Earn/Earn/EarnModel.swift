//
//  EarnModel.swift
//  IXFIStage
//
//  Created by Akshay Patel on 22/06/22.
//  Copyright © 2022 Jainesh. All rights reserved.
//

import Foundation
import UIKit

enum EarnCollectionType: Int {
    case oneTimeTask = 0
    case recuringTask
    case monthlyTask
    case milestone
    case none
    
    var headerTitle: String {
        switch self {
        case .oneTimeTask:
            return "One Time Tasks"
        case .recuringTask:
            return "Recurring Task"
        case .monthlyTask:
            return "Monthly Task"
        case .milestone:
            return "Milestone"
        case .none:
            return ""
        }
    }
    
    init(val: Int) {
        if let check = EarnCollectionType(rawValue: val) {
            self = check
        }else{
            self = .none
        }
    }
    
}


class EarnModel {
    
}
