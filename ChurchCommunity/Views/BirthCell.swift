//
//  BirthCell.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 19..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit

class BirthCell: UITableViewCell {

    // self.profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
    
    var uid:String?{
        didSet{
            self.uidLable.text = uid
        }
    }
    
    var name:String?{
        didSet{
            self.textLabel?.text = name
        }
    }

    var imageUrl:String?{
        didSet{
            self.profileImageView.downloadImage(from: imageUrl)
        }
    }
    
    var date:String?{
        didSet{
            self.textLabel?.text = date
            self.textLabel?.textColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

              self.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        }
    }

//부모 uitableviewcell 오버라이드 해서 재구성
override func layoutSubviews() {
    super.layoutSubviews()
    //테이블에 라벨 위치와 크기 설정 해주기
    textLabel?.frame = CGRect(x: 64, y:textLabel!.frame.origin.y - 2 ,width:textLabel!.frame.width ,height:textLabel!.frame.height )
    detailTextLabel?.frame = CGRect(x: 64, y:detailTextLabel!.frame.origin.y + 4, width:detailTextLabel!.frame.width ,height:detailTextLabel!.frame.height )
    self.textLabel?.textColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

    self.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
    
}




//테이블 셀에 이미지 뷰 객체 추가
let profileImageView: UIImageView = {
    
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 24
    imageView.layer.masksToBounds = true
    imageView.contentMode = .scaleAspectFill
    return imageView
    
}()

    let uidLable: UILabel = {
        
        let label = UILabel()
        //label.text = "hh:mm:ss"
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    //위에서 만든 객체 테이블 뷰 셀에 넣어주기
    addSubview(profileImageView)
    addSubview(uidLable)
    //addSubview(tableViewFooterV)
    
    //셀에서 이미지 제약조건 설정해주기
    profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8).isActive = true
    profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    profileImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
    profileImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    
    uidLable.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    uidLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 18).isActive = true
    uidLable.widthAnchor.constraint(equalToConstant: 100).isActive = true
    uidLable.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true

}

required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}

}
