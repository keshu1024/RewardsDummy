
import Foundation
import UIKit

class AvailableRedeemVC: BaseVC {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var viewHeader: AppHeaderView!
    
    lazy var viewModel: OneTimeTaskViewModel = {
          return OneTimeTaskViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
}

//MARK: -  UI Methods
extension AvailableRedeemVC: ControllerInitialSetupDelegate {
    
    func initialSetup() {
        collectionView.registerCollectionViewCell(cellIdentifier: CellIdentifier.AvailableRedeemCollectionCell)
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
extension AvailableRedeemVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {

        cell.layer.transform = CATransform3DMakeScale(0.5,0.5,1)
        UIView.animate(withDuration: 0.5, animations: {
               cell.layer.transform = CATransform3DMakeScale(1,1,1)
           })
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvailableRedeemCollectionCell", for: indexPath) as! AvailableRedeemCollectionCell
        cell.configure()
        var index = indexPath.row % 6
        if index == 0 {
            index = 3
        }
        cell.imageCoin.image = UIImage(named: "\(index)")
        cell.labelDescription.font = .small(of12: .bold)
        return cell
    }
}

//MARK: - Collectionview Delegate flowlayout
extension AvailableRedeemVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = (_screenSize.width - 64) / 2
        let itemHeight = itemWidth*1.31
        return CGSize(width: itemWidth, height: itemHeight)
        
        
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
