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
    
    //사진 id
    var noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "ythmg"
        label.isHidden = true
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //이름
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "박정현 목사"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //날짜
    var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "18.3.16"
        label.font = UIFont.systemFont(ofSize: 12)
        //label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let noticeSeperateView :UIView = {
        let containerView = UIView()
        //containerView.backgroundColor = UIColor.cyan
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor.lightGray
        return containerView
    }()
    
    
    //테이블 셀에 이미지 뷰 객체 추가
    let noticeImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        //imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("CategoryCell - init - setupViews호출")
        addSubview(noticeImageView)
        //addSubview(noticeLabel)
        //addSubview(nameLabel)
        //addSubview(dateLabel)
       // addSubview(noticeSeperateView)
        
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
       // noticeImageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 0).isActive = true
/*
        nameLabel.topAnchor.constraint(equalTo: noticeImageView.bottomAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        //nameLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: noticeSeperateView.topAnchor, constant: -5).isActive = true
        
        
        dateLabel.topAnchor.constraint(equalTo: noticeImageView.bottomAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        dateLabel.widthAnchor.constraint(equalToConstant: 120).isActive = true
        //dateLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: noticeSeperateView.topAnchor, constant: -5).isActive = true
        
        
        noticeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        noticeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        noticeLabel.widthAnchor.constraint(equalToConstant: 15).isActive = true
        noticeLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        //noticeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        
       
        //noticeSeperateView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: -10).isActive = true
        noticeSeperateView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        noticeSeperateView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
        noticeSeperateView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        noticeSeperateView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
        */
        
        
    }

    
    
}
