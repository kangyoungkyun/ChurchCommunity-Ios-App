//
//  MyPageVC.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 23..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit

class MyPageVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.22, green:0.78, blue:0.20, alpha:1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "마이페이지"
    }


}
