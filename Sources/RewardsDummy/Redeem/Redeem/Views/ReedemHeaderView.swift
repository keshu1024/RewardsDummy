//
//  AppHeaderView.swift
//  CrowdBook
//
//  Created by BCS Member on 20/08/21.
//

import UIKit

@IBDesignable class ReedemHeaderView: UIView {
    
    let nibName = "ReedemHeaderView"
    
    @IBOutlet weak var viewBalance: ShadowView!
    @IBOutlet weak var viewPoints: ShadowView!
    @IBOutlet weak var labelWalletBalanceTitle: UILabel!
    @IBOutlet weak var labelWalletBalanceValue: UILabel!
    @IBOutlet weak var labelIxfiPointsTitle: UILabel!
    @IBOutlet weak var labelIxfiPointsValue: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var viewContainer: UIView!
    
//    @IBInspectable var graySearchBar: Bool = false {
//        didSet {
//            if graySearchBar{
//                self.viewTextfieldContainer.backgroundColor = .getGrayBg()
//            }else{
//                self.viewTextfieldContainer.backgroundColor = .getAppWhite()
//            }
//        }
//    }
    
    var contentView:UIView?
//    lazy var textFieldDidChange:(String)->() = {_ in }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
    }
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
        contentView = view
        self.layoutIfNeeded()
        setLabel()
    }
    func setLabel(){
        self.labelTitle.font = .heading(of20: .poppinsBold)
        self.labelIxfiPointsValue.font = .subHeading(of17: .bold)
        self.labelWalletBalanceValue.font = .subHeading(of17: .bold)
        
        self.labelIxfiPointsTitle.font = .extraSmall(of10: .regular)
        self.labelWalletBalanceTitle.font = .extraSmall(of10: .regular)
    }
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
//    @IBAction func buttonClearSearchAction(_ sender: Any) {
//        self.textfieldSearch.text = ""
//        textFieldDidChange(self.textfieldSearch.text!)
//    }
//    @objc func buttonTextChangedHandler(){
//        textFieldDidChange(self.textfieldSearch.text!)
//    }
    
}
