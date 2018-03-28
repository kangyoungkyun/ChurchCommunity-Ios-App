//
//  NoticeAHVC.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 23..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit
import Firebase
class NoticeAHVC: UITableViewController,UISearchBarDelegate {

    var activityIndicatorView: UIActivityIndicatorView!
    
    
    //테이블 뷰 셀에서 이름이 클릭되었을 때
    func userClickCell(uid: String) {
        
        let viewController = ShowPageViewController()
        viewController.userUid = uid
        //userProfile 화면을 rootView로 만들어 주기
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    var posts = [Post]()
    var searchPosts = [Post]()
    let cellId = "cellId"
    
    
 /*   let searchController : UISearchController = {
        let uisearchController = UISearchController(searchResultsController: nil)
        uisearchController.searchBar.placeholder = "검색"
        //uisearchController.searchBar.barTintColor = UIColor.white
        uisearchController.searchBar.backgroundColor =  UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)
        
        return uisearchController
    }()*/
    
    
    //검색버튼 눌렀을 때
   /* func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchPosts.removeAll()
        //print("서치바 \(String(describing: searchController.searchBar.text!))")
        searchPosts = posts.filter({ (post) -> Bool in
            guard let text = searchController.searchBar.text else{return false}
            return post.text.contains(text)
        })
        self.tableView.reloadData()

    }*/
    
    

     //탭바 스크롤 하면 숨기기
   override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
    if scrollView.panGestureRecognizer.translation(in: scrollView).y < 0{
        changeTabBar(hidden: true, animated: true)
    }
    else{
        changeTabBar(hidden: false, animated: true)
    }
    }
    func changeTabBar(hidden:Bool, animated: Bool){
        print("changeTabbar")
        guard let tabBar = self.tabBarController?.tabBar else { return; }
        if tabBar.isHidden == hidden{ return }
        let frame = tabBar.frame
        let offset = hidden ? frame.size.height : -frame.size.height
        let duration:TimeInterval = (animated ? 0.5 : 0.0)
        tabBar.isHidden = false
        
        UIView.animate(withDuration: duration, animations: {
            tabBar.frame = frame.offsetBy(dx: 0, dy: offset)
        }, completion: { (true) in
            tabBar.isHidden = hidden
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let headrView = UIView()
        headrView.backgroundColor = UIColor.lightGray
        headrView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height:150)
        tableView.tableHeaderView = headrView
        tableView.backgroundColor = UIColor(red:0.97, green:0.97, blue:0.97, alpha:1.0)
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -60).isActive = true
        activityIndicatorView.bringSubview(toFront: self.view)
        activityIndicatorView.startAnimating()
        tableView.separatorStyle = .none
        
        //print("start 인디케이터")
        
        DispatchQueue.main.async {
            // print("start DispatchQueue")
            OperationQueue.main.addOperation() {
                //   print("start OperationQueue")
                 self.tableView.separatorStyle = .none
                Thread.sleep(forTimeInterval: 1.3)
                //   print("start forTimeInterval")
                self.activityIndicatorView.stopAnimating()
                self.tableView.reloadData()
            }
        }
        
        
        showPost()
        
        searchPosts.removeAll()
        //searchController.searchBar.delegate = self
        
        //네비게이션 바 색깔 변경
        self.navigationController?.navigationBar.barTintColor = .lightGray
        self.navigationController?.navigationBar.isTranslucent = false
        

        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "MY"
        navigationController?.navigationBar.prefersLargeTitles = false
        //navigationItem.searchController = searchController
        
        
        
        //글쓰기 방
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_create.png"), style: .plain, target: self, action:  #selector(writeAction))
        
               // self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:#imageLiteral(resourceName: "ic_create.png"), style: .plain, target: self, action:  #selector(myAction))

        
        tableView.register(TalkCell.self, forCellReuseIdentifier: cellId)
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        //네비게이션 바 색깔 변경
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.red
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
    }

override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
}

override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
}
    
    
    //mypage보기
    @objc func myAction(){
        let viewController = ShowPageViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    
    //글쓰기
    @objc func writeAction(){
        
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
                    return
                }else if(pass == "y"){
                    //글쓰기 화면
                    let writeView = WriteViewController()
                    //글쓰기 화면을 rootView로 만들어 주기
                    let navController = UINavigationController(rootViewController: writeView)
                    self.present(navController, animated: true, completion: nil)
                }
            }
            
        }
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    //행 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       /* if(searchController.isActive && searchController.searchBar.text != ""){
            return searchPosts.count
        }*/
        return posts.count
    }
    
    //테이블 뷰 셀의 구성 및 데이터 할당 부분
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TalkCell
        
        //cell?.delegate = self
        
        
      //  let screenSize = UIScreen.main.bounds
      //  let separatorHeight = CGFloat(3.0)
      //  let additionalSeparator = UIView.init(frame: CGRect(x: 0, y: (cell?.frame.size.height)!-separatorHeight, width: screenSize.width, height: separatorHeight))
       // additionalSeparator.backgroundColor = UIColor(red:0.37, green:0.51, blue:0.71, alpha:1.0)
        
       // cell?.addSubview(additionalSeparator)
        
        cell?.txtLabel.text = posts[indexPath.row].text
        cell?.txtLabel.setLineSpacing(lineSpacing: 7)
        cell?.txtLabel.textAlignment = .center
        cell?.hitLabel.text = "\(posts[indexPath.row].hit!) 번 읽음"
        cell?.dateLabel.text = posts[indexPath.row].date
        cell?.nameLabel.text = posts[indexPath.row].name
        cell?.pidLabel.text = posts[indexPath.row].pid
        cell?.replyHitLabel.text = "\(posts[indexPath.row].reply!) 개 댓글"
        cell?.uidLabel.text = posts[indexPath.row].uid
        cell?.showOrNotButton.setTitle(posts[indexPath.row].show, for: UIControlState())
        
        if(posts[indexPath.row].blessCount == nil){
            cell?.likesLabel.text = "0 명"
        }else{
            cell?.likesLabel.text = "\(posts[indexPath.row].blessCount!) 명"
        }
        
        /*if(searchController.isActive && searchController.searchBar.text != ""){
            cell?.dateLabel.text = searchPosts[indexPath.row].date
            cell?.nameLabel.text = searchPosts[indexPath.row].name
            cell?.replyHitLabel.text = "\(searchPosts[indexPath.row].reply!) 개 댓글"
            cell?.pidLabel.text = searchPosts[indexPath.row].pid
            cell?.hitLabel.text = "\(searchPosts[indexPath.row].hit!) 번 읽음"
            cell?.txtLabel.text = searchPosts[indexPath.row].text
            cell?.uidLabel.text = searchPosts[indexPath.row].uid
             cell?.showOrNotButton.setTitle(searchPosts[indexPath.row].show, for: UIControlState())
            if(searchPosts[indexPath.row].blessCount == nil){
                cell?.likesLabel.text = "0 명"
            }else{
                cell?.likesLabel.text = "\(searchPosts[indexPath.row].blessCount!) 명"
            }
            
        }else{
            cell?.txtLabel.text = posts[indexPath.row].text
            cell?.hitLabel.text = "\(posts[indexPath.row].hit!) 번 읽음"
            cell?.dateLabel.text = posts[indexPath.row].date
            cell?.nameLabel.text = posts[indexPath.row].name
            cell?.pidLabel.text = posts[indexPath.row].pid
            cell?.replyHitLabel.text = "\(posts[indexPath.row].reply!) 개 댓글"
            cell?.uidLabel.text = posts[indexPath.row].uid
            cell?.showOrNotButton.setTitle(posts[indexPath.row].show, for: UIControlState())
            if(posts[indexPath.row].blessCount == nil){
                cell?.likesLabel.text = "0 명"
            }else{
                cell?.likesLabel.text = "\(posts[indexPath.row].blessCount!) 명"
            }
            
        }*/
        
        return cell!
    }
    
    
    //셀을 클릭했을 때
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print("셀 클릭")
        
        //선택한 셀 정보 가져오기
        let cell = tableView.cellForRow(at: indexPath) as? TalkCell
        
        //값 할당
        let name = cell?.nameLabel.text
        let text = cell?.txtLabel.text
        let hit = cell?.hitLabel.text
        let date = cell?.dateLabel.text
        let pid = cell?.pidLabel.text
        let replyHitLabel = cell?.replyHitLabel.text
        let uid = cell?.uidLabel.text
        let show = cell?.showOrNotButton.titleLabel?.text
        
        //조회수 문자를 배열로 변경
        let xs = hit!.characters.split(separator:" ").map{ String($0) }
        let hitNum = Int(xs[0])! + 1
        
        //fb db 연결 후 posts 테이블에 key가 pid인 데이터의 hit 개수 변경해주기
        let hiting = ["hit" : hitNum]
        //여기가 문제
        let ref = Database.database().reference()
        ref.child("posts").child(pid!).updateChildValues(hiting)
        
        let xss = replyHitLabel!.characters.split(separator:" ").map{ String($0) }
        let replyNum = Int(xss[0])!
        
        let onePost = Post()
        onePost.name = name
        onePost.text = text
        onePost.hit = String(hitNum)
        onePost.date = date
        onePost.pid = pid
        onePost.reply = String(replyNum)
        onePost.uid = uid
        onePost.show = show
        
        //디테일 페이지로 이동
        let detailTalkViewController = DetailTalkViewController()
        detailTalkViewController.onePost = onePost
        //글쓰기 화면을 rootView로 만들어 주기
        navigationController?.pushViewController(detailTalkViewController, animated: true)
    }
    
    //포스트 조회 함수
    func showPost(){
        let myId = Auth.auth().currentUser?.uid
       
        print("start showPost")
        let ref = Database.database().reference()
        ref.child("posts").queryOrdered(byChild: "date").observe(.value) { (snapshot) in
            self.posts.removeAll() //배열을 안지워 주면 계속 중복해서 쌓이게 된다.
            for child in snapshot.children{
                
                let postToShow = Post() //데이터를 담을 클래스
                let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                
                    if let name = childValue["name"],  let date = childValue["date"], let hit = childValue["hit"], let pid = childValue["pid"], let uid = childValue["uid"], let text = childValue["text"], let reply = childValue["reply"], let show = childValue["show"]{
                    
                    if(myId == String(describing: uid)){
                        ref.child("bless").observe(.value, with: { (snapshot) in
                            
                            for (childs ) in snapshot.children{
                                
                                let childSnapshot = childs as! DataSnapshot
                                let key = childSnapshot.key
                                let val = childSnapshot.value as! [String:Any]
                                //let val = childSnapshot.value(forKeyPath: key!)
                                //print(pid,key,val.count)
                                if (key == pid as? String) {
                                    
                                    print(pid,key,val.count)
                                    postToShow.blessCount = "\(val.count)"
                                    
                                }
                            }
                            self.tableView.reloadData()
                        })
                        //firebase에서 가져온 날짜 데이터를 ios 맞게 변환
                        if let t = date as? TimeInterval {
                            let date = NSDate(timeIntervalSince1970: t/1000)
                            // print("---------------------\(NSDate(timeIntervalSince1970: t/1000))")
                            let dayTimePeriodFormatter = DateFormatter()
                            dayTimePeriodFormatter.dateFormat = "M월 d일 hh시"
                            let dateString = dayTimePeriodFormatter.string(from: date as Date)
                            postToShow.date = dateString
                        }
                        postToShow.name = name as! String
                        postToShow.hit = String(describing: hit)
                        postToShow.pid = pid as! String
                        postToShow.text = text as! String
                        postToShow.uid = uid as! String
                        postToShow.reply = String(describing: reply)
                        if(show as? String == "y"){
                            postToShow.show = "공개"
                        }else{
                             postToShow.show = "비공개"
                        }
                        
                        self.posts.insert(postToShow, at: 0) //
                    }
                }
                
            }
        }
        ref.removeAllObservers()
        
    }
}
