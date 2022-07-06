//
//  TaskRulesVC.swift
//  Cardex
//
//  Created by BCS Member on 24/06/22.
//  Copyright © 2022 Jainesh. All rights reserved.
//

import UIKit

class TaskRulesVC: BaseVC, ControllerInitialSetupDelegate {

    
    @IBOutlet weak var headingLabel : UILabel!
    @IBOutlet weak var descriptionLabel : UILabel!
    
    @IBOutlet weak var submitBtn : AppButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
        setupViews()
        initialSetup()
    }
    
    
    func setLabels() {
        headingLabel.font = .subHeading(of17: .bold)
        descriptionLabel.font = .regular(of15: .regular)
        descriptionLabel.numberOfLines = 0
        headingLabel.text = "Task Description"
        let descriptionString = "● Lorem ipsum is dummy text for typing industry since years \n ● Lorem ipsum is dummy text for typing industry since years \n ● Lorem ipsum is dummy text for typing industry since years \n ● Lorem ipsum is dummy text for typing industry since years \n ● Lorem ipsum is dummy text for typing industry since years \n ● Lorem ipsum is dummy text for typing industry since years \n ● Lorem ipsum is dummy text for typing industry since years \n ● Lorem ipsum is dummy text for typing industry since years \n ● Lorem ipsum is dummy text for typing industry since years \n ● Lorem ipsum is dummy text for typing industry since years \n ● Lorem ipsum is dummy text for typing industry since years \n ● Lorem ipsum is dummy text for typing industry since years \n ● Lorem ipsum is dummy text for typing industry since years \n"
        descriptionLabel.text = descriptionString
        
    }
    
    func setupViews() {
        
    }
    
    func initialSetup() {
    
    }
    
    

}
