//
//  DetailTalkViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 14..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit
import Firebase
class DetailTalkViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var replys = [Reply]()
    let cellId = "cellId"
    

    
    let tableViewFooterView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: 0.5)
          view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    func tableView(_ replyView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if replys.count == 0 {
            return 1
        }
        
        return replys.count
    }
    func tableView(_ replyView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = replyView.dequeueReusableCell(withIdentifier:cellId, for: indexPath) as? ReplyCell
        
        if(replys.count == 0 ){
        cell?.txtLabel.text = "댓글이 없습니다."
        }else{
            cell?.pidLabel.text = replys[indexPath.row].pid
            cell?.ridLable.text = replys[indexPath.row].rid
            cell?.txtLabel.text = replys[indexPath.row].text
            cell?.dateLabel.text = replys[indexPath.row].date
            cell?.nameLabel.text = replys[indexPath.row].name
        }
        
        return cell!
    }
    //셀의 높이
    func tableView(_ replyView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        
    }
    
    //댓글 셀을 선택했을 때
    func tableView(_ replyView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("셀을 선택했습니다~!  \(indexPath.row)")
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //테이블 뷰
    let replyView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.clear
    
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    
    
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
            
            if let replyNum = onePost?.reply{
                replyHitLabel.text = "\(replyNum) 개 댓글"
                 replyLine.text = "  \(replyNum)  댓글"
            }
            
           
            
        }
    }
    
    
    //전체 뷰 : 스크롤뷰
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
        
        let attribute = NSMutableAttributedString(string: "텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍텍스트텍트텍스트텍스트텍스트텍스트텍텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트", attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12),NSAttributedStringKey.foregroundColor:UIColor.black])
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
        label.text = "  댓글"
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
        let replyRef = ref.child("replys").child(replyKey)
        
        
        //데이터 객체 만들기
        let replyInfo: [String:Any] = ["date" : ServerValue.timestamp(),
                                       "text" : textFiedlView.text!,
                                       "name" : Auth.auth().currentUser?.displayName,
                                       "rid": replyKey,
                                       "pid":pidLabel.text!]
        
        //해당 경로에 삽입
        replyRef.setValue(replyInfo)
        
        //============================================== 댓글 달때 초기에 0 이다. 처음 댓글 입력하면 +1 되게 해주는 로직
        
        print("댓글을 삽입합니다 ~~~~~~~~~~~\(replys.count)")
        let replyToShow = Reply() //데이터를 담을 클래스
        //firebase에서 가져온 날짜 데이터를 ios 맞게 변환
        if let t = ServerValue.timestamp() as? TimeInterval {
            let date = NSDate(timeIntervalSince1970: t/1000)
            print("---------------------\(NSDate(timeIntervalSince1970: t/1000))")
            let dayTimePeriodFormatter = DateFormatter()
            dayTimePeriodFormatter.dateFormat = "YYY-MMM-d hh:mm a"
            let dateString = dayTimePeriodFormatter.string(from: date as Date)
            replyToShow.date = dateString
        }
        replyToShow.name = Auth.auth().currentUser?.displayName
        replyToShow.rid = replyKey
        replyToShow.text =  textFiedlView.text!
        replyToShow.pid = pidLabel.text!
        
        self.replys.insert(replyToShow, at: 0) //
        //============================================== 댓글 달때 초기에 0 이다. 처음 댓글 입력하면 +1 되게 해주는 로직 끝==================
        
        
        
        ref.child("posts").child(pidLabel.text!).updateChildValues(["reply": replys.count])
        
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
    
    //진입점
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "수다글"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(goTalkViewController))
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(uiScrollView)
        
        //네비게이션 바 색깔 변경
        self.navigationController?.navigationBar.barTintColor = UIColor.cyan
        self.navigationController?.navigationBar.isTranslucent = false
        
        replyView.delegate = self
        replyView.dataSource = self
        
        replyView.tableFooterView = tableViewFooterView //풋터 뷰
        
        replyView.register(ReplyCell.self, forCellReuseIdentifier: cellId)
        self.replyView.estimatedRowHeight = 80
        self.replyView.rowHeight = UITableViewAutomaticDimension
        
        replyView.showsHorizontalScrollIndicator = false
        replyView.showsVerticalScrollIndicator = false
        
        hideKeyboard()
        setLayout()
        
        fetchReply()
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
        uiScrollView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        //uiScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -3.0).isActive = true
        
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
        uiScrollView.addSubview(replyView)
        
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
        
        
        //-------  * 댓글 감싸는 컨테이너 뷰
        replyContainerView.addSubview(textFiedlView)
        replyContainerView.addSubview(replyButton)
        
        //-------  * 댓글 입력 필드
        textFiedlView.topAnchor.constraint(equalTo: replyContainerView.topAnchor).isActive = true
        textFiedlView.leadingAnchor.constraint(equalTo: replyContainerView.leadingAnchor).isActive = true
        textFiedlView.heightAnchor.constraint(equalTo: replyContainerView.heightAnchor).isActive = true
        textFiedlView.widthAnchor.constraint(equalTo: replyContainerView.widthAnchor, multiplier:4/5).isActive = true
        
        //-------  * 댓글 버튼
        replyButton.topAnchor.constraint(equalTo: replyContainerView.topAnchor).isActive = true
        replyButton.leadingAnchor.constraint(equalTo: textFiedlView.trailingAnchor).isActive = true
        replyButton.heightAnchor.constraint(equalTo: replyContainerView.heightAnchor).isActive = true
        replyButton.widthAnchor.constraint(equalTo: replyContainerView.widthAnchor, multiplier:1/5).isActive = true
        
        //-------  * 댓글 구분선
        replySeperateView.topAnchor.constraint(equalTo: replyContainerView.bottomAnchor, constant:15).isActive = true
        replySeperateView.leadingAnchor.constraint(equalTo: replyContainerView.leadingAnchor).isActive = true
        replySeperateView.trailingAnchor.constraint(equalTo: replyContainerView.trailingAnchor).isActive = true
        replySeperateView.heightAnchor.constraint(equalToConstant: 0.3).isActive = true
        replySeperateView.widthAnchor.constraint(equalTo: replyContainerView.widthAnchor).isActive = true
        
        
        //-------  * 댓글 리스트 뷰
        replyView.topAnchor.constraint(equalTo: replySeperateView.bottomAnchor, constant:15).isActive = true
        replyView.leadingAnchor.constraint(equalTo: uiScrollView.leadingAnchor).isActive = true
        replyView.trailingAnchor.constraint(equalTo: uiScrollView.trailingAnchor).isActive = true
        replyView.widthAnchor.constraint(equalTo: uiScrollView.widthAnchor).isActive = true
        
        replyView.bottomAnchor.constraint(equalTo: uiScrollView.bottomAnchor).isActive = true
        
        
        //스크롤뷰 바닥
        scrollViewBottom.topAnchor.constraint(equalTo: replyContainerView.bottomAnchor, constant: 15).isActive = true
        scrollViewBottom.leadingAnchor.constraint(equalTo: uiScrollView.leadingAnchor, constant: 15).isActive = true
        scrollViewBottom.trailingAnchor.constraint(equalTo: uiScrollView.trailingAnchor, constant: -15).isActive = true
        scrollViewBottom.bottomAnchor.constraint(equalTo: uiScrollView.bottomAnchor,constant: -500).isActive = true
        
        
    }
    
    //댓글 가져오기
    func fetchReply(){
        let ref = Database.database().reference()
        ref.child("replys").queryOrdered(byChild: "date").observe(.value) { (snapshot) in
            self.replys.removeAll() //배열을 안지워 주면 계속 중복해서 쌓이게 된다.
            for child in snapshot.children{
                let replyToShow = Reply() //데이터를 담을 클래스
                let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                //let childKey = childSnapshot.key
                
                if(self.pidLabel.text == childValue["pid"] as? String){
                    if let name = childValue["name"],  let date = childValue["date"], let rid = childValue["rid"], let text = childValue["text"], let pid = childValue["pid"]{
                        
                        //firebase에서 가져온 날짜 데이터를 ios 맞게 변환
                        if let t = date as? TimeInterval {
                            let date = NSDate(timeIntervalSince1970: t/1000)
                            print("---------------------\(NSDate(timeIntervalSince1970: t/1000))")
                            let dayTimePeriodFormatter = DateFormatter()
                            dayTimePeriodFormatter.dateFormat = "YYY-MMM-d hh:mm a"
                            let dateString = dayTimePeriodFormatter.string(from: date as Date)
                            replyToShow.date = dateString
                        }
                        replyToShow.name = name as? String
                        replyToShow.rid = rid as? String
                        replyToShow.text = text as? String
                        replyToShow.pid = pid as? String
                    }
                    self.replys.insert(replyToShow, at: 0) //
                }
            }
            self.replyView.reloadData()
        }
        
        ref.removeAllObservers()
    }
    
}


