

import UIKit
import QuartzCore


class RedeemVC: BaseVC,ControllerInitialSetupDelegate {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionViewSoldOut: UICollectionView!
    @IBOutlet weak var labelSoldOut: UILabel!
    @IBOutlet weak var collectionViewComingSoon: UICollectionView!
    @IBOutlet weak var labelViewAllSoldOut: UILabel!
    @IBOutlet weak var labelComingSoon: UILabel!
    @IBOutlet weak var labelViewAllComing: UILabel!
//    @IBOutlet weak var viewCollectionHeight: NSLayoutConstraint!
//    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var labelViewAll: UILabel!
    @IBOutlet weak var labelAvailable: UILabel!
//    @IBOutlet weak var collectionViewAvailable: UICollectionView!
    @IBOutlet weak var viewRedeemHeader: ReedemHeaderView!
    @IBOutlet weak var collectionViewSoldOutHeight: NSLayoutConstraint!
    
    @IBOutlet weak var collectionAvailableHeight: NSLayoutConstraint!
    @IBOutlet weak var availableRedeemView : iCarousel!
    
    private let noOfCards = 20
    fileprivate var currentPage: Int = 0 {
        didSet {
            updateSelectedCardIndicator()
        }
    }
//    fileprivate var pageSize: CGSize {
//        let layout = self.collectionViewAvailable.collectionViewLayout as! UPCarouselFlowLayout
//        var pageSize = layout.itemSize
//        if layout.scrollDirection == .horizontal {
//            pageSize.width += layout.minimumLineSpacing
//        } else {
//            pageSize.height += layout.minimumLineSpacing
//        }
//        return pageSize
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        setupViews()
        initialSetup()
        setupLayout()
        DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
            self.availableRedeemView.scrollToItem(at: 2, animated: true)
        }
    
    }
    override func viewDidAppear(_ animated: Bool) {
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
//            self.collectionViewAvailable.scrollToItem(at: IndexPath(item: 1, section: 0), at: .right, animated: true)
//        }
    }
    fileprivate func setupLayout() {
//        let layout = self.collectionViewAvailable.collectionViewLayout as! UPCarouselFlowLayout
//        layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 30)
    }
    func setLabels() {
        [self.labelAvailable,self.labelSoldOut,self.labelComingSoon].forEach { label in
            label?.font = .heading(of20: .poppinsBold)
            label?.textColor = .getTextPrimaryColor()

        }
        [self.labelViewAll,self.labelViewAllComing,self.labelViewAllSoldOut].forEach { label in
            label?.font = .regular(of15: .medium)
            label?.textColor = .getTextSecondaryColor()
        }
    }
    
    func setupViews() {
        collectionViewComingSoon.registerCollectionViewCell(cellIdentifier: CellIdentifier.ComingSoonCollectionViewCell)
        collectionViewSoldOut.registerCollectionViewCell(cellIdentifier: CellIdentifier.SoldOutCollectionViewCell)
    }
    
    func initialSetup() {
        self.view.layoutIfNeeded()
        self.pageControl.numberOfPages = self.noOfCards
        self.currentPage = 0
//        self.viewCollectionHeight.constant = (UIScreen.main.bounds.width/1.8*1.31)*1.2
        
        let widthSoldOut = (collectionViewSoldOut.frame.width-60)/3
        self.collectionViewSoldOutHeight.constant = (widthSoldOut*2)+55
        collectionViewSoldOut.isScrollEnabled = false
        
        let itemWidth = UIScreen.main.bounds.width/1.6
        self.collectionAvailableHeight.constant = itemWidth*1.31
        
        self.view.layoutIfNeeded()
        
        availableRedeemView.dataSource = self
        availableRedeemView.delegate = self
        
        availableRedeemView.type = .coverFlow
    }

    func updateSelectedCardIndicator() {
        self.pageControl.currentPage = self.currentPage
    }
    @IBAction func buttonViewAllAction(_ sender: Any) {
        let vc : AvailableRedeemVC = UIStoryboard.RewardsTemp.instantiateViewController(withIdentifier: "AvailableRedeemVC") as! AvailableRedeemVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func buttonViewAllComingSoonAction(_ sender: Any) {
        let vc : ComingSoonRedeemVC = UIStoryboard.RewardsTemp.instantiateViewController(withIdentifier: "ComingSoonRedeemVC") as! ComingSoonRedeemVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func buttonViewAllSoldOutAction(_ sender: Any) {
        let vc : SoldOutRedeemVC = UIStoryboard.RewardsTemp.instantiateViewController(withIdentifier: "SoldOutRedeemVC") as! SoldOutRedeemVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
extension RedeemVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch RedeemCollectionType(val: collectionView.tag) {
        case .comingSoon:
            return 12
        case .soldOut:
            return 6
        case .none:
            return 0
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch RedeemCollectionType(val: collectionView.tag) {
//        case .available:
//            let vc : RedeemDetailVC = UIStoryboard.RewardsTemp.instantiateViewController(withIdentifier: "RedeemDetailVC") as! RedeemDetailVC
//            vc.reedemType = .available
//            self.navigationController?.pushViewController(vc, animated: true)
        case .comingSoon:
            let vc : RedeemDetailVC = UIStoryboard.RewardsTemp.instantiateViewController(withIdentifier: "RedeemDetailVC") as! RedeemDetailVC
            vc.reedemType = .comingSoon
            self.navigationController?.pushViewController(vc, animated: true)
        case .soldOut:
            let vc : RedeemDetailVC = UIStoryboard.RewardsTemp.instantiateViewController(withIdentifier: "RedeemDetailVC") as! RedeemDetailVC
            vc.reedemType = .soldOut
            self.navigationController?.pushViewController(vc, animated: true)
        case .none:
            break
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch RedeemCollectionType(val: collectionView.tag) {

        case .comingSoon:
            let cell  = collectionViewComingSoon.dequeueReusableCell(withReuseIdentifier: "ComingSoonCollectionViewCell", for: indexPath) as? ComingSoonCollectionViewCell
            cell?.configure()
            var index = indexPath.row % 6
            if index == 0 {
                index = 3
            }
            cell?.imageCoin.image = UIImage(named: "\(index)")
            return cell!
        case .soldOut:
            let cell = collectionViewSoldOut.dequeueReusableCell(withReuseIdentifier: "SoldOutCollectionViewCell", for: indexPath) as? SoldOutCollectionViewCell
            cell?.configure()
            var index = indexPath.row % 6
            if index == 0 {
                index = 3
            }
            cell?.imgCoin.image = UIImage(named: "\(index)")
            return cell!
        case .none:
            return UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch RedeemCollectionType(val: collectionView.tag) {
//        case .available:
//            let itemWidth = UIScreen.main.bounds.width/1.6
//            let itemHeight = itemWidth*1.31
//            return CGSize(width: itemWidth, height: itemHeight)
        case .comingSoon:
            return CGSize(width: 146 , height: 170)
            
        case .soldOut:
            let width  = (collectionView.frame.width-60)/3
            return CGSize(width: width , height: width)
        case .none:
            return .zero
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        switch RedeemCollectionType(val: collectionView.tag) {
//        case .available:
//            return UIEdgeInsets(top: 0, left: 25, bottom:0, right: 25)
        case .comingSoon:
            return UIEdgeInsets(top: 10, left: 25, bottom: 20, right: 25)
        case .soldOut:
            return UIEdgeInsets(top: 15, left: 15, bottom:15, right: 15)
        case .none:
            return .zero
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        switch RedeemCollectionType(val: collectionView.tag) {
//        case .available:
//            return .zero
        case .comingSoon:
            return 15
        case .soldOut:
            return 15
        case .none:
            return .zero
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        switch RedeemCollectionType(val: collectionView.tag) {
//        case .available:
//            return .zero
        case .comingSoon:
            return 15
        case .soldOut:
            return 15
        case .none:
            return .zero
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let layout = self.collectionViewAvailable.collectionViewLayout as! UPCarouselFlowLayout
//        let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
//        let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
////        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
//        currentPage -= 1
//        currentPage = currentPage < 0 ? 0 : currentPage
//        print("current page is \(currentPage)")
    }
}


extension RedeemVC : iCarouselDataSource, iCarouselDelegate {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return noOfCards
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
       let redeemView = Bundle.main.loadNibNamed("AvailableRedeemView", owner: self, options: nil)![0] as! AvailableRedeemView
        
        let itemWidth = UIScreen.main.bounds.width/1.6
        let itemHeight = itemWidth*1.31
        redeemView.frame = CGRect(x: 0, y: 0, width: itemWidth, height: itemHeight)
        redeemView.imageCoin.image = UIImage(named: "\(index % 5  == 0 ? 1 : (index % 5) )")
//        return CGSize(width: itemWidth, height: itemHeight)
        
        return redeemView
    }
    
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        currentPage = carousel.currentItemIndex
    }
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        let vc : RedeemDetailVC = UIStoryboard.RewardsTemp.instantiateViewController(withIdentifier: "RedeemDetailVC") as! RedeemDetailVC
        vc.reedemType = .available
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
