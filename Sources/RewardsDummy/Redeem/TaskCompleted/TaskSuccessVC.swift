//
//  TaskSuccessVC.swift
//  Cardex
//
//  Created by BCS Member on 24/06/22.
//  Copyright © 2022 Jainesh. All rights reserved.
//

import UIKit

class TaskSuccessVC: UIViewController , ControllerInitialSetupDelegate {

    @IBOutlet weak var totalClaimedLabel : UILabel!
    @IBOutlet weak var totalClaimedValueLabel : UILabel!
    
    @IBOutlet weak var descriptionLabel : UILabel!
    @IBOutlet weak var okBtn : AppButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setLabels()
        setupViews()
        initialSetup()
    }
    
    func setLabels() {
        totalClaimedLabel.font = .extraSmall(of10: .regular)
        totalClaimedValueLabel.font = .subHeading(of17: .bold)
        descriptionLabel.font = .small(of12: .regular)
    }
    
    func setupViews() {
        
    }
    
    func initialSetup() {
        
    }
    
}
