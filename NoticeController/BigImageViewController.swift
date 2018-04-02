//
//  BigImageViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 21..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit

class BigImageViewController: UIViewController {

    //테이블 셀에 이미지 뷰 객체 추가
    let noticeImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        //imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        self.navigationController?.navigationBar.isTranslucent = false
        //navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "사진방"
        
        view.addSubview(noticeImageView)
        
        noticeImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        noticeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        noticeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        noticeImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
    }





}
