//
//  NoticeViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 12..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//
extension UIView {
    
    func bringToFront() {
        self.superview?.bringSubview(toFront: self)
    }
    
}
import UIKit
import Firebase
private let reuseIdentifier = "Cell"

class NoticeViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
var activityIndicatorView: UIActivityIndicatorView!
    
    var notices = [Notices]()
    //사진 라이브러리 객체
    let picker = UIImagePickerController()
    //gs://instagramlikesystem.appspot.com
    let storage = Storage.storage()
    
    var ref: DatabaseReference!
    
    var uiImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
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
               
                Thread.sleep(forTimeInterval: 2.0)
                print("start forTimeInterval")
                self.activityIndicatorView.stopAnimating()
                self.collectionView?.reloadData()
            }
        }
        
        
        //firebase 데이터 베이스 초기화
        ref = Database.database().reference()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        self.navigationController?.navigationBar.isTranslucent = false
        //navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "사진방"
        print("소식방")
        
        if let currentEmail = Auth.auth().currentUser?.email {
            print("소식방에 접근한 아이디 \(currentEmail )")
            if(currentEmail == "admin@naver.com" || currentEmail == "admin1@naver.com"||currentEmail == "admin2@naver.com"||currentEmail == "admin3@naver.com" || currentEmail == "admin4@naver.com"){
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .plain, target: self, action: #selector(addNoticePick))
            }
        }
        
        
        self.collectionView!.register(NoticeCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView?.backgroundColor = UIColor.white
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "로그아웃", style: .plain, target: self, action: #selector(logoutAction))
        
        showNotice()
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width:view.frame.size.width, height:1.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width:view.frame.size.width, height:1.0)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notices.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? NoticeCell
        cell?.backgroundColor = UIColor.white
       
        cell?.noticeImageView.downloadImage(from: notices[indexPath.row].noticeUrl)
        cell?.noticeLabel.text = notices[indexPath.row].nid
        cell?.dateLabel.text = notices[indexPath.row].date
        return cell!
    }
    
    //cell의 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/3 - 1
        return CGSize(width: width , height: width)
    }
    
    //컬렉션 뷰의 셀 사이사이마다 간격설정 원래는 디폴드 값으로 10이 지정되어 있음
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
    
    //셀을 클릭했을 때
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("선택한 셀은 과연~! \(indexPath.row)")
        let cell = collectionView.cellForItem(at: indexPath) as? NoticeCell
        let nid = cell?.noticeLabel.text
        print("선택된 사진의 id는 \(nid!) 입니다" )
        
        let viewController = BigImageViewController()
        viewController.noticeImageView.image = cell?.noticeImageView.image
        //self.present(viewController, animated: true, completion: nil)
        navigationController?.pushViewController(viewController, animated: true)
       

    }
    
    //사진 추가 네비게이션 바 버튼 클릭
    @objc func addNoticePick(){
        
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    //사진 선택이 끝났을 때
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage{
            //uiImage = image
            uploadAction(image: image)
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func uploadAction(image:UIImage){
        print("사진 업로드 입니다.")
        let noticsRef = storage.reference().child("notics")
        let key = self.ref.child("notics").childByAutoId().key
        let imageRef = noticsRef.child("\(key).jpg")
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
                    
                    let noticInfo: [String:Any] = ["imgurl" : url.absoluteString,
                                                   "date":ServerValue.timestamp()]
                    
                    //해당 경로에 삽입
                    self.ref.child("notics").child(key).setValue(noticInfo)
                    
                }
            })
        })
        uploadTask.resume()
        
    }
    
    
    func showNotice(){
       
        let ref = Database.database().reference()
        ref.child("notics").queryOrdered(byChild: "date").observe(.value) { (snapshot) in
            self.notices.removeAll() //배열을 안지워 주면 계속 중복해서 쌓이게 된다.
            for child in snapshot.children{
                
                let noticeToShow = Notices() //데이터를 담을 클래스
                let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                 let childKey = childSnapshot.key
                if let date = childValue["date"],  let imgurl = childValue["imgurl"]{
                    
                    if let t = date as? TimeInterval {
                        let date = NSDate(timeIntervalSince1970: t/1000)
                        print("---------------------\(NSDate(timeIntervalSince1970: t/1000))")
                        let dayTimePeriodFormatter = DateFormatter()
                        dayTimePeriodFormatter.dateFormat = "YYY-MMM-d hh:mm a"
                        let dateString = dayTimePeriodFormatter.string(from: date as Date)
                        noticeToShow.date = dateString
                    }
                    noticeToShow.noticeUrl = imgurl as! String
                    noticeToShow.nid = childKey
                }
                self.notices.insert(noticeToShow, at: 0) //
            }
            self.collectionView?.reloadData()
        }
        ref.removeAllObservers()

    }
    
    //로그아웃
    
   /* @objc func logoutAction(){
        
         let firebaseAuth = Auth.auth()
         do {
         try firebaseAuth.signOut()
         self.dismiss(animated: true, completion: nil)
         } catch let signOutError as NSError {
         print ("Error signing out: %@", signOutError)
         }
        
    }*/
    
    
}


//이미지뷰 확장
extension UIImageView {
    func downloadImage(from imgURL: String!){
        let url = URLRequest(url: URL(string: imgURL)!)
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //에러가 있으면
            if error != nil{
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data:data!)
            }
        }
        task.resume()
    }
}

