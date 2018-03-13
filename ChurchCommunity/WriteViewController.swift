//
//  WriteViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 13..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit
import Firebase
class WriteViewController: UIViewController,UITextViewDelegate {
    var placeholderLabel : UILabel = {
      let ph = UILabel()
        ph.text = "당신의 생각을 들려주세요 :)"
        ph.font = UIFont.systemFont(ofSize: 18)
        ph.sizeToFit()
        return ph
    }()
    
    
    //글쓰기 텍스트 필드
    let textFiedlView : UITextView = {
        let tf = UITextView()
        //tf.backgroundColor = UIColor.brown
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.tintColor = .black
        tf.font = UIFont.systemFont(ofSize: 18)
        //키보드 항상 보이게
        tf.becomeFirstResponder()
        return tf
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "글쓰기"
        //취소 바 버튼
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelAction))
        
        //완료 바 버튼
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(writeAction))
        
        view.backgroundColor = UIColor.white
        

       //텍스트 뷰의 위임자를 자기자신으로 - 반드시 해줘야 함!
        textFiedlView.delegate = self
        
        view.addSubview(textFiedlView)
        
        //계층 구조를 이용해서 텍스트 뷰에 lable을 넣어 주었음
        textFiedlView.addSubview(placeholderLabel)
        
        //라벨의 위치를 정해 줌
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (textFiedlView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !textFiedlView.text.isEmpty
        
        setLayout()
    }
    
    //텍스트 뷰에 글을 쓸때 호출됨
    func textViewDidChange(_ textView: UITextView) {
      placeholderLabel.isHidden = !textFiedlView.text.isEmpty
        //print("textViewDidChange")
    }
    

    //취소 함수
    @objc func cancelAction(){
        //print("cancelAction")
        self.dismiss(animated: true, completion: nil)
    }

    //완료 함수
    @objc func writeAction(){
        
        //let ChangeRequest = Auth.auth().currentUser!.
        
          print("writeAction")
    }
    
    
    func setLayout(){
        
        textFiedlView.topAnchor.constraint(equalTo: view.topAnchor,constant:50).isActive = true
        textFiedlView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:4).isActive = true
        textFiedlView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-4).isActive = true
        textFiedlView.heightAnchor.constraint(equalToConstant:view.frame.height / 2).isActive = true
        
    }

}
