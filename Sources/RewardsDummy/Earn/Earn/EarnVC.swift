//
//  EarnVC.swift
//  IXFIStage
//
//  Created by Akshay Patel on 22/06/22.
//  Copyright © 2022 Jainesh. All rights reserved.
//

import Foundation
import UIKit

class EarnVC: BaseVC {
    
    @IBOutlet weak var collectionViewOneTimeTask: UICollectionView!
    @IBOutlet weak var collectionViewRecurringTaks: UICollectionView!
    @IBOutlet weak var collectionViewMonthlyTaks: UICollectionView!
    @IBOutlet weak var collectionViewMilestone: UICollectionView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var milestonePageControl: UIPageControl!
    @IBOutlet weak var MonthlyTaksPageControl: UIPageControl!
    
    @IBOutlet var lblsHeader: [UILabel]!
    @IBOutlet var btnsViewAll: [UIButton]!
    
    let colorType: [TaskCollectionGradiantType] = [.purple, .pink, .blue, .lavonder]
    
    lazy var viewModel: EarnViewModel = {
          return EarnViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        setLabels()
    }
    
}

//MARK: - UI Methods
extension EarnVC: ControllerInitialSetupDelegate {

    func initialSetup() {
        collectionViewRecurringTaks.register(UINib(nibName: "RecurringTaskCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "recurringTaskCell")
        collectionViewOneTimeTask.register(UINib(nibName: "OneTimeTaskCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "listCell")
        collectionViewOneTimeTask.register(UINib(nibName: "OneTimeViewAllCollectionCell", bundle: nil), forCellWithReuseIdentifier: "viewAllCell")
        collectionViewMonthlyTaks.register(UINib(nibName: "MonthlyTaskCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MonthlyTaskCollectionCell")
        collectionViewMilestone.register(UINib(nibName: "MilestoneCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MilestoneCollectionCell")


    }

    func setLabels() {
        for (idx,lbl) in lblsHeader.enumerated() {
            lbl.text = EarnCollectionType(val: idx).headerTitle
            lbl.font = .heading(of20: .poppinsBold)
            btnsViewAll[idx].titleLabel?.font = .regular(of15: .medium)
            btnsViewAll[idx].setTitle("View All", for: .normal)
        }
    }
    
    func setupViews() {
        
    }
    
}

//MARK: - Navigation Methods
extension EarnVC {
    
    func naviToOnetimeTaskVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "OneTimeTaskVC") as! OneTimeTaskVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func naviToRecurringTaskVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "RecurringTaskVC") as! RecurringTaskVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func naviToMonthlyTaskVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MonthlyTaskVC") as! MonthlyTaskVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func naviToMilestoneVC() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MilestoneVC") as! MilestoneVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func naviToTaskRuleVC(index: Int) {
        let vc = UIStoryboard.Reward.instantiateViewController(withIdentifier: "TaskRulesVC") as! TaskRulesVC
        let draggableVC = DraggableBaseController(showTitleView : true, titleString: "Complete Task")
        draggableVC.controller = vc
        draggableVC.shouldLetDragToFullScreen = true
        draggableVC.modalPresentationStyle = .overFullScreen
        self.present(draggableVC, animated : false)

    }
    
}

//MARK: - Actions
extension EarnVC {
    
    @IBAction func btnOneTimeTaskViewAllTapped(_ sender: UIButton) {
        naviToOnetimeTaskVC()
    }
    
    @IBAction func btnRecurringTaskViewAllTapped(_ sender: UIButton) {
        naviToRecurringTaskVC()
    }
    
    @IBAction func btnMonthlyTaskViewAllTapped(_ sender: UIButton) {
        naviToMonthlyTaskVC()
    }
 
    @IBAction func btnMilestoneViewAllTapped(_ sender: UIButton) {
        naviToMilestoneVC()
    }
    
    func collectionBtnTppedHandler(_ sender: UIButton) {
        
    }
    
}

//MARK: - Collectionview Delegate And Datasource
extension EarnVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch EarnCollectionType(val: collectionView.tag) {
        case .oneTimeTask:
            return 4
        case .recuringTask:
            return 10
        case .monthlyTask:
            return 5
        case .milestone:
            return 5
        case .none:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch EarnCollectionType(val: collectionView.tag) {
        case .oneTimeTask:
           let color = colorType[indexPath.item % 4]
            if indexPath.row == 3 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewAllCell", for: indexPath) as! OneTimeViewAllCollectionCell
                cell.setupViewAll(gradiantType: color)
                return cell
            }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as! OneTimeTaskCollectionViewCell
                cell.setupOnetimeTaskCellData(gradiantType: color)
                return cell
            }
        case .recuringTask:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "recurringTaskCell", for: indexPath) as! RecurringTaskCollectionViewCell
            cell.setupRecurringTaskCell()
            return cell
        case .monthlyTask:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthlyTaskCollectionCell", for: indexPath) as! MonthlyTaskCollectionCell
            cell.setupMonthlytaskCell(indexPath: indexPath)
            cell.btnRules.addTarget(self, action: #selector(showRules(sender:)), for: .touchUpInside)
            return cell
        case .milestone:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MilestoneCollectionCell", for: indexPath) as! MilestoneCollectionCell
            cell.setupMilestoneCell(indexPath: indexPath)
            cell.btnRules.addTarget(self, action: #selector(showRules(sender:)), for: .touchUpInside)
            return cell
        case .none:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MonthlyTaskCollectionCell", for: indexPath) as! MonthlyTaskCollectionCell
            cell.setupMonthlytaskCell(indexPath: indexPath)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch EarnCollectionType(val: collectionView.tag) {
        case .oneTimeTask:
            if indexPath.row == 3 {
                naviToOnetimeTaskVC()
            }else{
                naviToTaskRuleVC(index: indexPath.row)
            }
        case .recuringTask:
            naviToTaskRuleVC(index: indexPath.row)
        case .monthlyTask, .milestone, .none:
            break
        }
    }
    
    @objc func showRules(sender : UIButton) {
        naviToTaskRuleVC(index: sender.tag)
    }
    
}

//MARK: - Collectionview delegate flowlayout
extension EarnVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch EarnCollectionType(val: collectionView.tag) {
        case .oneTimeTask:
            let width = (_screenSize.width - 64) / 2
            return CGSize(width: width, height: width)
        case .recuringTask:
            return CGSize(width: 155, height: 190)
        case .monthlyTask:
            let width = (_screenSize.width)
            return CGSize(width: width, height: 290)
        case .milestone:
            let width = (_screenSize.width)
            return CGSize(width: width, height: 280)
        case .none:
            return .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch EarnCollectionType(val: collectionView.tag) {
        case .oneTimeTask, .recuringTask:
            return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        case .none, .monthlyTask, .milestone:
            return .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch EarnCollectionType(val: collectionView.tag) {
        case .oneTimeTask:
            return 16
        case .recuringTask:
            return 12
        case .monthlyTask, .milestone, .none:
            return .zero
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch EarnCollectionType(val: collectionView.tag) {
        case .oneTimeTask:
            return 16
        case .recuringTask:
            return 12
        case .monthlyTask, .milestone, .none:
            return .zero
        }
    }

    
}

//MARK: - Collectionview delegate
extension EarnVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2

        if self.scrollView == scrollView {
//            if scrollView.contentOffset.x != 0 {
//                scrollView.contentOffset.x = 0
//            }
        }else if scrollView == collectionViewMonthlyTaks {
            MonthlyTaksPageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
        }else if scrollView == collectionViewMilestone {
            milestonePageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
        }
    }
    
}
