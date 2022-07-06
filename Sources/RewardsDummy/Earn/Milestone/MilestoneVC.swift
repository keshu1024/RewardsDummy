//
//  MilestoneVC.swift
//  Cardex
//
//  Created by Akshay Patel on 24/06/22.
//  Copyright © 2022 Jainesh. All rights reserved.
//

import Foundation
import UIKit

class MilestoneVC: BaseVC {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewHeader: AppHeaderView!
    
    lazy var viewModel: MilestoneViewModel = {
          return MilestoneViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
}

//MARK: - UI Methods
extension MilestoneVC: ControllerInitialSetupDelegate {
    
    func setLabels() {
        
    }
    
    func setupViews() {
        
    }
    
    func initialSetup() {
        collectionView.register(UINib(nibName: "MilestoneCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MilestoneCollectionCell")
        prepareTopNavigationBarUI()
    }
    
    func prepareTopNavigationBarUI() {
        self.viewHeader.navigationBar.lblTitle?.text = "Milestones"
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

//MARK: - Collectionview Dlegate And Datasource
extension MilestoneVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        cell.layer.transform = CATransform3DMakeScale(0.5,0.5,1)
        UIView.animate(withDuration: 0.5, animations: {
               cell.layer.transform = CATransform3DMakeScale(1,1,1)
           })
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MilestoneCollectionCell", for: indexPath) as! MilestoneCollectionCell
        cell.setupMilestoneCell(indexPath: indexPath)
        return cell
    }
    
}

//MARK: - Collectionview delegate flowlayout
extension MilestoneVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (_screenSize.width)
        return CGSize(width: width, height: 260)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 24, left: 0, bottom: 24, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }

}
