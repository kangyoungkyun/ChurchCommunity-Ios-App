//
//  MemoryCell.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 20..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit

class MemoryCell: UITableViewCell {

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        let f = contentView.frame
//        let fr = UIEdgeInsetsInsetRect(f, UIEdgeInsetsMake(10, 10, 10, 10))
//        contentView.frame = fr
//    }
   // override func didMoveToSuperview() {
   //     super.didMoveToSuperview()
   //     layoutIfNeeded()
  //  }
    
    
    //테이블 셀에 이미지 뷰 객체 추가
    let myImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
        
    }()
    
    let uidLable: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        //위에서 만든 객체 테이블 뷰 셀에 넣어주기
        addSubview(myImageView)
        addSubview(uidLable)
     
        //self.backgroundColor = UIColor.blue

        
        //셀에서 이미지 제약조건 설정해주기
        myImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        myImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: -10).isActive = true
        myImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        myImageView.bottomAnchor.constraint(equalTo: uidLable.topAnchor).isActive = true
       //  myImageView.heightAnchor.constraint(equalTo: self.frame.size.height - uidLable.frame.size.height).isActive = true
 myImageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        uidLable.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        uidLable.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        //uidLable.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 5).isActive = true
        uidLable.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
