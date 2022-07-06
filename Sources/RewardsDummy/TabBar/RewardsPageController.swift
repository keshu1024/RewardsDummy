//
//  RewardsPageController.swift
//  Cardex
//
//  Created by BCS Member on 23/06/22.
//  Copyright © 2022 Jainesh. All rights reserved.
//

import Foundation
import Parchment
import UIKit

class RewardsPageController: UIViewController {
    
    let pageViewController = PageViewController()
    var currentIndex = 0
    var viewControllers: [UIViewController] = []
    weak var rewardsPullUpVC : RewardPullUpVC?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let earnVC = UIStoryboard.Reward.instantiateViewController(withIdentifier: "EarnVC") as? EarnVC
        let rewardsVC = UIStoryboard.RewardsTemp.instantiateViewController(withIdentifier: "RedeemVC") as? RedeemVC
        let historyVC = UIStoryboard.Reward.instantiateViewController(withIdentifier: "RewardHistoryVC") as? RewardHistoryVC
        
        self.viewControllers = [earnVC!,rewardsVC!,historyVC!]
      
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageViewController.selectViewController(viewControllers[0], direction: .none)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        view.constrainToEdges(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(segmentIndexChanged(notification:)), name: .segmentIndexChange, object: nil)

        rewardsPullUpVC = getTabBarController()
    }
    
    
    private func getTabBarController() -> RewardPullUpVC {
        
        let currentPullUpController = children
            .filter({ $0 is RewardPullUpVC })
            .first as? RewardPullUpVC
        let rewardsPullUpVC: RewardPullUpVC = currentPullUpController ?? UIStoryboard.Reward.instantiateViewController(withIdentifier: "RewardPullUpVC") as! RewardPullUpVC
        return rewardsPullUpVC
    }
    
    @objc func segmentIndexChanged(notification : Notification) {
        
        self.currentIndex = self.viewControllers.firstIndex(of: self.pageViewController.selectedViewController!) ?? 0
        if let selectedIndex = notification.object as? Int {
            if self.currentIndex != selectedIndex {
                self.pageViewController.selectViewController(viewControllers[selectedIndex], direction: (self.currentIndex > selectedIndex ? .reverse : .forward ), animated: true)
            }
        }
    }
    
}


extension RewardsPageController: PageViewControllerDataSource {
    
    
    func pageViewController(
        _: PageViewController,
        viewControllerBeforeViewController viewController: UIViewController
    ) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
        if index > 0 {
            return viewControllers[index - 1]
        }
        return nil
    }
    
    func pageViewController(
        _: PageViewController,
        viewControllerAfterViewController viewController: UIViewController
    ) -> UIViewController? {
        guard let index = viewControllers.firstIndex(of: viewController) else { return nil }
        if index < viewControllers.count - 1 {
            return viewControllers[index + 1]
        }
        return nil
    }
}

extension RewardsPageController: PageViewControllerDelegate {
    func pageViewController(_: PageViewController, willStartScrollingFrom startingViewController: UIViewController, destinationViewController: UIViewController) {
        log("willStartScrollingFrom: ",
              startingViewController.title ?? "",
              destinationViewController.title ?? "")
    }
    
    func pageViewController(_: PageViewController, isScrollingFrom startingViewController: UIViewController, destinationViewController: UIViewController?, progress: CGFloat) {
        log("isScrollingFrom: ",
              startingViewController.title ?? "",
              destinationViewController?.title ?? "",
              progress)
    }
    
    func pageViewController(_: PageViewController, didFinishScrollingFrom startingViewController: UIViewController, destinationViewController: UIViewController, transitionSuccessful: Bool) {
        log("didFinishScrollingFrom: ",
              startingViewController.title ?? "",
              destinationViewController.title ?? "",
              transitionSuccessful)
        
        if transitionSuccessful {
            if let index = viewControllers.firstIndex(of: destinationViewController) {
                rewardsPullUpVC?.setActiveWithIndex(selectedIndex: index)
            }
        }
    }
    
    
}
