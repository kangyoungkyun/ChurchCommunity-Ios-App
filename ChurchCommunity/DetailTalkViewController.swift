//
//  DetailTalkViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 14..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit
import Firebase
class DetailTalkViewController: UIViewController {
   
    //넘어온 데이터
    var onePost : Post?{
        didSet{
            nameLabel.text = onePost?.name
            txtLabel.text = onePost?.text
            
            if let hit = onePost?.hit{
                 hitLabel.text = "\(hit) 번 읽음"
            }
           
            dateLabel.text = onePost?.date
            pidLabel.text = onePost?.pid
        }
    }
    

    
    var uiScrollView: UIScrollView = {
        let uiscroll = UIScrollView()
 
        uiscroll.translatesAutoresizingMaskIntoConstraints = false
        uiscroll.showsHorizontalScrollIndicator = false
        uiscroll.showsVerticalScrollIndicator = false

        return uiscroll
    }()
    
    //pid
    var pidLabel: UILabel = {
        let label = UILabel()
        //label.text = "pid"
        label.isHidden = true
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    
    //댓글라인구분선 =====================================================
    var replyLine: UILabel = {
        let label = UILabel()
        label.text = " 댓글"
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.backgroundColor = UIColor.cyan
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 13
        label.clipsToBounds = true
        return label
    }()
    
    //댓글 레이아웃 containerView
    let replyContainerView :UIView = {
        let containerView = UIView()
        //containerView.backgroundColor = UIColor.cyan
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
        return containerView
    }()
    
    
    //댓글남기기.
    var placeholderLabel : UILabel = {
        let ph = UILabel()
        ph.text = "댓글 남기기:)"
        ph.font = UIFont.systemFont(ofSize: 18)
         //ph.translatesAutoresizingMaskIntoConstraints = false
        ph.sizeToFit()
        return ph
    }()
    
    
    //댓글쓰기 텍스트 필드
    let textFiedlView : UITextView = {
        let tf = UITextView()
        //tf.backgroundColor = UIColor.brown
        tf.backgroundColor = UIColor.lightGray
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.tintColor = .black
        tf.font = UIFont.systemFont(ofSize: 16)
        tf.alpha = 0.2
        tf.textColor = .black
        //키보드 항상 보이게
        //tf.becomeFirstResponder()
        return tf
    }()
    
    //댓글 버튼
    let replyButton : UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("쓰기", for: UIControlState())
        btn.backgroundColor = UIColor.cyan
        btn.addTarget(self, action: #selector(replyBtnAction), for: .touchUpInside)
        return btn
    }()
    
    //댓글 버튼 작동
    @objc func replyBtnAction(){
        print("댓글 버튼 작동 \(textFiedlView.text!)")
        
        //데이터 베이스 참조 함수
        var ref: DatabaseReference!
        ref = Database.database().reference()
        
        //랜덤 키
        let replyKey = ref.child("replys").childByAutoId().key
        let replyRef = ref.child("replys").child(pidLabel.text!)

        
        //데이터 객체 만들기
        let replyInfo: [String:Any] = ["date" : ServerValue.timestamp(),
                                      "text" : textFiedlView.text!,
                                      "name" : Auth.auth().currentUser?.displayName,
                                      "rid": replyKey]
 
        //해당 경로에 삽입
        replyRef.setValue(replyInfo)
        
        ref.removeAllObservers()
        
        textFiedlView.text = ""
    }
    
    
    
    //구분선
    let replySeperateView :UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.lightGray
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
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
        
        //네비게이션 바 색깔 변경
        self.navigationController?.navigationBar.barTintColor = UIColor.cyan
        self.navigationController?.navigationBar.isTranslucent = false
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
        
        uiScrollView.addSubview(pidLabel)
        uiScrollView.addSubview(nameLabel)
        uiScrollView.addSubview(txtLabel)
        uiScrollView.addSubview(dateLabel)
        uiScrollView.addSubview(hitLabel)
        uiScrollView.addSubview(replyHitLabel)
        uiScrollView.addSubview(replyLine)
        uiScrollView.addSubview(replyContainerView)
        uiScrollView.addSubview(replySeperateView)
        uiScrollView.addSubview(scrollViewBottom)
        
        nameLabel.topAnchor.constraint(equalTo: uiScrollView.topAnchor, constant: 20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: uiScrollView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: uiScrollView.trailingAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: txtLabel.topAnchor, constant: -15).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: uiScrollView.widthAnchor).isActive = true
        
 

        txtLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        txtLabel.trailingAnchor.constraint(equalTo: uiScrollView.trailingAnchor).isActive = true

        dateLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: txtLabel.trailingAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        
        hitLabel.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 30).isActive = true
        hitLabel.leadingAnchor.constraint(equalTo: uiScrollView.leadingAnchor).isActive = true
        hitLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        hitLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
       
        
        replyHitLabel.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 30).isActive = true
        replyHitLabel.leadingAnchor.constraint(equalTo: hitLabel.trailingAnchor, constant: 15).isActive = true
        replyHitLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        replyHitLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        pidLabel.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 5).isActive = true
        pidLabel.leadingAnchor.constraint(equalTo: replyHitLabel.trailingAnchor, constant: 15).isActive = true
        pidLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        pidLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true

        
        
        replyLine.topAnchor.constraint(equalTo: hitLabel.bottomAnchor, constant: 35).isActive = true
        replyLine.centerXAnchor.constraint(equalTo: uiScrollView.centerXAnchor).isActive = true
        replyLine.widthAnchor.constraint(equalTo: uiScrollView.widthAnchor).isActive = true
        replyLine.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    

        replyContainerView.topAnchor.constraint(equalTo: replyLine.bottomAnchor, constant: 5).isActive = true
        replyContainerView.centerXAnchor.constraint(equalTo: uiScrollView.centerXAnchor).isActive = true
        replyContainerView.widthAnchor.constraint(equalTo: uiScrollView.widthAnchor).isActive = true
        replyContainerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        replyContainerView.addSubview(textFiedlView)
        replyContainerView.addSubview(replyButton)
         //replyContainerView.addSubview(seperateView)
        
        textFiedlView.topAnchor.constraint(equalTo: replyContainerView.topAnchor).isActive = true
        textFiedlView.leadingAnchor.constraint(equalTo: replyContainerView.leadingAnchor).isActive = true
        textFiedlView.heightAnchor.constraint(equalTo: replyContainerView.heightAnchor).isActive = true
        textFiedlView.widthAnchor.constraint(equalTo: replyContainerView.widthAnchor, multiplier:4/5).isActive = true
        
        replyButton.topAnchor.constraint(equalTo: replyContainerView.topAnchor).isActive = true
        replyButton.leadingAnchor.constraint(equalTo: textFiedlView.trailingAnchor).isActive = true
        replyButton.heightAnchor.constraint(equalTo: replyContainerView.heightAnchor).isActive = true
        replyButton.widthAnchor.constraint(equalTo: replyContainerView.widthAnchor, multiplier:1/5).isActive = true
        
        
        replySeperateView.topAnchor.constraint(equalTo: replyContainerView.bottomAnchor, constant:15).isActive = true
        replySeperateView.leadingAnchor.constraint(equalTo: replyContainerView.leadingAnchor).isActive = true
        replySeperateView.trailingAnchor.constraint(equalTo: replyContainerView.trailingAnchor).isActive = true
        replySeperateView.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        replySeperateView.widthAnchor.constraint(equalTo: replyContainerView.widthAnchor).isActive = true
        
        
        
        scrollViewBottom.topAnchor.constraint(equalTo: replyContainerView.bottomAnchor, constant: 15).isActive = true
        scrollViewBottom.leadingAnchor.constraint(equalTo: uiScrollView.leadingAnchor, constant: 15).isActive = true
        scrollViewBottom.trailingAnchor.constraint(equalTo: uiScrollView.trailingAnchor, constant: -15).isActive = true
        scrollViewBottom.bottomAnchor.constraint(equalTo: uiScrollView.bottomAnchor,constant: -500).isActive = true
        
        
     
    }


}
