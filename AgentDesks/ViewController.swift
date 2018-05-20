//
//  ViewController.swift
//  AgentDesks
//
//  Created by Mathew Wong on 5/17/18.
//  Copyright © 2018 yidgetsoft. All rights reserved.
//

import UIKit
import SnapKit
import CoreData
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Property Picker"
        self.view.backgroundColor = .white


        let myLabel:UILabel = UILabel()
        myLabel.text = "Welcome back to iOS Mathew!"
        myLabel.textColor = .black
        myLabel.textAlignment = .center

        let myButton:UIButton = UIButton()
        myButton.setTitle("Plox", for: .normal)
        myButton.setTitleColor(UIColor.blue, for: .normal)
        myButton.addTarget(self, action: #selector(self.ploxinate), for: .touchUpInside)

        self.view.addSubview(myLabel)
        self.view.addSubview(myButton)

        myLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.view)
        }
        
        myButton.snp.makeConstraints { (make) in
            make.top.equalTo(myLabel.snp.bottom)
            make.centerX.equalTo(self.view)
        }

        let d = APIDataService()
        d.process()
        d.coreDataService.finalDataChanged.subscribe(onNext: { dictionary in
            print(dictionary)
        })
    }

    @objc func ploxinate(sender: UIButton) {
        NSLog("pwet")
    }
}

