//
//  ViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 12..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit
import Firebase
class MainViewController: UIViewController {
    
    let mainTitle : UILabel = {
        let title =  UILabel()
        title.text = "아중감 청년부 로그인"
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
        password.placeholder = "비밀번호"
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
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.brown
        button.setTitle("로그인", for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 10; // this value vary as per your desire
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return button
    }()
    
    //로그인 함수
    @objc func loginAction(){
        //nil 값 검사
        guard emailTextField.text != "", passwordTextField.text != "" else{return}
        
        //인디케이터 시작
        AppDelegate.instance().showActivityIndicator()
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            

            
            if let error = error {
                
                //print("error: \(error.localizedDescription)")
                //로그인 폼 유효성 검사
                if let errCode = AuthErrorCode(rawValue: error._code) {
                    
                    switch errCode {
                    case .invalidEmail:
                        let alert = UIAlertController(title: "알림 ", message:"이메일 형식을 확인해주세요.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    case .wrongPassword :
                        let alert = UIAlertController(title: "알림 ", message:"비밀번호를 확인해주세요.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    case .accountExistsWithDifferentCredential :
                        let alert = UIAlertController(title: "알림 ", message:"이메일을 확인해주세요.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    case .userNotFound :
                        let alert = UIAlertController(title: "알림 ", message:"존재하지 않는 이메일입니다.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    default:
                        let alert = UIAlertController(title: "알림 ", message:"다시 시도해주세요.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                //인디케이터 종료
                AppDelegate.instance().dissmissActivityIndicator()
                return
            }
            //유저가 있을때
            if user != nil{
                print("로그인 성공")
                print(user as Any)
                
                //로그인 성공했을 때
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let tabBarController = appDelegate.tabBarController
                //인디케이터 종료
                AppDelegate.instance().dissmissActivityIndicator()
                self.present(tabBarController!, animated: true, completion: nil)
            }
        }
    }
    
    //가입 버튼
    let signButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("처음이세요? 가입하러가기", for: UIControlState())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.addTarget(self, action: #selector(signAction), for: .touchUpInside)
        return button
    }()
    
    @objc func signAction(){
        print("가입 버튼이 눌렀습니다.")
        let signView = SignViewController()
        self.present(signView, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //바탕화면 누르면 키보드 숨기기
        hideKeyboard()
        self.view.backgroundColor = UIColor.white
        view.addSubview(mainTitle)
        view.addSubview(imageView)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(emailSeperatorView)
        view.addSubview(passwordSeperatorView)
        view.addSubview(loginButton)
        view.addSubview(signButton)
        
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
    
    func setLayout(){
        
        mainTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        mainTitle.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    
        imageView.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 30).isActive = true
        imageView.leadingAnchor.constraint(equalTo: mainTitle.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: mainTitle.trailingAnchor).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30).isActive = true
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
        
        loginButton.topAnchor.constraint(equalTo: passwordSeperatorView.bottomAnchor, constant:30).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: passwordSeperatorView.leadingAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: passwordSeperatorView.widthAnchor).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        signButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant:30).isActive = true
        signButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor).isActive = true
        signButton.widthAnchor.constraint(equalTo: loginButton.widthAnchor).isActive = true
        signButton.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        
    }
    
}


