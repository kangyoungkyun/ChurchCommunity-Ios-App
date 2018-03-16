//
//  NoticeCell.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 16..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit

class NoticeCell: UICollectionViewCell {
   
    private let cellId = "appCellId"
    //테이블 셀에 이미지 뷰 객체 추가
    let noticeImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
        
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("CategoryCell - init - setupViews호출")
        addSubview(noticeImageView)
     

        
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout(){
        //셀에서 이미지 제약조건 설정해주기
   
        noticeImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        noticeImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        noticeImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        noticeImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true

    }

    
    
}
