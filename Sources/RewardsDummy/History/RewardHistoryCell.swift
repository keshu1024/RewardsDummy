//
//  RewardHistoryCell.swift
//  Cardex
//
//  Created by Akshay Patel on 24/06/22.
//  Copyright © 2022 Jainesh. All rights reserved.
//

import Foundation
import UIKit


class RewardHistoryCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblHeader: UILabel!
    
    @IBOutlet weak var lblPoint: UILabel!
 
    @IBOutlet weak var viewEarned: UIView!
    @IBOutlet weak var viewRedeem: UIView!
    @IBOutlet weak var lblEarned: UILabel!
    @IBOutlet weak var lblRedeem: UILabel!

    
    var viewModel: RewardHistoryViewModel!
    weak var controller: UIViewController?
    
}

//MARK: - UI Methods
extension RewardHistoryCell {
    
    func setupRewardHistoryCell() {
        lblTitle.font = .regular(of15: .bold)
        lblSubTitle.font = .small(of12: .regular)
        lblPoint.font = .small(of12: .medium)
    }
    
    func setupHeaderviewData() {
        lblHeader.text = "20/04/22"
        lblHeader.font = .subHeading(of17: .bold)
    }
    
    func setupButtonCellView() {
        lblEarned.text = "Earned"
        lblRedeem.text = "Redeemed"

        switch viewModel.screenType {
        case .earned:
            lblEarned.textColor = .getAppWhite()
            lblRedeem.textColor = .getTextSecondaryColor()
            viewRedeem.isHidden = true
            viewEarned.isHidden = false
            lblEarned.font = .subHeading(of17: .medium)
            lblRedeem.font = .subHeading(of17: .regular)
        case .redeemed:
            lblEarned.textColor = .getTextSecondaryColor()
            lblRedeem.textColor = .getAppWhite()
            viewRedeem.isHidden = false
            viewEarned.isHidden = true
            lblRedeem.font = .subHeading(of17: .medium)
            lblEarned.font = .subHeading(of17: .regular)

        }
    }
    
}

//MARK: - Actions
extension RewardHistoryCell {
    
    @IBAction func btnEarnedTapped(_ sender: UIButton) {
        viewModel.screenType = .earned
        setupButtonCellView()
        if let vc = controller as? RewardHistoryVC {
            vc.btnEarnedTappedHandler(sender)
        }
    }
    
    @IBAction func btnRedeemTapped(_ sender: UIButton) {
        viewModel.screenType = .redeemed
        setupButtonCellView()
        if let vc = controller as? RewardHistoryVC {
            vc.btnRedeemTappedHandler(sender)
        }
    }
    
}
