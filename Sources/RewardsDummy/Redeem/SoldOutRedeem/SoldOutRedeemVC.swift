
import Foundation
import UIKit

class SoldOutRedeemVC: BaseVC {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewHeader: AppHeaderView!
    
    lazy var viewModel: SoldOutRedeemViewModel = {
          return SoldOutRedeemViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
}

//MARK: -  UI Methods
extension SoldOutRedeemVC: ControllerInitialSetupDelegate {
    
    func initialSetup() {
        collectionView.registerCollectionViewCell(cellIdentifier: CellIdentifier.SoldOutCollectionViewCell)
        prepareTopNavigationBarUI()
    }
    
    func setLabels() {
        
    }
    
    func setupViews() {
        
    }
    
    func prepareTopNavigationBarUI() {
        self.viewHeader.navigationBar.lblTitle?.text = "Available to redeem"
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

//MARK: - Collectionview delegate and datasource
extension SoldOutRedeemVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        cell.layer.transform = CATransform3DMakeScale(0.5,0.5,1)
        UIView.animate(withDuration: 0.5, animations: {
               cell.layer.transform = CATransform3DMakeScale(1,1,1)
           })
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SoldOutCollectionViewCell", for: indexPath) as! SoldOutCollectionViewCell
        cell.configure()
        cell.labelTotal.font = .small(of12: .poppinsMedium)
        cell.labelSoldOut.font = .small(of12: .bold)
        var index = indexPath.row % 6
        if index == 0 {
            index = 3
        }
        cell.imgCoin.image = UIImage(named: "\(index)")
        return cell
    }
}

//MARK: - Collectionview Delegate flowlayout
extension SoldOutRedeemVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemWidth = (_screenSize.width - 64) / 2
        let width  = (_screenSize.width - 80)/3
        return CGSize(width: width , height: width)
        
        
//        let width = (_screenSize.width - 64) / 2
//        return CGSize(width: width, height: width)
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
