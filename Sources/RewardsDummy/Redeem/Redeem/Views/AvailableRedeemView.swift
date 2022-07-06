//
//  AvailableRedeemView.swift
//  Cardex
//
//  Created by BCS Member on 27/06/22.
//  Copyright © 2022 Jainesh. All rights reserved.
//

import UIKit

class AvailableRedeemView: UIView {
    
    @IBOutlet weak var viewAvailable: AppGradientView!
    @IBOutlet weak var labelAvailableTitle: UILabel!
    @IBOutlet weak var imageCoin: UIImageView!
    @IBOutlet weak var labelAvailableValue: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelCoins: UILabel!
    

    func configure(){
        self.labelAvailableTitle.font = .small(of12: .regular)
        self.labelAvailableValue.font = .regular(of15: .bold)
        self.labelDescription.font = .subHeading(of17: .bold)
        self.labelCoins.font = .regular(of15: .bold)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
        imageCoin.layer.cornerRadius = 15
    }
}
