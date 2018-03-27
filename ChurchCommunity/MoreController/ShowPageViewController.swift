//
//  UserPageViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 17..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//  유저 페이지

import UIKit
import Firebase
class ShowPageViewController: UIViewController {
    var activityIndicatorView: UIActivityIndicatorView!
    var userUid: String?
    var dotoriTotal  = 0

    let sendMsgImage: UIButton = {
        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "ic_send.png"), for: .normal)
        
    
        starButton.translatesAutoresizingMaskIntoConstraints = false
        starButton.isEnabled = false
        return starButton
    }()
    
    let getMsgImage: UIButton = {
        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "getmsg.png"), for: .normal)
        starButton.tintColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)
        starButton.isEnabled = false
        starButton.translatesAutoresizingMaskIntoConstraints = false
        return starButton
    }()
    
    let giftImage: UIButton = {
        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "gift.png"), for: .normal)
        starButton.tintColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)
        starButton.isEnabled = false
        starButton.translatesAutoresizingMaskIntoConstraints = false
        return starButton
    }()
    
    //이름
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        return label
    }()
    
    
    //댓글수
    var birthLabel: UILabel = {
        let label = UILabel()
        label.text = "영성일기"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        return label
    }()
    
    //작성댓글
    var mesageLabel: UILabel = {
        let label = UILabel()
        label.text = "작성댓글"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        return label
    }()
    
    //==================================================================================
    
    //이름 텍스트 필드 객체 만들기
    let nameTextField: UITextField = {
        let tf = UITextField()
        //tf.placeholder = "이름"
        tf.isEnabled = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    //이름 구분선 만들기
    let nameSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //==================================================================================
    //글수 텍스트 필드
    let birthTextField : UITextField = {
        let tf = UITextField()
        tf.isEnabled = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    //글수 구분선 만들기
    let birthSeperatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //==================================================================================
    
    
    //댓글수 텍스트 필드 객체 만들기
    let mesageTextField: UITextField = {
        let tf = UITextField()
        tf.isEnabled = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    //구분선 만들기
    let mesageSeperatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //보낸메시지
    lazy var sendMsgLabel: UILabel = {
        let label = UILabel()
        label.text = "  보낸쪽지:  "
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.backgroundColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        label.layer.cornerRadius = 7
        label.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(sendMesage))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    //보낸 메시지함이 클릭되었을 때
    @objc func sendMesage(){
        print("보낸메시지함")
        let viewController = SendMessageVC()
        let navController = UINavigationController(rootViewController: viewController)
        self.present(navController, animated: true, completion: nil)
    }
    
    //받은 메시지
    lazy var getMsgLabel: UILabel = {
        let label = UILabel()
        label.text = "  받은쪽지:  "
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        label.layer.cornerRadius = 7
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(getMesage))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    //보낸 메시지함이 클릭되었을 때
    @objc func getMesage(){
        print("받은 메시지함")
        let viewController = GetMessageVC()
        let navController = UINavigationController(rootViewController: viewController)
        self.present(navController, animated: true, completion: nil)
    }
    
    
    // ========================================= 쪽지보내기 버튼  =========================================
//    //쪽지보내기 버튼
//    var sendBtn: UIButton = {
//        let sendBtn = UIButton()
//        sendBtn.setTitle("쪽지보내기", for: UIControlState())
//        //sendBtn.font = UIFont.boldSystemFont(ofSize: 17)
//        sendBtn.setTitleColor(UIColor.white, for: UIControlState())
//        sendBtn.backgroundColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)
//
//        sendBtn.layer.cornerRadius = 7
//        sendBtn.clipsToBounds = true
//        sendBtn.translatesAutoresizingMaskIntoConstraints = false
//        sendBtn.addTarget(self, action: #selector(sendMesageBtnAction), for: .touchUpInside)
//        return sendBtn
//    }()
//    //쪽지보내기 버튼 클릭
//    @objc func sendMesageBtnAction(){
//        print("쪽지보내기 버튼 클릭")
//
//        let myUid = Auth.auth().currentUser?.uid
//        let myName = Auth.auth().currentUser?.displayName
//
//
//        let alertController = UIAlertController(
//            title: nil,
//            message: nil,
//            preferredStyle: .alert)
//
//        let modifyAction = UIAlertAction(title: "쪽지보내기", style: .default) { (alert) in
//            print("쪽지보내기")
//
//            //나에게 보내기
//            self.sendMsgController(toid: myUid!, toname: myName!, fromid: myUid!, fromname: myName!)
//
//        }
//
//        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (alert) in
//            print("취소")
//        }
//        alertController.addAction(cancelAction)
//        alertController.addAction(modifyAction)
//
//
//        self.present(
//            alertController,
//            animated: true,
//            completion: nil)
//    }
    
    // ========================================= 출석체크 버튼  =========================================
    //출석체크내기 버튼
    var todayCheckBtn: UIButton = {
        let sendBtn = UIButton()
        sendBtn.setTitle("매일영성점검", for: UIControlState())
        //sendBtn.font = UIFont.boldSystemFont(ofSize: 17)
        sendBtn.setTitleColor(UIColor.white, for: UIControlState())
        sendBtn.backgroundColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        sendBtn.layer.cornerRadius = 7
        sendBtn.clipsToBounds = true
        sendBtn.translatesAutoresizingMaskIntoConstraints = false
        sendBtn.addTarget(self, action: #selector(todayCheckBtnAction), for: .touchUpInside)
        return sendBtn
    }()
    
    //출석체크 버튼 클릭
    @objc func todayCheckBtnAction(){
        
        var currentDotori = 0
        //var todayAlreadyCheck = false
        print("출석체크 보내기 버튼 클릭")
        
        let myId = Auth.auth().currentUser?.uid
        let myName = Auth.auth().currentUser?.displayName
        let ref = Database.database().reference()
        let today = getSingle() //오늘 날짜
        
        
        //출석체크를 클릭했을 때 firebase에 값을 가져와서 있는지 없는지 조사
        ref.child("todaycheck").child(today).child(myId!).observe(.value) { (snapshot) in

            if(snapshot.childrenCount == 0){
                
                print("오늘 처음 출첵")
                //출석체크 데이터 Ref
                let todayRef = ref.child("todaycheck").child(today).child(myId!)
                //데이터 객체 만들기
                let todayCheckInfo: [String:Any] = ["uid" : myId!]
                //해당 경로에 삽입
                todayRef.setValue(todayCheckInfo)
                
                
                //도토리 계산
                currentDotori = self.dotoriTotal + 10
                let dotoriRef = ref.child("dotori").child(myId!)
                let dotoriInfo: [String:Any] = ["total" : currentDotori,
                                                "name" : myName!,
                                                "uid" : myId!]
                
                dotoriRef.setValue(dotoriInfo)
                let alert = UIAlertController(title: "축하합니다.", message:"오늘의 달란트가 적립되었습니다.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                 print("이미 추가됨")
                let childValue = snapshot.value as! [String:Any] //자식의 value 값 가져오기
                if let uid = childValue["uid"] as? String{
                    if (uid == myId!){
                        //같은 아이디가 있으면 도토리 적립 취소
                        let alertAlready = UIAlertController(title: "알림", message:"달란트가 이미 적립되었습니다.", preferredStyle: UIAlertControllerStyle.alert)
                        
                        alertAlready.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: { (alert) in
                            ref.removeAllObservers()
                        }))
                        self.present(alertAlready, animated: true, completion: nil)
                        
                        
                    }
                }
                
            }
        }
        ref.removeAllObservers()
        


    }
    
    
    //현재 날짜
    func getSingle() -> String{
        let date = Date()
        let calendar = Calendar.current //켈린더 객체 생성
        let month = calendar.component(.month, from: date)  //월
        let day = calendar.component(.day, from: date)      //일
        return "\(month)\(day)"
    }
     //========================================= 도토리 =========================================
    
    //도토리 라벨
    var dotoriLabel: UILabel = {
        let label = UILabel()
        label.text = "달란트"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        return label
    }()
    
   
    
    //도토리 텍스트 필드
    let dotoriTextField: UITextField = {
        let tf = UITextField()
        tf.text = "0 개"
        tf.isEnabled = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    //도토리 구분선
    let dotoriSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        self.navigationItem.title = "마이페이지"
        //취소 바 버튼
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(cancelAction))
        
        view.backgroundColor = UIColor.white
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -80).isActive = true
        activityIndicatorView.bringSubview(toFront: self.view)
        activityIndicatorView.startAnimating()
        
        print("start 인디케이터")
        
        DispatchQueue.main.async {
           
            OperationQueue.main.addOperation() {

                Thread.sleep(forTimeInterval: 1.5)
                print("start forTimeInterval")
                self.activityIndicatorView.stopAnimating()
            }
        }
        
        self.view.addSubview(nameLabel)
        
        self.view.addSubview(birthLabel)
        self.view.addSubview(mesageLabel)
        
        self.view.addSubview(nameTextField)
        
        self.view.addSubview(birthTextField)
        self.view.addSubview(mesageTextField)
        
        self.view.addSubview(nameSeperatorView)
        
        self.view.addSubview(birthSeperatorView)
        self.view.addSubview(mesageSeperatorView)
        
        self.view.addSubview(getMsgLabel)
        self.view.addSubview(sendMsgLabel)
        self.view.addSubview(todayCheckBtn)
        //self.view.addSubview(sendBtn)
        
        self.view.addSubview(dotoriLabel)
        self.view.addSubview(dotoriTextField)
        self.view.addSubview(dotoriSeperatorView)
        
        
         //self.view.addSubview(sendMsgImage)
        
        showMyUserData()
        setLayout()
        
    }
    
    //이전
    @objc func cancelAction(){
        //print("cancelAction")
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    

    func setLayout(){

        //라벨
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor,constant:40).isActive = true
        //nameLabel.topAnchor.constraintEqualToSystemSpacingBelow(view.topAnchor, multiplier: 2)
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 63).isActive = true
        
        //텍스트 필드
        //nameTextField.topAnchor.constraintEqualToSystemSpacingBelow(view.topAnchor, multiplier: 2)
        nameTextField.topAnchor.constraint(equalTo: view.topAnchor,constant:40).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 5).isActive = true
        nameTextField.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        //구분선
        
        
        nameSeperatorView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant:5).isActive = true
        nameSeperatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        nameSeperatorView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        nameSeperatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        
        //라벨
        birthLabel.topAnchor.constraint(equalTo: nameSeperatorView.bottomAnchor,constant:20).isActive = true
        birthLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        birthLabel.widthAnchor.constraint(equalToConstant: 63).isActive = true
        //텍스트 필드
        birthTextField.topAnchor.constraint(equalTo: nameSeperatorView.bottomAnchor,constant:20).isActive = true
        birthTextField.leftAnchor.constraint(equalTo: birthLabel.rightAnchor, constant: 5).isActive = true
        birthTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        //구분선
        birthSeperatorView.topAnchor.constraint(equalTo: birthLabel.bottomAnchor,constant:5).isActive = true
        birthSeperatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        birthSeperatorView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        birthSeperatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        //라벨
        mesageLabel.topAnchor.constraint(equalTo: birthSeperatorView.bottomAnchor,constant:20).isActive = true
        mesageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        mesageLabel.widthAnchor.constraint(equalToConstant: 63).isActive = true
        //텍스트 필드
        mesageTextField.topAnchor.constraint(equalTo: birthSeperatorView.bottomAnchor,constant:20).isActive = true
        mesageTextField.leftAnchor.constraint(equalTo: mesageLabel.rightAnchor, constant: 5).isActive = true
        mesageTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        //구분선
        mesageSeperatorView.topAnchor.constraint(equalTo: mesageLabel.bottomAnchor,constant:5).isActive = true
        mesageSeperatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        mesageSeperatorView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mesageSeperatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        
        //라벨
        dotoriLabel.topAnchor.constraint(equalTo: mesageSeperatorView.bottomAnchor,constant:20).isActive = true
        dotoriLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        dotoriLabel.widthAnchor.constraint(equalToConstant: 63).isActive = true
        //텍스트 필드
        dotoriTextField.topAnchor.constraint(equalTo: mesageSeperatorView.bottomAnchor,constant:20).isActive = true
        dotoriTextField.leftAnchor.constraint(equalTo: mesageLabel.rightAnchor, constant: 5).isActive = true
        dotoriTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        //구분선
        dotoriSeperatorView.topAnchor.constraint(equalTo: dotoriLabel.bottomAnchor,constant:5).isActive = true
        dotoriSeperatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        dotoriSeperatorView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        dotoriSeperatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    
        
        sendMsgLabel.topAnchor.constraint(equalTo: dotoriSeperatorView.bottomAnchor,constant:50).isActive = true
        sendMsgLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        sendMsgLabel.widthAnchor.constraint(equalToConstant: 117).isActive = true
        sendMsgLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        getMsgLabel.topAnchor.constraint(equalTo: dotoriSeperatorView.bottomAnchor,constant:50).isActive = true
        getMsgLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        getMsgLabel.widthAnchor.constraint(equalToConstant: 117).isActive = true
        getMsgLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        todayCheckBtn.topAnchor.constraint(equalTo: getMsgLabel.bottomAnchor,constant:70).isActive = true
        todayCheckBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        todayCheckBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        todayCheckBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true

    }
    

    //내 페이지 정보 가져오기

    func showMyUserData(){
        var writeCount = 0
        var replyCount = 0
        var sendMsgCount = 0
        var getMsgCount = 0
        
        let nickName = Auth.auth().currentUser?.displayName
        let ref = Database.database().reference()
        self.nameTextField.text = nickName // 나의 닉네임 가져와서 넣어주기
        
        let myUid = Auth.auth().currentUser?.uid
       
        // -- 글 개수 가져오기
        ref.child("posts").queryOrderedByKey().observe(.value) { (snapshot) in
            for child in snapshot.children{
                let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                if let uid = childValue["uid"]{
                    if(String(describing: uid) == myUid){
                        writeCount = writeCount + 1
                    }
                }
                self.birthTextField.text = "\(writeCount) 개" // 내가쓴 글 개수 가져와서 넣어주기
            }
            writeCount = 0
        }
        //-- 댓글 개수 가져오기
        ref.child("replys").queryOrderedByKey().observe(.value) { (snapshot) in
            for child in snapshot.children{
                let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                for (_,val)  in childValue{
                    let uidValue =  val as? [String:Any]
                    if let uid = uidValue {
                        if let uidd = uid["uid"] {
                            if(String(describing: uidd) == myUid){
                                replyCount = replyCount + 1
                            }
                        }
                    }
                }
                self.mesageTextField.text = "\(replyCount) 개" // 내가쓴 댓글 개수 가져와서 넣어주기
            }
            replyCount = 0
        }
        
        // 보낸 쪽지 개수 가져오기
        ref.child("messages").queryOrderedByKey().observe(.value) { (snapshot) in
            
            for child in snapshot.children{
                
                let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                
                if let fromid = childValue["fromid"] {
                    
                    if(myUid == String(describing: fromid)){
                        
                        sendMsgCount = sendMsgCount + 1
                        
                    }
                }
                
                if let toid = childValue["toid"] {
                    
                    if(myUid == String(describing: toid)){
                        
                        getMsgCount = getMsgCount + 1
                        
                    }
                }
                
            }
            self.sendMsgLabel.text = "  보낸쪽지: \(sendMsgCount)개" // 내가쓴 글 개수 가져와서 넣어주기
            self.getMsgLabel.text = "  받은쪽지: \(getMsgCount)개" // 내가 받은 글 개수 가져와서 넣어주기
            getMsgCount = 0
            sendMsgCount = 0
        }
        
        // 도토리 개수 가져오기
        ref.child("dotori").child(myUid!).observe(.value) { (snapshot) in
            
            if (snapshot.childrenCount == 0){
                 self.dotoriTextField.text = "0 개"
            }else{
                
                //let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = snapshot.value as! [String:Any] //자식의 value 값 가져오기
                
                if let total = childValue["total"] {
                    
                    self.dotoriTotal = (total as? Int)!
                }
 
                self.dotoriTextField.text = "\(self.dotoriTotal) 개"
            }
        }
        
        ref.removeAllObservers()
    }
    
    
    
    //나에게 쪽지보내기 컨트롤
    func sendMsgController(toid:String,toname:String,fromid:String,fromname:String)
    {
        let alertController = UIAlertController(title: "\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let margin:CGFloat = 8.0
        let rect = CGRect(margin, margin, alertController.view.bounds.size.width - margin * 15.0, 100.0)
        let customView = UITextView(frame: rect)
        
        customView.backgroundColor = UIColor.clear
        customView.font = UIFont(name: "Helvetica", size: 15)
        //customView.text = "g"
        alertController.view.addSubview(customView)
        
        

        //쪽지 내용이 없으면 !
        let somethingAction = UIAlertAction(title: "보내기", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in //
            
            if customView.text == "" {
                let alert = UIAlertController(title: "알림 ", message:"내용을 입력해주세요.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            let ref = Database.database().reference()
            let msgRefKey = ref.child("messages").childByAutoId().key
            let msgRef = ref.child("messages").child(msgRefKey)
            
            //데이터 객체 만들기
            let userInfo: [String:Any] = ["toid" : toid,
                                          "toname" : toname,
                                          "fromid" : fromid,
                                          "fromname": fromname,
                                         "content" : customView.text,
                                         "date" : ServerValue.timestamp()]
            //해당 경로에 삽입
            msgRef.setValue(userInfo)
            let alert = UIAlertController(title: "알림 ", message:"나에게 쪽지를 전달했습니다.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
        
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion:{})
        
        
    }
    
    
}
