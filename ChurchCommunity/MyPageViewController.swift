//
//  MyPageViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 17..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//
extension UIImageView {
    
    func roundedImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red:0.98, green:0.72, blue:0.16, alpha:1.0).cgColor
        self.layer.masksToBounds = true
    }
    
}

import UIKit

class MyPageViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //이름
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red:0.98, green:0.72, blue:0.16, alpha:1.0)
        return label
    }()
    
    //이메일
    var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
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
    //이메일 텍스트 필드 객체 만들기
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "abcnt@naver.com"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    //이메일 구분선 만들기
    let emailSeperatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.98, green:0.72, blue:0.16, alpha:1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //==================================================================================
    //생일 텍스트 필드
    let birthTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "12월 11일"
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
        tf.placeholder = "상태메시지를 입력해주세요."
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
        imageView.image = UIImage(named: "addpic.png")
        
        
        //imageView.roundedImage()
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        //이미지 터치 하면 이벤트 발생하게
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
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
        hideKeyboard()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.98, green:0.72, blue:0.16, alpha:1.0)
        self.navigationItem.title = "MyPage"
        //취소 바 버튼
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(cancelAction))
        
        //완료 바 버튼
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "설정", style: .plain, target: self, action: #selector(settingAction))
        
        view.backgroundColor = UIColor.white
        
        
        self.view.addSubview(nameLabel)
        self.view.addSubview(emailLabel)
        self.view.addSubview(birthLabel)
        self.view.addSubview(mesageLabel)
        
        self.view.addSubview(nameTextField)
        self.view.addSubview(emailTextField)
        self.view.addSubview(birthTextField)
        self.view.addSubview(mesageTextField)
        
        self.view.addSubview(nameSeperatorView)
        self.view.addSubview(emailSeperatorView)
        self.view.addSubview(birthSeperatorView)
        self.view.addSubview(mesageSeperatorView)
        
        self.view.addSubview(profileImageView)
        
        setLayout()
        
    }
    
    //이전
    @objc func cancelAction(){
        //print("cancelAction")
        self.dismiss(animated: true, completion: nil)
    }
    
    //설정
    @objc func settingAction(){
        print("settingAction")
        //self.dismiss(animated: true, completion: nil)
    }
    
    
    //로그인 페이지에서 이미지 버튼 눌렸을때 작동하는 이벤트 함수
    @objc func handleSelectProfileImageView(){
        print("picker")
        //이미지 피커 컨트롤러 객체 만들고
        let picker = UIImagePickerController()
        //델리게이트를 이 클래스 자신으로 해준다.
        picker.delegate = self
        //수정 가능
        picker.allowsEditing = true
        
        
        //사진 라이브러리 나타나라 , info.plist에서 보안 관련 설정해줘야 함
        present(picker, animated: true, completion: nil)
        
    }
    //앨범에서 사진을 선택했을 때 작동되는 함수 (댈리게이트 함수로 반드시 구현해줘야 하는 함수)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        //uiimage 변수 설정
        var selectedImageFromPicker: UIImage?
        
        //선택한사진 정보가 info 매개변수로 넘어온다. 타입은 uiimage 이다
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImageFromPicker = editedImage
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker{
            //프로필 이미지에 넣기
            profileImageView.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    func setLayout(){
        
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        //라벨
        nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor,constant:20).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        //텍스트 필드
        nameTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor,constant:20).isActive = true
        nameTextField.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 2).isActive = true
        nameTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        //구분선
        nameSeperatorView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant:10).isActive = true
        nameSeperatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        nameSeperatorView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        nameSeperatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        
        //라벨
        emailLabel.topAnchor.constraint(equalTo: nameSeperatorView.bottomAnchor,constant:20).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        emailLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        //텍스트 필드
        emailTextField.topAnchor.constraint(equalTo: nameSeperatorView.bottomAnchor,constant:20).isActive = true
        emailTextField.leftAnchor.constraint(equalTo: emailLabel.rightAnchor, constant: 2).isActive = true
        emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        //구분선
        emailSeperatorView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor,constant:10).isActive = true
        emailSeperatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        emailSeperatorView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        emailSeperatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
        
        //라벨
        birthLabel.topAnchor.constraint(equalTo: emailSeperatorView.bottomAnchor,constant:20).isActive = true
        birthLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        birthLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        //텍스트 필드
        birthTextField.topAnchor.constraint(equalTo: emailSeperatorView.bottomAnchor,constant:20).isActive = true
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
    
    
    
    
    
}
