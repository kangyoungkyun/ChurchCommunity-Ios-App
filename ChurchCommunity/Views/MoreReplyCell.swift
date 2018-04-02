//
//  MoreReplyCell.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 19..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit

class MoreReplyCell: UITableViewCell {


    //uid
    var uidLabel: UILabel = {
        let label = UILabel()
        label.text = "uid"
        label.isHidden = true
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //pid
    var pidLabel: UILabel = {
        let label = UILabel()
        label.text = "pid"
        label.isHidden = true
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //이름
    var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        label.text = "앗.."
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //텍스트
    var txtLabel: UILabel = {
        let label = UILabel()
        
        let paragraphStyle = NSMutableParagraphStyle()
        //줄 높이
        paragraphStyle.lineSpacing = 4
        
        let attribute = NSMutableAttributedString(string: "텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트", attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12),NSAttributedStringKey.foregroundColor:UIColor(red:0.20, green:0.20, blue:0.20, alpha:1.0)])
        //줄간격 셋팅
        
        attribute.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range: NSMakeRange(0, attribute.length))
        
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = attribute
        //label.tag = "pidTag"
        return label
    }()
    
    //날짜
    var dateLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //리플 아이디
    var ridLable: UILabel = {
        let label = UILabel()
        label.isHidden = true
        label.text = "rid"
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //--------------------------------
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        //선택됐을 때 no hover
        selectionStyle = .none
        addSubview(pidLabel)
        addSubview(uidLabel)
        addSubview(nameLabel)
        addSubview(txtLabel)
        addSubview(dateLabel)
        addSubview(ridLable)
        setLayout()
        
    }
    
    
    
    func setLayout(){
        
        
        ridLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        ridLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        ridLable.widthAnchor.constraint(equalToConstant: 40).isActive = true
        ridLable.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        
        pidLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        pidLabel.leadingAnchor.constraint(equalTo: ridLable.trailingAnchor, constant: 15).isActive = true
        pidLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        pidLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        uidLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        uidLabel.leadingAnchor.constraint(equalTo: pidLabel.trailingAnchor, constant: 15).isActive = true
        uidLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
        uidLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        
        nameLabel.topAnchor.constraint(equalTo: self.ridLable.bottomAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        txtLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant:15).isActive = true
        txtLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        txtLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        txtLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant:-10).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -15).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
