//
//  UserPageViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 17..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit
import Firebase
class UserPageViewController: UIViewController {

    
    var userUid: String?
    
    let storage = Storage.storage()
    //이름
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red:0.98, green:0.72, blue:0.16, alpha:1.0)
        return label
    }()
    
    
    //생일
    var birthLabel: UILabel = {
        let label = UILabel()
        label.text = "생일"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red:0.98, green:0.72, blue:0.16, alpha:1.0)
        return label
    }()
    
    //한줄메시지
    var mesageLabel: UILabel = {
        let label = UILabel()
        label.text = "기분"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red:0.98, green:0.72, blue:0.16, alpha:1.0)
        return label
    }()
    
    //==================================================================================
    
    //이름 텍스트 필드 객체 만들기
    let nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "이름"
        tf.isEnabled = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    //이름 구분선 만들기
    let nameSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.16, alpha:1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //==================================================================================
    //생일 텍스트 필드
    let birthTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "미지정"
        tf.isEnabled = false
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    //생일 구분선 만들기
    let birthSeperatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.16, alpha:1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //==================================================================================
    
    
    //메시지 텍스트 필드 객체 만들기
    let mesageTextField: UITextField = {
        let tf = UITextField()
        tf.isEnabled = false
        tf.placeholder = "상태메시지가 없습니다."
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    //메시지 구분선 만들기
    let mesageSeperatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.16, alpha:1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //============================== =======사진=============================================
    
    
    //이미지뷰 ..아래 addguesture의 self 때문에 lazy를 붙여준다고?
    lazy var profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "nopic.png")
        
        //imageView.roundedImage()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        

        return imageView
    }()
    
    override func viewWillLayoutSubviews() {
        profileImageView.roundedImage()
    }
    
    
    /*
     self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width / 2;
     self.profileImageView.clipsToBounds = YES;
     */
    override func viewWillAppear(_ animated: Bool) {
        //profileImageView.roundedImage()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //profileImageView.roundedImage()
        //바탕화면 누르면 키보드 숨기기
        //hideKeyboard()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.98, green:0.72, blue:0.16, alpha:1.0)
        self.navigationItem.title = "프로필"
        //취소 바 버튼
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(cancelAction))
        
        
        view.backgroundColor = UIColor.white
        
        
        self.view.addSubview(nameLabel)

        self.view.addSubview(birthLabel)
        self.view.addSubview(mesageLabel)
        
        self.view.addSubview(nameTextField)
   
        self.view.addSubview(birthTextField)
        self.view.addSubview(mesageTextField)
        
        self.view.addSubview(nameSeperatorView)

        self.view.addSubview(birthSeperatorView)
        self.view.addSubview(mesageSeperatorView)
        
        self.view.addSubview(profileImageView)
        
        
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
        
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        //라벨
        nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor,constant:50).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        //텍스트 필드
        nameTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor,constant:50).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 2).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        //구분선
        nameSeperatorView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant:10).isActive = true
        nameSeperatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        nameSeperatorView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        nameSeperatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        

        
        //라벨
        birthLabel.topAnchor.constraint(equalTo: nameSeperatorView.bottomAnchor,constant:20).isActive = true
        birthLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        birthLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        //텍스트 필드
        birthTextField.topAnchor.constraint(equalTo: nameSeperatorView.bottomAnchor,constant:20).isActive = true
        birthTextField.leftAnchor.constraint(equalTo: birthLabel.rightAnchor, constant: 2).isActive = true
        birthTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        //구분선
        birthSeperatorView.topAnchor.constraint(equalTo: birthLabel.bottomAnchor,constant:10).isActive = true
        birthSeperatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        birthSeperatorView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        birthSeperatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        //라벨
        mesageLabel.topAnchor.constraint(equalTo: birthSeperatorView.bottomAnchor,constant:20).isActive = true
        mesageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        mesageLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        //텍스트 필드
        mesageTextField.topAnchor.constraint(equalTo: birthSeperatorView.bottomAnchor,constant:20).isActive = true
        mesageTextField.leftAnchor.constraint(equalTo: mesageLabel.rightAnchor, constant: 2).isActive = true
        mesageTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        //구분선
        mesageSeperatorView.topAnchor.constraint(equalTo: mesageLabel.bottomAnchor,constant:10).isActive = true
        mesageSeperatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        mesageSeperatorView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mesageSeperatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    
    //유저 가져오기
    func showMyUserData(){
        
        //let myEmail = Auth.auth().currentUser?.email
        //let myKey = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("users").child(userUid!).observe(.value) { (snapshot) in
            //let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
            let childValue = snapshot.value as! [String:Any] //자식의 value 값 가져오기
            
            if(childValue["imgurl"] as? String == nil ){
                self.profileImageView.image = UIImage(named: "nopic.png")
            }else{
                self.profileImageView.downloadImage(from: childValue["imgurl"] as! String)
            }
            
            self.nameTextField.text = childValue["name"] as! String
             self.navigationItem.title = "\(self.nameTextField.text!)"
            
        }
        ref.removeAllObservers()
    }



}
