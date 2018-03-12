//
//  SignViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 12..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//
import UIKit
import Firebase
class SignViewController: UIViewController {
    
    let mainTitle : UILabel = {
        let title =  UILabel()
        title.text = "아중감 청년부 가입"
        title.font = UIFont.boldSystemFont(ofSize: 18)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    //이미지 뷰
    let imageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "main_pick.png")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    //이름 필드
    let nameTextField: UITextField = {
        let name = UITextField()
        name.placeholder = "닉네임"
        name.autocorrectionType = .no
        name.autocapitalizationType = .none
        name.translatesAutoresizingMaskIntoConstraints = false
        
        return name
    }()
    
    //이름 구분선 만들기
    let nameSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    //이메일 필드
    let emailTextField: UITextField = {
        let email = UITextField()
        email.placeholder = "abcnt@naver.com"
        email.translatesAutoresizingMaskIntoConstraints = false
        email.autocorrectionType = .no
        email.autocapitalizationType = .none
        email.keyboardType = .emailAddress
        return email
    }()
    
    
    //이메일 구분선 만들기
    let emailSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //패스워드 필드
    let passwordTextField: UITextField = {
        let password = UITextField()
        password.placeholder = "비밀번호 6자리 이상"
        password.isSecureTextEntry = true
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    //이메일 구분선 만들기
    let passwordSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //버튼
    let signButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.brown
        button.setTitle("가입", for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 10; // this value vary as per your desire
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(signAction), for: .touchUpInside)
        return button
    }()
    
    //가입 로직 처리 함수
    @objc func signAction(){
        
        guard nameTextField.text != "", emailTextField.text != "", passwordTextField.text != "" else{return}
        //인디케이터 시작
        AppDelegate.instance().showActivityIndicator()
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if let error = error {
                //print("error: \(error.localizedDescription)")
                //가입 폼 유효성 검사
                if let errCode = AuthErrorCode(rawValue: error._code) {
                    
                    switch errCode {
                    case .invalidEmail:
                        print("이메일 형식을 확인해주세요")
                    case .emailAlreadyInUse:
                        print("이미 존재하는 이메일 입니다.")
                    case .weakPassword :
                        print("비밀번호가 보안에 취약합니다.")
                    default:
                        print("Create User Error: \(error)")
                    }
                }
                //인디케이터 종료
                AppDelegate.instance().dissmissActivityIndicator()
                return
            }
            
            //파이어 베이스 쪽에 이름도 넣어주기
            if user != nil {
                let ChangeRequest = Auth.auth().currentUser!.createProfileChangeRequest()
                ChangeRequest.displayName = self.nameTextField.text!
                ChangeRequest.commitChanges(completion: nil)
                
                print("가입성공")
                //tabbarController 가져오기
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let tabBarController = appDelegate.tabBarController
                //인디케이터 종료
                AppDelegate.instance().dissmissActivityIndicator()
                self.present(tabBarController!, animated: true, completion: nil)
            }
        }
    }
    
    //뒤로가기 버튼
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("뒤로가기", for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        return button
    }()
    
    //뒤로가기 함수
    @objc func cancelAction(){
        print("뒤로가기  버튼이 눌렀습니다.")
        self.dismiss(animated: true, completion: nil)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //바탕화면 누르면 키보드 숨기기
        hideKeyboard()
        self.view.backgroundColor = UIColor.white
        view.addSubview(mainTitle)
        view.addSubview(imageView)
        view.addSubview(nameTextField)
        view.addSubview(nameSeperatorView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(emailSeperatorView)
        view.addSubview(passwordSeperatorView)
        view.addSubview(signButton)
        view.addSubview(cancelButton)
        
        //제약조건 레이아웃 설정
        setLayout()
        //로그인 상태 체크
        sessionCheck()
    }
    
    //로그인 상태 체크
    func sessionCheck(){
        if Auth.auth().currentUser?.uid == nil {
            
            do {
                try Auth.auth().signOut()
            } catch let logoutError {
                print(logoutError)
            }
        }else{
            //유저아이디가 있으면 0.1 초 뒤에 appDelegate에 있는 tabBarController 참조 가져오기
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { //0.1초 뒤
                // Your code with delay
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let tabBarController = appDelegate.tabBarController
                self.present(tabBarController!, animated: true, completion: nil)
            }
        }
    }
    //레이아웃 셋팅
    func setLayout(){
        
        mainTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        mainTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        imageView.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 30).isActive = true
        imageView.leadingAnchor.constraint(equalTo: mainTitle.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: mainTitle.trailingAnchor).isActive = true
        
        nameTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        nameSeperatorView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeperatorView.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor).isActive = true
        nameSeperatorView.widthAnchor.constraint(equalTo: nameTextField.widthAnchor).isActive = true
        nameSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: nameSeperatorView.bottomAnchor, constant: 30).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        emailSeperatorView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeperatorView.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor).isActive = true
        emailSeperatorView.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true
        emailSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        passwordTextField.topAnchor.constraint(equalTo: emailSeperatorView.bottomAnchor, constant: 30).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: emailSeperatorView.leadingAnchor).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: emailSeperatorView.trailingAnchor).isActive = true
        
        passwordSeperatorView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor).isActive = true
        passwordSeperatorView.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor).isActive = true
        passwordSeperatorView.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor).isActive = true
        passwordSeperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        signButton.topAnchor.constraint(equalTo: passwordSeperatorView.bottomAnchor, constant:30).isActive = true
        signButton.leadingAnchor.constraint(equalTo: passwordSeperatorView.leadingAnchor).isActive = true
        signButton.widthAnchor.constraint(equalTo: passwordSeperatorView.widthAnchor).isActive = true
        signButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: signButton.bottomAnchor, constant:30).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: signButton.leadingAnchor).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: signButton.widthAnchor).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
}
