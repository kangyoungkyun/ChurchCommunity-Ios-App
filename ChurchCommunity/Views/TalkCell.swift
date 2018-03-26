//
//  TalkCell.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 13..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//



import UIKit

class TalkCell: UITableViewCell {
    
    
    //버튼
    let seeImage: UIButton = {

        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "ic_remove_red_eye.png"), for: .normal)
        //starButton.frame = CGRect(x:0,y:0,width:15,height:15)
        starButton.tintColor = UIColor.lightGray
        starButton.translatesAutoresizingMaskIntoConstraints = false
        return starButton
    }()
    

        //버튼
        let replyImage: UIButton = {
            let starButton = UIButton(type: .system)
            starButton.setImage(#imageLiteral(resourceName: "ic_comment.png"), for: .normal)
            starButton.tintColor = UIColor.lightGray
            starButton.translatesAutoresizingMaskIntoConstraints = false
            return starButton
        }()
        

            //버튼
            let likeButton: UIButton = {
                let starButton = UIButton(type: .system)
                starButton.setImage(#imageLiteral(resourceName: "ic_favorite.png"), for: .normal)
                starButton.tintColor = .lightGray
                starButton.translatesAutoresizingMaskIntoConstraints = false
                return starButton
            }()
            
    //likes
    var likesLabel: UILabel = {
        let label = UILabel()
        label.text = "0 명"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
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
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        return label
    }()
    

    
    //텍스트
    var txtLabel: UILabel = {
        let label = UILabel()
        
                    let paragraphStyle = NSMutableParagraphStyle()
                   //줄 높이
                    paragraphStyle.lineSpacing = 4
        
                    let attribute = NSMutableAttributedString(string: "텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트", attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12),NSAttributedStringKey.foregroundColor:UIColor.black])
                        //줄간격 셋팅
        
                        attribute.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range: NSMakeRange(0, attribute.length))
        
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = attribute
        //label.tag = "pidTag"
        return label
    }()
    //날짜
    var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "1시간전"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //조회수
    var hitLabel: UILabel = {
        let label = UILabel()
        label.text = "6번 읽음"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //댓글 수
    var replyHitLabel: UILabel = {
        let label = UILabel()
        label.text = "15 댓글"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        //선택됐을 때 no hover
        selectionStyle = .none
         addSubview(uidLabel)
        addSubview(pidLabel)
        addSubview(nameLabel)
        addSubview(txtLabel)
        addSubview(dateLabel)
        addSubview(hitLabel)
        addSubview(replyHitLabel)
        
        
        addSubview(seeImage)
         addSubview(replyImage)
        addSubview(likeButton)
        addSubview(likesLabel)
        setLayout()
    }

    
    
    func setLayout(){
        
        nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 15).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        txtLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        txtLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        txtLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15).isActive = true
        txtLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -15).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        
        
        seeImage.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 5).isActive = true
        seeImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15).isActive = true
        seeImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
        seeImage.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        
        
        hitLabel.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 5).isActive = true
        hitLabel.leadingAnchor.constraint(equalTo: seeImage.trailingAnchor, constant: 5).isActive = true
        hitLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        hitLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        
        
        replyImage.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 5).isActive = true
        replyImage.leadingAnchor.constraint(equalTo: hitLabel.trailingAnchor, constant: 15).isActive = true
        replyImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
        replyImage.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        
        replyHitLabel.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 5).isActive = true
        replyHitLabel.leadingAnchor.constraint(equalTo: replyImage.trailingAnchor, constant: 5).isActive = true
        replyHitLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        replyHitLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        
        likeButton.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 5).isActive = true
        likeButton.leadingAnchor.constraint(equalTo: replyHitLabel.trailingAnchor, constant: 15).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 15).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 14).isActive = true
        
        
        likesLabel.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 5).isActive = true
        likesLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 5).isActive = true
        likesLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        likesLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        
        pidLabel.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 5).isActive = true
        pidLabel.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor, constant: 5).isActive = true
        pidLabel.widthAnchor.constraint(equalToConstant: 10).isActive = true
        pidLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        uidLabel.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 5).isActive = true
        uidLabel.leadingAnchor.constraint(equalTo: pidLabel.trailingAnchor, constant: 5).isActive = true
        uidLabel.widthAnchor.constraint(equalToConstant: 10).isActive = true
        uidLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
