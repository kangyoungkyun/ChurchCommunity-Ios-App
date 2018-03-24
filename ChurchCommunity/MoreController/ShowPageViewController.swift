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
    
    let storage = Storage.storage()
    //이름
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red:0.22, green:0.78, blue:0.20, alpha:1.0)
        return label
    }()
    
    
    //댓글수
    var birthLabel: UILabel = {
        let label = UILabel()
        label.text = "작성글"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red:0.22, green:0.78, blue:0.20, alpha:1.0)
        return label
    }()
    
    //작성댓글
    var mesageLabel: UILabel = {
        let label = UILabel()
        label.text = "작성댓글"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red:0.22, green:0.78, blue:0.20, alpha:1.0)
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
        view.backgroundColor = UIColor(red:0.22, green:0.78, blue:0.20, alpha:1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //==================================================================================
    //글수 텍스트 필드
    let birthTextField : UITextField = {
        let tf = UITextField()
        //tf.placeholder = "미지정"
        tf.isEnabled = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    //글수 구분선 만들기
    let birthSeperatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.22, green:0.78, blue:0.20, alpha:1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //==================================================================================
    
    
    //댓글수 텍스트 필드 객체 만들기
    let mesageTextField: UITextField = {
        let tf = UITextField()
        tf.isEnabled = false
        //tf.placeholder = "상태메시지가 없습니다."
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    //구분선 만들기
    let mesageSeperatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.22, green:0.78, blue:0.20, alpha:1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //이름
    var sendMsgLabel: UILabel = {
        let label = UILabel()
        label.text = "  보낸쪽지: 6개"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.white
        label.backgroundColor = UIColor(red:0.22, green:0.78, blue:0.20, alpha:1.0)
        label.layer.cornerRadius = 7
        label.clipsToBounds = true
        return label
    }()
    
    //이름
    var getMsgLabel: UILabel = {
        let label = UILabel()
        label.text = "  받은쪽지: 8개"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor(red:0.22, green:0.78, blue:0.20, alpha:1.0)
        label.layer.cornerRadius = 7
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //쪽지보내기 버튼
    var sendBtn: UIButton = {
        let sendBtn = UIButton()
        sendBtn.setTitle("쪽지보내기", for: UIControlState())
        //sendBtn.font = UIFont.boldSystemFont(ofSize: 17)
        sendBtn.setTitleColor(UIColor.white, for: UIControlState())
        sendBtn.backgroundColor = UIColor(red:0.22, green:0.78, blue:0.20, alpha:1.0)
        sendBtn.layer.cornerRadius = 7
        sendBtn.clipsToBounds = true
        sendBtn.translatesAutoresizingMaskIntoConstraints = false
        sendBtn.addTarget(self, action: #selector(sendMesageBtnAction), for: .touchUpInside)
        return sendBtn
    }()
    //쪽지보내기 버튼 클릭
    @objc func sendMesageBtnAction(){
        print("쪽지보내기 버튼 클릭")
    }
    
    
    //쪽지보내기 버튼
    var todayCheckBtn: UIButton = {
        let sendBtn = UIButton()
        sendBtn.setTitle("출석체크", for: UIControlState())
        //sendBtn.font = UIFont.boldSystemFont(ofSize: 17)
        sendBtn.setTitleColor(UIColor.white, for: UIControlState())
        sendBtn.backgroundColor = UIColor(red:0.22, green:0.78, blue:0.20, alpha:1.0)
        sendBtn.layer.cornerRadius = 7
        sendBtn.clipsToBounds = true
        sendBtn.translatesAutoresizingMaskIntoConstraints = false
        sendBtn.addTarget(self, action: #selector(todayCheckBtnAction), for: .touchUpInside)
        return sendBtn
    }()
    //쪽지보내기 버튼 클릭
    @objc func todayCheckBtnAction(){
        print("출석체크 보내기 버튼 클릭")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //profileImageView.roundedImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //profileImageView.roundedImage()
        //바탕화면 누르면 키보드 숨기기
        //hideKeyboard()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.22, green:0.78, blue:0.20, alpha:1.0)
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
            print("start DispatchQueue")
            OperationQueue.main.addOperation() {
                print("start OperationQueue")
                
                Thread.sleep(forTimeInterval: 1.9)
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
        self.view.addSubview(sendBtn)
        
        showMyUserData()
        setLayout()
        
    }
    
    //이전
    @objc func cancelAction(){
        //print("cancelAction")
        //self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    //설정
    @objc func settingAction(){
        print("settingAction")
        //self.dismiss(animated: true, completion: nil)
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
        nameTextField.rightAnchor.constraint(equalTo: sendBtn.leftAnchor).isActive = true
        //구분선
        
        
        sendBtn.topAnchor.constraint(equalTo: view.topAnchor,constant:40).isActive = true
        sendBtn.leftAnchor.constraint(equalTo: nameTextField.rightAnchor, constant: 2).isActive = true
        sendBtn.rightAnchor.constraint(equalTo: view.rightAnchor,constant: -2).isActive = true
        sendBtn.widthAnchor.constraint(equalToConstant: 90).isActive = true
        sendBtn.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
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
        
        
        
        
        sendMsgLabel.topAnchor.constraint(equalTo: mesageSeperatorView.bottomAnchor,constant:50).isActive = true
        sendMsgLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        sendMsgLabel.widthAnchor.constraint(equalToConstant: 117).isActive = true
        sendMsgLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        getMsgLabel.topAnchor.constraint(equalTo: mesageSeperatorView.bottomAnchor,constant:50).isActive = true
        getMsgLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        getMsgLabel.widthAnchor.constraint(equalToConstant: 117).isActive = true
        getMsgLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        todayCheckBtn.topAnchor.constraint(equalTo: getMsgLabel.bottomAnchor,constant:70).isActive = true
        todayCheckBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        todayCheckBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        
        //sendBtn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        todayCheckBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    //유저 가져오기
    
    func showMyUserData(){
        var writeCount = 0
        var replyCount = 0
        var sendMsgCount = 0
        var getMsgCount = 0
        
        let nickName = Auth.auth().currentUser?.displayName
        let ref = Database.database().reference()
        self.nameTextField.text = nickName // 나의 닉네임 가져와서 넣어주기
        let myUid = Auth.auth().currentUser?.uid
        // --
        ref.child("posts").queryOrderedByKey().observe(.value) { (snapshot) in
            
            
            for child in snapshot.children{
                
                let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                
                if let name = childValue["name"],  let date = childValue["date"], let hit = childValue["hit"], let pid = childValue["pid"], let uid = childValue["uid"], let text = childValue["text"], let reply = childValue["reply"] {
                    
                    if(myUid == String(describing: uid)){
                        
                        writeCount = writeCount + 1
                        
                    }
                }
            }
            self.birthTextField.text = "\(writeCount) 개" // 내가쓴 글 개수 가져와서 넣어주기
        }
        
        //-- 댓글 개수 가져오기
        ref.child("replys").queryOrderedByKey().observe(.value) { (snapshot) in
            
            for child in snapshot.children{
                let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                for (_,val)  in childValue{
                    let uidValue =  val as? [String:Any]
                    if let uid = uidValue {
                        if let uidd = uid["uid"] ,let name = uid["name"],let date = uid["date"],let rid = uid["rid"],let text = uid["text"],let pid = uid["pid"] {
                            
                            if(String(describing: uidd) == myUid){
                                
                                replyCount = replyCount + 1
                                
                            }
                        }
                    }
                }
                
                self.mesageTextField.text = "\(replyCount) 개" // 내가쓴 댓글 개수 가져와서 넣어주기
            }
        }
        
        ref.removeAllObservers()
        
    }
    
    
    
}
