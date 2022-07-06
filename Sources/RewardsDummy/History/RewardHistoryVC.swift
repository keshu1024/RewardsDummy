//
//  RewardHistoryVC.swift
//  Cardex
//
//  Created by BCS Member on 23/06/22.
//  Copyright © 2022 Jainesh. All rights reserved.
//

import UIKit


enum RewardHistoryScreenType: Int {
    case earned = 0
    case redeemed
}

class RewardHistoryVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    

    var kTableHeaderHeight:CGFloat = 300
    var headerView: UIView!
    
    lazy var viewModel: RewardHistoryViewModel = {
          return RewardHistoryViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
//        setLabels()
//        updateUI()
        setupStretchyHeaderview()
    }

}

//MARK: - UI Methods
extension RewardHistoryVC: ControllerInitialSetupDelegate {
    
    func setLabels() {
    }
    
    func setupViews() {
        
    }
    
    func initialSetup() {
        
    }
    
    func updateUI() {
        
    }
    
    func setupStretchyHeaderview() {
        tableView.rowHeight = UITableView.automaticDimension
        headerView = tableView.tableHeaderView
//        headerView.layer.zPosition = -5
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        tableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
        updateHeaderView()
    }
    
    
    func updateHeaderView() {
        var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
        if tableView.contentOffset.y < -kTableHeaderHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y
        }
        headerView.frame = headerRect
    }
    
}

//MARK: - Actions
extension RewardHistoryVC {
    
    func btnEarnedTappedHandler(_ sender: UIButton) {
        self.tableView.reloadData()
    }
    
    func btnRedeemTappedHandler(_ sender: UIButton) {
        self.tableView.reloadData()
    }
    
}
 

//MARK: - UITableview delegate and datasource
extension RewardHistoryVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 55
        }
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "btnCell", for: indexPath) as! RewardHistoryCell
            cell.controller = self
            cell.viewModel = self.viewModel
            cell.setupButtonCellView()
            cell.indentationLevel = 2
            cell.layer.zPosition = 5
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! RewardHistoryCell
        cell.setupRewardHistoryCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 1
        }
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell") as!  RewardHistoryCell
        cell.setupHeaderviewData()
        return cell
    }
    
    
}


//MARK: - Scrollview Delegate
extension RewardHistoryVC {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
}
