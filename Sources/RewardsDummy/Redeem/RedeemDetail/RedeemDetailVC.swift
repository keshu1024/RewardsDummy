

import UIKit


class RedeemDetailVC: BaseVC {
    
    @IBOutlet weak var viewHeaderBackground: RedeemDetailHeaderView!
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewNavigation: AppSecondaryGradientView!
    @IBOutlet weak var viewHeader: AppHeaderView!
    @IBOutlet weak var labelAvailableValue: UILabel!
    @IBOutlet weak var labelAvailableTitle: UILabel!
    @IBOutlet weak var viewAvailable: UIView!
    @IBOutlet weak var labelCoinValue: UILabel!
    @IBOutlet weak var labelCoinName: AppLabel!
    @IBOutlet weak var viewCoin: UIView!
    @IBOutlet weak var labelCount: UILabel!
    @IBOutlet weak var viewDescription: UIView!
    @IBOutlet weak var labelDescriptionValue: UILabel!
    @IBOutlet weak var viewTasks: UIView!
    @IBOutlet weak var labelDescriptionTitle: UILabel!
    @IBOutlet weak var collectionViewTasks: UICollectionView!
    @IBOutlet weak var labelTasksTitle: UILabel!
    @IBOutlet weak var viewDisclaimer: UIView!
    @IBOutlet weak var labelDisclaimer: UILabel!
    @IBOutlet weak var labelDisclaimerValue: UILabel!
    @IBOutlet weak var viewFooter: UIView!
    @IBOutlet weak var viewNotifyMe: UIView!
    @IBOutlet weak var viewSoldOut: UIView!
    @IBOutlet weak var buttonSoldOut: AppButton!

    @IBOutlet weak var buttonNotifyMe: AppSecondaryGradientButton!
    @IBOutlet weak var labelClaimQty: UILabel!
    @IBOutlet weak var labelClaimQtyValue: UILabel!
    @IBOutlet weak var labelPoints: UILabel!
    @IBOutlet weak var labelPointsValue: UILabel!
    @IBOutlet weak var buttonSubmit: AppButton!
    
    @IBOutlet var lblsStaticTime: [UILabel]!
    @IBOutlet var lblsDynamicTime: [UILabel]!
    var reedemType:RedeemDetailType!
    var count = 2
    var timer = Timer()
    var countdown: DateComponents!

    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer.invalidate()
    }
    func setLabels() {
        [self.labelDescriptionTitle,self.labelTasksTitle].forEach { label in
            label?.font = .heading(of20: .poppinsBold)
            label?.textColor = .getTextPrimaryColor()
        }
        self.labelCoinName.font = .heading(of20: .bold)
        self.labelCoinValue.font = .small(of12: .medium)
        
        self.labelCount.font = .subHeading(of17: .bold)
        self.labelAvailableTitle.font = .small(of12: .regular)
        self.labelAvailableValue.font = .regular(of15: .bold)
        
        self.labelDisclaimer.font = .small(of12: .bold)
        self.labelDisclaimerValue.font = .extraSmall(of10: .regular)
        
        self.labelClaimQty.font = .extraSmall(of10: .regular)
        self.labelPoints.font = .extraSmall(of10: .regular)
        
        self.labelClaimQtyValue.font = .subHeading(of17: .bold)
        self.labelPointsValue.font = .subHeading(of17: .bold)
        self.buttonSubmit.setTitle("Redeem Now", for: .normal)
        self.buttonSoldOut.setTitle("Sold Out", for: .normal)
        self.buttonSubmit.setTitle("Redeem Now", for: .normal)
        self.buttonNotifyMe.setTitle("Notify Me When Available", for: .normal)
        
        lblsStaticTime[0].text = "D"
        lblsStaticTime[1].text = "H"
        lblsStaticTime[2].text = "M"
        lblsStaticTime[3].text = "S"
        
        lblsDynamicTime[0].text = "21"
        lblsDynamicTime[1].text = "01"
        lblsDynamicTime[2].text = "05"
        lblsDynamicTime[3].text = "21"
        
        for lbl in lblsStaticTime {
            lbl.font = .extraSmall(of10: .medium)
        }
        for lbl in lblsDynamicTime {
            lbl.font = .small(of12: .medium)
        }
    }
    
    func setupViews() {
        self.viewNavigation.alpha = scrollView.contentOffset.y / 185
        self.scrollView.delegate = self
        let width = (_screenSize.width - 64) / 2
        self.collectionViewHeight.constant = _screenSize.width
        collectionViewTasks.dataSource = self
        collectionViewTasks.delegate = self
        collectionViewTasks.register(UINib(nibName: "OneTimeTaskCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "listCell")
        collectionViewTasks.register(UINib(nibName: "OneTimeTaskCompletedCell", bundle: nil), forCellWithReuseIdentifier: "OneTimeTaskCompletedCell")
        prepareTopNavigationBarUI()
        
        switch reedemType {
        case .available:
            viewNotifyMe.isHidden = true
            viewSoldOut.isHidden = true
            viewFooter.isHidden = false
        case .comingSoon:
            viewAvailable.isHidden = true
            viewFooter.isHidden = true
            viewSoldOut.isHidden = true
            calculateTimer()
        case .soldOut:
            viewFooter.isHidden = true
            viewNotifyMe.isHidden = true
            viewAvailable.isHidden = true
            viewTasks.isHidden = true
            viewSoldOut.isHidden = false
            buttonSoldOut.alpha = 0.7
        case .none:
            break
        }
        
    }
    func prepareTopNavigationBarUI() {
        
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
    func calculateTimer(){
        runCountdown()
    }
    func runCountdown() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    @objc func updateTime() {
        
        let futureDate = dateFromString(dateStr: "2022-07-10T20:55:12.208Z", sourceFormat: DATE_FORMAT_WEB_GLOBAL,isUTC: true)
        countdown = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: Date(), to: futureDate)

        let countdown = self.countdown //only compute once per call
        let days:Int = countdown?.day ?? 0
        let hours:Int = countdown?.hour ?? 0
        let minutes:Int = countdown?.minute ?? 0
        let seconds:Int = countdown?.second ?? 0

        if (hours == 0 && minutes == 0 && seconds == 0) || (hours < 0 || minutes < 0 || seconds < 0){
            timer.invalidate()
            appDel.configurationController()
        }
        
        lblsDynamicTime[0].text = "\(days)"
        lblsDynamicTime[1].text = "\(hours)"
        lblsDynamicTime[2].text = "\(minutes)"
        lblsDynamicTime[3].text = "\(seconds)"
    }
    @IBAction func buttonPlusAction(_ sender: Any) {
        if count != 10{
            count += 1
            self.labelCount.text = "\(count)"
        }
    }
    @IBAction func buttonMinusAction(_ sender: Any) {
        if count != 0{
            count -= 1
            self.labelCount.text = "\(count)"
        }
    }
    @IBAction func buttonSubmitAction(_ sender: Any) {
        
        let vc = UIStoryboard.Reward.instantiateViewController(withIdentifier: "TaskSuccessVC") as! TaskSuccessVC
        let draggableVC = DraggableBaseController(showTitleView : true, titleString: "Congratulations!")
        draggableVC.controller = vc
        draggableVC.shouldLetDragToFullScreen = false
        draggableVC.modalPresentationStyle = .overFullScreen
        self.present(draggableVC, animated : false)
        
    }
    @IBAction func buttonNotifyMeAction(_ sender: Any) {
    }
    @IBAction func buttonMoreDescriptionAction(_ sender: Any) {
        self.labelDescriptionValue.numberOfLines = self.labelDescriptionValue.numberOfLines == 0 ? 2 : 0
    }
    
    @IBAction func buttonSoldOutAction(_ sender: Any) {
    }
    
}
extension RedeemDetailVC : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row % 2
        if index == 0{
            let cell  = collectionViewTasks.dequeueReusableCell(withReuseIdentifier: "listCell", for: indexPath) as? OneTimeTaskCollectionViewCell
            cell?.setupOnetimeTaskCellData(gradiantType: .purple)
            return cell!
        }else{
            let cell  = collectionViewTasks.dequeueReusableCell(withReuseIdentifier: "OneTimeTaskCompletedCell", for: indexPath) as? OneTimeTaskCompletedCell
            cell?.setupOnetimeTaskCellData()
            return cell!
        }
    }
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
//MARK: - Scrollview Delegate
extension RedeemDetailVC: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.4) {
            self.viewNavigation.alpha = scrollView.contentOffset.y / 185
            
            if scrollView.contentOffset.y/185 == 1{
                self.viewHeader.navigationBar.lblTitle?.text = "5000 Shiba"
            }else{
                self.viewHeader.navigationBar.lblTitle?.text = ""
            }
        }
    }
}
