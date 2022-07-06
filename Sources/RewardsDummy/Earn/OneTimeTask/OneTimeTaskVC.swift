//
//  OneTimeTaskVC.swift
//  Cardex
//
//  Created by Akshay Patel on 23/06/22.
//  Copyright © 2022 Jainesh. All rights reserved.
//

import Foundation
import UIKit

class OneTimeTaskVC: BaseVC {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewHeader: AppHeaderView!
    
    let colorType: [TaskCollectionGradiantType] = [.purple, .pink, .blue, .lavonder]
    
    lazy var viewModel: OneTimeTaskViewModel = {
          return OneTimeTaskViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
        
}

//MARK: -  UI Methods
extension OneTimeTaskVC: ControllerInitialSetupDelegate {
    
    func initialSetup() {
        collectionView.register(UINib(nibName: "OneTimeTaskCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "listCell")
        collectionView.register(UINib(nibName: "OneTimeTaskCompletedCell", bundle: nil), forCellWithReuseIdentifier: "OneTimeTaskCompletedCell")

        prepareTopNavigationBarUI()
    }
    
    func setLabels() {
        
    }
    
    func setupViews() {
        
    }
    
    func prepareTopNavigationBarUI() {
        self.viewHeader.navigationBar.lblTitle?.text = "One Time Tasks"
        self.viewHeader.navigationBar.handleBlockAction {[weak self] (sender, navTapped, btn) in
            switch navTapped {
            case .left:
                self?.navigationController?.popViewController(animated: true)
                break
            case .right, .right2, .right3:
                break
            }
        }
    }
    
}

//MARK: - Navigation Methods
extension OneTimeTaskVC {
    
    func naviToTaskRuleVC(index: Int) {
        let vc = UIStoryboard.Reward.instantiateViewController(withIdentifier: "TaskRulesVC") as! TaskRulesVC
        let draggableVC = DraggableBaseController(showTitleView : true, titleString: "Complete Task")
        draggableVC.controller = vc
        draggableVC.shouldLetDragToFullScreen = true
        draggableVC.modalPresentationStyle = .overFullScreen
        self.present(draggableVC, animated : false)
    }
    
}

//MARK: - Collectionview delegate and datasource
extension OneTimeTaskVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        cell.layer.transform = CATransform3DMakeScale(0.5,0.5,1)
        UIView.animate(withDuration: 0.5, animations: {
               cell.layer.transform = CATransform3DMakeScale(1,1,1)
           })
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row > 15 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OneTimeTaskCompletedCell", for: indexPath) as! OneTimeTaskCompletedCell
            cell.setupOnetimeTaskCellData()
            return cell
        }
        let color = colorType[indexPath.item % 4]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as! OneTimeTaskCollectionViewCell
        cell.setupOnetimeTaskCellData(gradiantType: color)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        naviToTaskRuleVC(index: indexPath.row)
    }
}

//MARK: - Collectionview Delegate flowlayout
extension OneTimeTaskVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (_screenSize.width - 64) / 2
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 24, bottom: 24, right: 24)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }

}
