//
//  DetailTalkViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 14..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

class CurvedView:UIView{
    override func draw(_ rect: CGRect) {
       let path = customPath()
        path.lineWidth = 3
        path.stroke()
    }
}

func customPath() -> UIBezierPath{
    let path = UIBezierPath()
    path.move(to: CGPoint(x: 0, y: 200))
    let endPoint = CGPoint(x: 400, y: 200)
    let randomYshift = 200 + drand48() * 300
    let cp1 = CGPoint(x: 100, y: 100 - randomYshift)
    let cp2 = CGPoint(x: 200, y: 300 + randomYshift)
    
    path.addCurve(to: endPoint, controlPoint1: cp1, controlPoint2: cp2)
    return path
}

import UIKit
import Firebase
class DetailTalkViewController: UIViewController, UITableViewDelegate,UITableViewDataSource, ReplyCellNameClickedAction {

    var replys = [Reply]()
    let cellId = "cellId"
    
    //댓글에 적힌 이름을 클릭했을 때
    func replyCellNameClickedAction(uid: String,name:String) {
        
        let myid = Auth.auth().currentUser?.uid
        if(uid == myid!){
            
            let viewController = ShowPageViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        }else{
            let viewController = ShowUserPageViewController()
            viewController.userUid = uid
            viewController.userName = name
            let navController = UINavigationController(rootViewController: viewController)
            self.present(navController, animated: true, completion: nil)
        }

        }
    
    // ==========================================================================.   글 상세 화면에 subview로 넣은 테이블 뷰 =====================================.
    let tableViewFooterView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: Int(0.5))
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
        //cell?.isExclusiveTouch = true
        cell?.delegate = self
        if(replys.count == 0 ){
            cell?.txtLabel.text = "댓글이 없습니다."
        }else{
            cell?.uidLabel.text = replys[indexPath.row].uid
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
    
    //댓글 수정 alert controller 창
    var modifyText:String?
    func popUpController(txt:String,rid:String)
    {
        
        let alertController = UIAlertController(title: "\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let margin:CGFloat = 8.0
        let rect = CGRect(margin, margin, alertController.view.bounds.size.width - margin * 15.0, 100.0)
        let customView = UITextView(frame: rect)
        
        customView.backgroundColor = UIColor.clear
        customView.font = UIFont(name: "Helvetica", size: 15)
        customView.text = txt
        alertController.view.addSubview(customView)
        
        let somethingAction = UIAlertAction(title: "수정", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in //print("something")
            self.modifyText = customView.text
            let ref = Database.database().reference()
            //print("수정된 글은~? \(self.modifyText)")
            ref.child("replys").child(self.pidLabel.text!).child(rid).updateChildValues(["text":self.modifyText ?? "",
                                                                                         "date":ServerValue.timestamp()])
            
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
        
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion:{})
        
        
    }
    //댓글 셀을 선택했을 때
    func tableView(_ replyView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("셀을 선택했습니다~!  \(indexPath.row)")
        
        //선택한 셀 정보 가져오기
        let cell = replyView.cellForRow(at: indexPath) as? ReplyCell
        let rid = cell?.ridLable.text
        let uid = cell?.uidLabel.text
        //let name = cell?.nameLabel.text
        let text = cell?.txtLabel.text
        // let date = cell?.dateLabel.text
        //let pid = cell?.pidLabel.text
        
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .alert)
        
        let modifyAction = UIAlertAction(title: "댓글수정", style: .default) { (alert) in
            print("댓글 수정")
            
            if(Auth.auth().currentUser?.uid == uid){
                
                self.popUpController(txt: text!,rid:rid!)
                
            }else{
                
                let alert = UIAlertController(title: "알림 ", message:"본인의 글만 수정할 수 있습니다.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        
        let deleteAction = UIAlertAction(title: "댓글삭제", style: .destructive) { (alert) in
            if(Auth.auth().currentUser?.uid == uid){
                let ref = Database.database().reference()
                ref.child("replys").child(self.pidLabel.text!).child(rid!).removeValue()
                let alert = UIAlertController(title: "알림 ", message:"성공적으로 삭제되었습니다.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }else{
                
                let alert = UIAlertController(title: "알림 ", message:"본인의 글만 삭제할 수 있습니다.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            
            
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (alert) in
            print("취소")
        }
        
        alertController.addAction(modifyAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        self.present(
            alertController,
            animated: true,
            completion: nil)
        
    }
    
    
    
    //테이블 뷰
    let replyView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.clear
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // ==========================================================================. .  글상세 화면에 subview로 넣은 테이블 뷰 =====================================. =====================================.
    
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
            
            uidLabel.text = onePost?.uid
            showOrNotButton.setTitle(onePost?.show, for: UIControlState())
            
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

    //버튼
    let seeImage: UIButton = {
        
        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "ic_remove_red_eye.png"), for: .normal)
        //starButton.frame = CGRect(x:0,y:0,width:15,height:15)
        starButton.tintColor = UIColor.lightGray
        starButton.translatesAutoresizingMaskIntoConstraints = false
        return starButton
    }()
    
    
    //버튼
    let replyImage: UIButton = {
        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "ic_comment.png"), for: .normal)
        starButton.tintColor = UIColor.lightGray
        starButton.translatesAutoresizingMaskIntoConstraints = false
        return starButton
    }()
    
    
    //버튼
     let likeButton: UIButton = {
        let starButton = UIButton(type: .system)
        starButton.setImage(#imageLiteral(resourceName: "ic_favorite.png"), for: .normal)
        starButton.tintColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)
        starButton.translatesAutoresizingMaskIntoConstraints = false
        starButton.addTarget(self, action: #selector(touchBlessBtn), for: .touchUpInside)
        return starButton
    }()
    


//축복해요 클릭되었을 때
@objc func touchBlessBtn(){
    
    //print("좋아요1")
    (0...10).forEach { (_) in
        generateAnimatedView()
    }
    
    let ref = Database.database().reference()
    //랜덤 키
    let blessRef = ref.child("bless").child(self.pidLabel.text!)
    let blessKey = ref.child("bless").childByAutoId().key
    //데이터 객체 만들기
    let blessInfo: [String:Any] = [ "uid" : Auth.auth().currentUser?.uid ?? ""]
    blessRef.child(blessKey).setValue(blessInfo)
    

    
}

    
    //버튼
    let showOrNotButton: UIButton = {
        let starButton = UIButton(type: .system)
        starButton.setTitle("비공개", for: UIControlState())
        starButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        starButton.tintColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)
        starButton.translatesAutoresizingMaskIntoConstraints = false
        
        return starButton
    }()
    

    
    
    //likes
    var likesLabel: UILabel = {
        let label = UILabel()
        label.text = "축복해요"
        //label.font = UIFont.systemFont(ofSize: 13)
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //uid
    var uidLabel: UILabel = {
        let label = UILabel()
        //label.text = "pid"
        label.isHidden = true
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
   lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        label.text = "이름"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleSelectName))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tapGesture)
        return label
    }()
    
    //글에서 이름이 클릭되었을 때
    @objc func handleSelectName(){

        let myid = Auth.auth().currentUser?.uid
        if(uidLabel.text == myid!){
            let viewController = ShowPageViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        }else{
            let viewController = ShowUserPageViewController()
            viewController.userUid = uidLabel.text
            viewController.userName = nameLabel.text
            let navController = UINavigationController(rootViewController: viewController)
            self.present(navController, animated: true, completion: nil)
        }

    }

    
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
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //댓글 수
    var replyHitLabel: UILabel = {
        let label = UILabel()
        label.text = "15 댓글"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    

    
    
    // =====================================================  댓글라인구분선  =====================================================
    var replyLine: UILabel = {
        let label = UILabel()
        label.text = "  댓글"
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.backgroundColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

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
        tf.backgroundColor = UIColor.lightGray.withAlphaComponent(0.48)
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.tintColor = .black
        tf.font = UIFont.systemFont(ofSize: 16)
        //tf.alpha = 0.5
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
        btn.backgroundColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        btn.addTarget(self, action: #selector(replyBtnAction), for: .touchUpInside)
        return btn
    }()
    
    //댓글 버튼 작동
    @objc func replyBtnAction(){
        
        let myUid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("users").child(myUid!).observe(.value) { (snapshot) in
            
            let childSnapshot = snapshot //자식 DataSnapshot 가져오기
            let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
            if let pass = childValue["pass"] as? String{
                if pass == "n"{
                    let alert = UIAlertController(title: "Sorry", message:"승인 후 이용가능합니다.", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    ref.removeAllObservers()
                    return
                    
                }else if (pass == "y"){
                    
                    if(self.textFiedlView.text.count == 0){
                        let alert = UIAlertController(title: "알림 ", message:"내용을 확인해주세요.", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                        return
                    }
                    
          
                    //랜덤 키
                    let replyRef = ref.child("replys").child(self.pidLabel.text!)
                    
                    let replyKey = ref.child("replys").childByAutoId().key
                    print(replyKey)
                    
                    //데이터 객체 만들기
                    let replyInfo: [String:Any] = ["date" : ServerValue.timestamp(),
                                                   "text" : self.textFiedlView.text!,
                                                   "name" : Auth.auth().currentUser?.displayName ?? "",
                                                   "uid" : Auth.auth().currentUser?.uid ?? "",
                                                   "rid": replyKey,
                                                   "pid":self.pidLabel.text!]
                    
                    
                    //해당 경로에 삽입
                    replyRef.child(replyKey).setValue(replyInfo)
                    
                    //============================================== 댓글 달때 초기에 0 이다. 처음 댓글 입력하면 +1 되게 해주는 로직
                    
                    print("댓글을 삽입합니다 ~~~~~~~~~~~\(self.replys.count)")
                    let replyToShow = Reply() //데이터를 담을 클래스
                    //firebase에서 가져온 날짜 데이터를 ios 맞게 변환
                    if let t = ServerValue.timestamp() as? TimeInterval {
                        let date = NSDate(timeIntervalSince1970: t/1000)
                        print("---------------------\(NSDate(timeIntervalSince1970: t/1000))")
                        let dayTimePeriodFormatter = DateFormatter()
                        dayTimePeriodFormatter.dateFormat = "MMM d일 hh:mm a"
                        let dateString = dayTimePeriodFormatter.string(from: date as Date)
                        replyToShow.date = dateString
                    }
                    replyToShow.name = Auth.auth().currentUser?.displayName
                    replyToShow.rid = replyKey
                    replyToShow.text =  self.textFiedlView.text!
                    replyToShow.pid = self.pidLabel.text!
                    replyToShow.uid = Auth.auth().currentUser?.uid
                    
                    self.replys.insert(replyToShow, at: 0) //
                    //============================================== 댓글 달때 초기에 0 이다. 처음 댓글 입력하면 +1 되게 해주는 로직 끝 ==================
                    
                    ref.removeAllObservers()
                    
                    self.textFiedlView.text = ""
                    
                }
            }
        }
      
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
    

    
     func generateAnimatedView(){
        let imageView = UIImageView(image: #imageLiteral(resourceName: "heart.png"))
        let dimension = 20 + drand48() * 10
        imageView.frame = CGRect(x:0,y:0,width:dimension, height:dimension)
        
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = customPath().cgPath
        animation.duration = 2 + drand48() * 3
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        imageView.layer.add(animation, forKey: nil)
         view.addSubview(imageView)
    }
    
    // ======================================================        진입점        ======================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "일기보기"
        
        
        
        
        //취소 바 버튼
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(goTalkViewController))
        
        
        //로그인 한 유저의. id와 지금 쓴글의 사람의 uid와 같으면 오른쪽 설정바 보이게
        if(Auth.auth().currentUser?.uid == uidLabel.text){
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_settings_white.png"), style: .plain, target: self, action:  #selector(goSettingAlertAction))
        }
        
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(uiScrollView)
        
        //네비게이션 바 색깔 변경
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        //self.navigationController?.navigationBar.isTranslucent = false
        
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
        checkBlessBtn()
        fetchReply()
    }
    
    //축복해요 체크 버튼
    func checkBlessBtn(){
        let currentUid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("bless").child(pidLabel.text!).observe(.value) { (snapshot) in
            for child in snapshot.children{
               
                let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기

                if let checkUid = childValue["uid"]{
                    if(checkUid as? String == currentUid){
                        print("이미 좋아요를 눌렀네요?")
                        self.likeButton.tintColor = UIColor.lightGray
                        self.likesLabel.textColor = UIColor.lightGray
                        self.likeButton.isEnabled = false
                    }
                }
                
            }
        }
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
        
        
        uiScrollView.addSubview(showOrNotButton)
        uiScrollView.addSubview(seeImage)
        uiScrollView.addSubview(replyImage)
        uiScrollView.addSubview(likeButton)
        uiScrollView.addSubview(likesLabel)
        
        uiScrollView.addSubview(uidLabel)
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
        nameLabel.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: txtLabel.topAnchor, constant: -15).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: uiScrollView.widthAnchor).isActive = true
        
        
        showOrNotButton.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        showOrNotButton.trailingAnchor.constraint(equalTo: dateLabel.leadingAnchor, constant: -15).isActive = true
        showOrNotButton.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        
        txtLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        txtLabel.trailingAnchor.constraint(equalTo: uiScrollView.trailingAnchor).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: txtLabel.trailingAnchor).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 12).isActive = true
        
        
        seeImage.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 15).isActive = true
        seeImage.leadingAnchor.constraint(equalTo: uiScrollView.leadingAnchor, constant: 0).isActive = true
        seeImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
        seeImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        seeImage.bottomAnchor.constraint(equalTo: replyHitLabel.bottomAnchor).isActive = true
        
        
        hitLabel.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 15).isActive = true
        hitLabel.leadingAnchor.constraint(equalTo: seeImage.trailingAnchor, constant: 5).isActive = true
        hitLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        hitLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        hitLabel.bottomAnchor.constraint(equalTo: replyHitLabel.bottomAnchor).isActive = true
        
        
        replyImage.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 15).isActive = true
        replyImage.leadingAnchor.constraint(equalTo: hitLabel.trailingAnchor, constant: 15).isActive = true
        replyImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
        replyImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        replyImage.bottomAnchor.constraint(equalTo: replyHitLabel.bottomAnchor).isActive = true
        
        
        replyHitLabel.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 15).isActive = true
        replyHitLabel.leadingAnchor.constraint(equalTo: replyImage.trailingAnchor, constant: 5).isActive = true
        replyHitLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        replyHitLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
        likeButton.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 15).isActive = true
        likeButton.leadingAnchor.constraint(equalTo: replyHitLabel.trailingAnchor, constant: 10).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        likeButton.bottomAnchor.constraint(equalTo: replyHitLabel.bottomAnchor).isActive = true
        

        
        likesLabel.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 15).isActive = true
        likesLabel.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor, constant: 2).isActive = true
        likesLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        likesLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
       likesLabel.bottomAnchor.constraint(equalTo: replyHitLabel.bottomAnchor).isActive = true

        
        
        pidLabel.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 15).isActive = true
        pidLabel.leadingAnchor.constraint(equalTo: likesLabel.trailingAnchor, constant: 5).isActive = true
        pidLabel.widthAnchor.constraint(equalToConstant: 10).isActive = true
        pidLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        uidLabel.topAnchor.constraint(equalTo: txtLabel.bottomAnchor, constant: 15).isActive = true
        uidLabel.leadingAnchor.constraint(equalTo: pidLabel.trailingAnchor, constant: 5).isActive = true
        uidLabel.widthAnchor.constraint(equalToConstant: 10).isActive = true
        uidLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
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
    
    var replyCount: Int?
    //댓글 가져오기
    func fetchReply(){
        let ref = Database.database().reference()
        ref.child("replys").child(pidLabel.text!).queryOrdered(byChild: "date").observe(.value) { (snapshot) in
            self.replys.removeAll() //배열을 안지워 주면 계속 중복해서 쌓이게 된다.
            
            print("너 댓글 몃개니 \(Int(snapshot.childrenCount))")
            
            if(Int(snapshot.childrenCount) == 0){
               
                self.replyCount = 0
                ref.child("posts").child(self.pidLabel.text!).updateChildValues(["reply": self.replyCount ?? 0])
                
            }else{
                self.replyCount = Int(snapshot.childrenCount) //배열 총개수 할당
                ref.child("posts").child(self.pidLabel.text!).updateChildValues(["reply": self.replyCount ?? 0])
                
            }
            
            for child in snapshot.children{
                let replyToShow = Reply() //데이터를 담을 클래스
                let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                
                
                if let name = childValue["name"],  let date = childValue["date"], let rid = childValue["rid"], let text = childValue["text"], let pid = childValue["pid"],let uid = childValue["uid"]{
                    
                    //firebase에서 가져온 날짜 데이터를 ios 맞게 변환
                    if let t = date as? TimeInterval {
                        let date = NSDate(timeIntervalSince1970: t/1000)
                        print("---------------------\(NSDate(timeIntervalSince1970: t/1000))")
                        let dayTimePeriodFormatter = DateFormatter()
                        dayTimePeriodFormatter.dateFormat = "MMM d일 hh:mm a"
                        let dateString = dayTimePeriodFormatter.string(from: date as Date)
                        replyToShow.date = dateString
                    }
                    replyToShow.name = name as? String
                    replyToShow.rid = rid as? String
                    replyToShow.text = text as? String
                    replyToShow.pid = pid as? String
                    replyToShow.uid = uid as? String
                }
                self.replys.insert(replyToShow, at: 0) //
                
            }
            self.replyView.reloadData()
        }
        
        ref.removeAllObservers()
    }
    
    
    //글공개
    func showAction(pid:String){
        print("글나누기\(pid)")
        let showing = ["show" : "y"]
        //여기가 문제
        let ref = Database.database().reference()
        ref.child("posts").child(pid).updateChildValues(showing)
        let alert = UIAlertController(title: "알림 ", message:"글이 나눔방에 게시되었습니다.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //글비공개
    func noShowAction(pid:String){
        print("글비공개\(pid)")
        //fb db 연결 후 posts 테이블에 key가 pid인 데이터의 hit 개수 변경해주기
        let showing = ["show" : "n"]
        //여기가 문제
        let ref = Database.database().reference()
        ref.child("posts").child(pid).updateChildValues(showing)

    }
    
    //글 설정 네비게이션 바 버튼 아이템을 눌렀을 때
    @objc func goSettingAlertAction(){
        print(" 글 설정 얼러트 창 뛰우기")
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .alert)
        
        let showAction = UIAlertAction(title: "글공개", style: .default) { (alert) in
            print("글나누기")
            self.showAction(pid:self.pidLabel.text!)
            
        }
        
        
        let noShowAction = UIAlertAction(title: "비공개", style: .default) { (alert) in
            print("글비공개")
            
            self.noShowAction(pid:self.pidLabel.text!)
        }
        
        
        let modifyAction = UIAlertAction(title: "글수정", style: .default) { (alert) in
            print("댓글 수정")
            
            self.settingAlertAction(txt: self.txtLabel.text!, pid: self.pidLabel.text!)
        }
        
        let deleteAction = UIAlertAction(title: "글삭제", style: .destructive) { (alert) in
            
            let xss = self.replyHitLabel.text?.characters.split(separator:" ").map{ String($0) }
            let replyNum = Int(xss![0])!
            //댓글이 없을 때만 본인의 글을 지울 수 있다.
            if(replyNum == 0){
                let ref = Database.database().reference()
                ref.child("posts").child(self.pidLabel.text!).removeValue()
                let alert = UIAlertController(title: "알림 ", message:"삭제되었습니다.", preferredStyle: UIAlertControllerStyle.alert)
                let alertAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default,handler: { (action) in
                    self.navigationController?.popViewController(animated: true)
                } )
                
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            }else{
                
                let alert = UIAlertController(title: "알림 ", message:"댓글이 있는 글은 삭제할 수 없습니다.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel) { (alert) in
            print("취소")
        }
        
        alertController.addAction(modifyAction)
        alertController.addAction(deleteAction)
        alertController.addAction(showAction)
        alertController.addAction(noShowAction)
        alertController.addAction(cancelAction)
        
        self.present(
            alertController,
            animated: true,
            completion: nil)
        
    }
    
    
    //수다방 글 수정 alert controller 창
    var modifyMainText:String?
    func settingAlertAction(txt:String, pid:String)
    {
        
        let alertController = UIAlertController(title: "\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let margin:CGFloat = 8.0
        let rect = CGRect(margin, margin, alertController.view.bounds.size.width - margin * 15.0, 100.0)
        let customView = UITextView(frame: rect)
        
        customView.backgroundColor = UIColor.clear
        customView.font = UIFont(name: "Helvetica", size: 15)
        customView.text = txt
        alertController.view.addSubview(customView)
        
        let somethingAction = UIAlertAction(title: "수정", style: UIAlertActionStyle.default, handler: {(alert: UIAlertAction!) in //print("something")
            self.modifyText = customView.text
            
            let ref = Database.database().reference()
            ref.child("posts").child(pid).updateChildValues(["text":self.modifyText ?? "",
                                                             "date":ServerValue.timestamp()])
            let alert = UIAlertController(title: "알림 ", message:"수정되었습니다.", preferredStyle: UIAlertControllerStyle.alert)
            let alertAction = UIAlertAction(title: "확인", style: UIAlertActionStyle.default,handler: { (action) in
                self.navigationController?.popViewController(animated: true)
            } )
            
            alert.addAction(alertAction)
            self.present(alert, animated: true, completion: nil)
            
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
        
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion:{})
        
        
    }
    
}
extension CGRect {
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
}
}

