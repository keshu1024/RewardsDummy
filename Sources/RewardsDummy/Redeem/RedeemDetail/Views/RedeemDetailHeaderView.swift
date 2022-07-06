//
//  AppHeaderView.swift
//  CrowdBook
//
//  Created by BCS Member on 20/08/21.
//

import UIKit

@IBDesignable class RedeemDetailHeaderView: UIView {
    
    let nibName = "RedeemDetailHeaderView"
    
    @IBOutlet weak var buttonBack: UIButton!
    @IBOutlet weak var imageRedeemHeader: UIImageView!
    @IBOutlet weak var viewContainer: AppLinearGradientView!
    
    var contentView:UIView?
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
    }
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
