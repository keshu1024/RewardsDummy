//
//  RewardPullUpVC.swift
//  IXFIStage
//
//  Created by Akshay Patel on 21/06/22.
//  Copyright © 2022 Jainesh. All rights reserved.
//

import Foundation
import UIKit

class RewardPullUpVC: UIViewController {
    
    @IBOutlet weak var allButtonContainerView : UIView!
    
    @IBOutlet var btnsTab: [UIButton]!
    @IBOutlet var lblsTab: [UILabel]!
    
    @IBOutlet weak var lblHome: UILabel!
    
    var tabbarSelectedIndex = 0
    
    var rewardPageController : RewardsPageController?
    
    enum SelectedMenu: Int {
        case earn = 0,redeem,history
        
        init(val: Int) {
            if let check = SelectedMenu(rawValue: val) {
                self = check
            }else{
                self = .earn
            }
        }
    }
    
    var selectedMenu : SelectedMenu = .earn
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(segmentIndexChanged(notification:)), name: .segmentIndexChange, object: nil)
        setupView()
        setupLabels()
        self.setActiveWithIndex(selectedIndex: tabbarSelectedIndex)
    }
    
    override func viewDidAppear(_ animated : Bool) {
        super.viewWillAppear(true)
        allButtonContainerView.layer.sgApplySketchShadow(color: .getAppPrimaryShadowColor(), alpha: 0.20, x: 0, y: 2, blur: 8, spread: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reward" {
            self.rewardPageController = segue.destination as? RewardsPageController
        }
    }
     
}


//MARK: - UI Methods
extension RewardPullUpVC {
    
    func setupLabels() {
        lblsTab[0].text = "Earn"
        lblsTab[1].text = "Redeem"
        lblsTab[2].text = "History"
    }
    
    func setupView() {
        
    }
    
    func setActiveWithIndex(selectedIndex: Int) {
        self.tabbarSelectedIndex = selectedIndex
        selectedMenu = SelectedMenu(val: self.tabbarSelectedIndex)
        updateTabViewIndex()
    }
    
    func updateTabViewIndex() {
        for (idx,_) in btnsTab.enumerated() {
            if selectedMenu.rawValue == idx {
                btnsTab[idx].isSelected = true
                lblsTab[idx].font = .regular(of15: .medium)
                lblsTab[idx].textColor = .getPrimaryFirstGradientColor()
            }else{
                btnsTab[idx].isSelected = false
                lblsTab[idx].font = .regular(of15: .regular)
                lblsTab[idx].textColor = .getGrayBgDark()
            }
        }
    }
    
}

//MARK: - Actions
extension RewardPullUpVC {
    
    @IBAction func btnHomeTapped(_ sender: UIButton) {
        self.popViewController()
    }
    
    @IBAction func btnsTabTapped(_ sender: UIButton) {
        if sender.tag != self.tabbarSelectedIndex {
            setActiveWithIndex(selectedIndex: sender.tag)
            NotificationCenter.default.post(name: .segmentIndexChange, object: sender.tag)

        }
    }
}

//MARK: - Observer
extension RewardPullUpVC {
    
    @objc func segmentIndexChanged(notification : Notification) {
        if let selectedIndex = notification.object as? Int {
            setActiveWithIndex(selectedIndex: selectedIndex)
        }
    }
    
}
