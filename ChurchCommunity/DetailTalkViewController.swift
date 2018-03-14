//
//  DetailTalkViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 14..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit

class DetailTalkViewController: UIViewController {
   

    
    var uiScrollView: UIScrollView = {
        let uiscroll = UIScrollView()
 
        uiscroll.translatesAutoresizingMaskIntoConstraints = false
        uiscroll.showsHorizontalScrollIndicator = false
        uiscroll.showsVerticalScrollIndicator = false

        return uiscroll
    }()
    
    //이름
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
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
        
        let attribute = NSMutableAttributedString(string: "텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍텍스트텍스트텍스트텍스트텍스트텍스트텍텍스트텍스트텍스트텍스트텍스트텍텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트", attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12),NSAttributedStringKey.foregroundColor:UIColor.black])
        //줄간격 셋팅
        
        attribute.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range: NSMakeRange(0, attribute.length))
        
        
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = attribute
        return label
    }()
    //날짜
    var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "1시간전"
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //조회수
    var hitLabel: UILabel = {
        let label = UILabel()
        label.text = "6번 읽음"
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //댓글 수
    var replyHitLabel: UILabel = {
        let label = UILabel()
        label.text = "15 댓글"
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //댓글라인
    var replyLine: UILabel = {
        let label = UILabel()
        label.text = "댓글"
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.backgroundColor = UIColor.brown
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //스크롤뷰 바텀
    var scrollViewBottom: UILabel = {
        let label = UILabel()
     
        label.backgroundColor = UIColor.blue
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "수다글"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(goTalkViewController))
        
       self.view.backgroundColor = UIColor.white
    
        self.view.addSubview(uiScrollView)
        
        setLayout()
    }
    
    //수다방으로 가기
    @objc func goTalkViewController(){
        
        navigationController?.popViewController(animated: true)
    }
    
    //레이아웃 조정
    func  setLayout(){
        
        uiScrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 13.0).isActive = true
        uiScrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 3.0).isActive = true
        uiScrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -13.0).isActive = true
        uiScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -3.0).isActive = true
        //uiScrollView.heightAnchor.constraint(equalToConstant: 1000).isActive = true
   
        uiScrollView.addSubview(nameLabel)
        uiScrollView.addSubview(txtLabel)
        uiScrollView.addSubview(dateLabel)
        uiScrollView.addSubview(hitLabel)
        uiScrollView.addSubview(replyHitLabel)
        uiScrollView.addSubview(replyLine)
        uiScrollView.addSubview(scrollViewBottom)
        
        nameLabel.topAnchor.constraint(equalTo: uiScrollView.topAnchor, constant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: uiScrollView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: uiScrollView.trailingAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: txtLabel.topAnchor, constant: -15).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: uiScrollView.widthAnchor).isActive = true
        
 
        txtLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        txtLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        txtLabel.trailingAnchor.constraint(equalTo: uiScrollView.trailingAnchor).isActive = true
        //txtLabel.bottomAnchor.constraint(equalTo: hitLabel.topAnchor, constant: 5).isActive = true
        //txtLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor ,constant: 15).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: txtLabel.trailingAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo:txtLabel.topAnchor, constant: -15).isActive = true
        
        
        hitLabel.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 15).isActive = true
        hitLabel.leadingAnchor.constraint(equalTo: uiScrollView.leadingAnchor).isActive = true
        hitLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        hitLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        //hitLabel.bottomAnchor.constraint(equalTo: replyLine.topAnchor).isActive = true
        
        replyHitLabel.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 15).isActive = true
        replyHitLabel.leadingAnchor.constraint(equalTo: hitLabel.trailingAnchor, constant: 15).isActive = true
        replyHitLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        replyHitLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        //replyHitLabel.bottomAnchor.constraint(equalTo: replyLine.topAnchor).isActive = true
        
        
        replyLine.topAnchor.constraint(equalTo: hitLabel.bottomAnchor, constant: 35).isActive = true
        //replyLine.centerYAnchor.constraint(equalTo: uiScrollView.centerYAnchor).isActive = true
        replyLine.centerXAnchor.constraint(equalTo: uiScrollView.centerXAnchor).isActive = true
        replyLine.widthAnchor.constraint(equalTo: uiScrollView.widthAnchor).isActive = true
        replyLine.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
 
        scrollViewBottom.topAnchor.constraint(equalTo: replyLine.bottomAnchor, constant: 15).isActive = true
        scrollViewBottom.leadingAnchor.constraint(equalTo: uiScrollView.trailingAnchor, constant: 15).isActive = true
        scrollViewBottom.trailingAnchor.constraint(equalTo: uiScrollView.trailingAnchor, constant: 15).isActive = true
        scrollViewBottom.bottomAnchor.constraint(equalTo: uiScrollView.bottomAnchor,constant: -500).isActive = true
        
        
     
    }


}
