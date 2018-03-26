//
//  MyPageViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 17..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//  내 페이지

class birthDate {
    var month : [String]
    var days: [String]
    init(month: [String], days:[String]){
        self.month = month
        self.days = days
    }
}

extension UIImageView {
    
    func roundedImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
        //self.layer.borderWidth = 2
        //self.layer.borderColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)
//.cgColor
        self.layer.masksToBounds = true
    }
    
}
import Firebase
import UIKit

class MyPageViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource{
    var activityIndicatorView: UIActivityIndicatorView!
    var birthData = [birthDate]()
    
    //피커뷰 개수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    //피커뷰의 각 행개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return birthData[0].month.count
        }else{
            return birthData[0].days.count
        }
    }
    //피커뷰의 데이터 넣기
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
            return birthData[0].month[row]
        }else{
            return birthData[0].days[row]
        }
    }
    //해당 피커뷰를 선택했을 때
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerView.reloadComponent(1)
        
        let selectedMonth = pickerView.selectedRow(inComponent: 0)
        let selectedDay = pickerView.selectedRow(inComponent: 1)
        let months = birthData[0].month[selectedMonth]
        let day = birthData[0].days[selectedDay]
        
        birthTextField.text = "\(months) \(day)"
    }
    
    
    
    
    let storage = Storage.storage()
    //이름
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        return label
    }()
    
    //이메일
    var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        return label
    }()
    
    //생일
    var birthLabel: UILabel = {
        let label = UILabel()
        label.text = "생일"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        return label
    }()
    
    //한줄메시지
    var mesageLabel: UILabel = {
        let label = UILabel()
        label.text = "기분"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

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
        view.backgroundColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //==================================================================================
    //이메일 텍스트 필드 객체 만들기
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.isEnabled = false
        tf.placeholder = "abcnt@naver.com"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    //이메일 구분선 만들기
    let emailSeperatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //==================================================================================
    //생일 텍스트 필드
    lazy var birthTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "생일을 지정해주세요."
        tf.translatesAutoresizingMaskIntoConstraints = false
        //tf.isEnabled = false
        
        //생일 텍스트 필드 이벤트 발생하게
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectBirth))
        tf.isUserInteractionEnabled = true
        tf.addGestureRecognizer(tapGesture)
        
        return tf
    }()
    
    //생일란을 선택했을 때 발생하는 이벤트
    @objc func handleSelectBirth (){
       // print("생일 이벤트~!")
        let message = "\n\n\n\n\n\n"
        let alert = UIAlertController(title: "태어난 달과 일을 선택해주세요.", message: message, preferredStyle: UIAlertControllerStyle.actionSheet)
        alert.isModalInPopover = true
        
        
        let pickerFrame = UIPickerView() // CGRectMake(left, top, width, height) - left and top are like margins
 
        //set the pickers datasource and delegate
        pickerFrame.delegate = self
        pickerFrame.dataSource = self
        
        
        //Add the picker to the alert controller
        alert.view.addSubview(pickerFrame)

        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(okAction)
        self.parent!.present(alert, animated: true) {
            print("성공")

        }
        
    }
    
    //생일 구분선 만들기
    let birthSeperatorView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

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
        view.backgroundColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    //============================== =======사진=============================================
    
    
    //이미지뷰 ..아래 addguesture의 self 때문에 lazy를 붙여준다고?
    lazy var profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "addpic.png")
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        //이미지 터치 하면 이벤트 발생하게
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectProfileImageView))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        return imageView
    }()
    
    //마이페이지 사진 동그랗게
    override func viewWillLayoutSubviews() {
        profileImageView.roundedImage()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //바탕화면 누르면 키보드 숨기기
        hideKeyboard()
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        self.navigationItem.title = "MyPage"

        //취소 바 버튼
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "ic_cancel.png"), style: .plain, target: self, action:  #selector(cancelAction))
        //저장 바 버튼
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_save.png"), style: .plain, target: self, action:  #selector(editAction))
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -60).isActive = true
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
        
        
        self.nameTextField.delegate = self
        self.birthTextField.delegate = self
        self.mesageTextField.delegate = self
        
        showMyUserData()
        setLayout()
        
        
        //생일 더미 데이터 넣어주기
        birthData.append(birthDate(month: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
                                   days: ["1일","2일","3일","4일","5일","6일","7일","8일","9일","10일","11일","12일","13일","14일","15일","16일","17일","18일",
                                          "19일","20일","21일","22일","23일","24일","25일","26일","27일","28일","29일","30일","31일"]))
        
    }
    
    //이전
    @objc func cancelAction(){
        //print("cancelAction")
        self.dismiss(animated: true, completion: nil)
    }
    
    //수정 및 저장
    @objc func editAction(){
        AppDelegate.instance().showActivityIndicator()
        
        if nameTextField.text! == "" {
            let alert = UIAlertController(title: "알림 ", message:"이름을 입력해주세요.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "알림", style: .default) { (alert) in
            })
            
            self.present(alert, animated: true, completion: nil)
            AppDelegate.instance().dissmissActivityIndicator()
            return
        }
        
        
        print("settingAction")
        let key = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("users").child(key!).updateChildValues(["name" : nameTextField.text!,
                                                          "msg":mesageTextField.text!,
                                                          "birth":birthTextField.text!])
        
        let ChangeRequest = Auth.auth().currentUser!.createProfileChangeRequest()
        ChangeRequest.displayName = self.nameTextField.text!
        ChangeRequest.commitChanges(completion: nil)
        
        let alert = UIAlertController(title: "알림 ", message:"프로필 변경완료", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "알림", style: .default) { (alert) in
            
            
            //완료되면 textfield 커서 사라지고, 키보드 내리기
            self.birthTextField.selectedTextRange = nil
            self.self.nameTextField.selectedTextRange = nil
            self.self.mesageTextField.selectedTextRange = nil
            
            self.birthTextField.resignFirstResponder()
            self.self.nameTextField.resignFirstResponder()
            self.self.mesageTextField.resignFirstResponder()
            
              AppDelegate.instance().dissmissActivityIndicator()
           
        })
        
        self.present(alert, animated: true, completion: nil)
        
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
            uploadAction(image: selectedImage)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func uploadAction(image:UIImage){
       
        print("사진 업로드 입니다.")
        let noticsRef = storage.reference().child("users")
        let ref = Database.database().reference()
        
        let key = Auth.auth().currentUser?.uid
        
        let imageRef = noticsRef.child("\(key!).jpg")
        let data = UIImageJPEGRepresentation(image, 0.5)
        
        
        //URLSessoin연결
        let uploadTask = imageRef.putData(data!, metadata: nil, completion: { (metadata, err) in
            //에러 처리
            if err != nil{
                print(err!.localizedDescription)
            }
            //이미지 다운로드
            imageRef.downloadURL(completion: { (url, err) in
                if err != nil{
                    print(err!.localizedDescription)
                }
                
                //json 객체 만들어서
                if let url = url {
                    //해당 경로에 삽입
                    ref.child("users").child(key!).updateChildValues(["imgurl" : url.absoluteString])
                    self.profileImageView.downloadImage(from: String(describing: url))
                }
            })
        })
        uploadTask.resume()
       
    }
    
    
    func setLayout(){
        
        profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 110).isActive = true
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
        nameSeperatorView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant:5).isActive = true
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
        emailSeperatorView.topAnchor.constraint(equalTo: emailLabel.bottomAnchor,constant:5).isActive = true
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
        birthSeperatorView.topAnchor.constraint(equalTo: birthLabel.bottomAnchor,constant:5).isActive = true
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
        mesageSeperatorView.topAnchor.constraint(equalTo: mesageLabel.bottomAnchor,constant:5).isActive = true
        mesageSeperatorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        mesageSeperatorView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mesageSeperatorView.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    
    //유저 가져오기
    func showMyUserData(){
        //인디케이터 시작
        
        let myEmail = Auth.auth().currentUser?.email
        let myKey = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("users").child(myKey!).observe(.value) { (snapshot) in
            //let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
            let childValue = snapshot.value as! [String:Any] //자식의 value 값 가져오기
            
            if(childValue["imgurl"] as? String == nil ){
                self.profileImageView.image = UIImage(named: "addpic.png")
            }else{
                self.profileImageView.downloadImage(from: childValue["imgurl"] as! String)
            }
            
            self.nameTextField.text = childValue["name"] as! String!
            self.emailTextField.text = myEmail
            
            if(childValue["birth"] as? String == nil && childValue["msg"] as? String == nil){
                self.birthTextField.text = ""
                self.mesageTextField.text = ""
            }else{
                self.birthTextField.text = childValue["birth"] as? String
                self.mesageTextField.text = childValue["msg"] as? String
            }
            
        }
        ref.removeAllObservers()
        //인디케이터 끝
      
    }
    
    
    
    
}
