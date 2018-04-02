//
//  MakatingAHVC.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 23..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import Firebase
import UIKit

class MakatingAHVC: UITableViewController,UISearchBarDelegate {

    var activityIndicatorView: UIActivityIndicatorView!
    
    
    
    var posts = [Post]()
    var searchPosts = [Post]()
    let cellId = "MaketingCellId"
    
    
    let searchController : UISearchController = {
        let uisearchController = UISearchController(searchResultsController: nil)
        uisearchController.searchBar.placeholder = "검색"
        //uisearchController.searchBar.barTintColor = UIColor.white
        uisearchController.searchBar.backgroundColor =  UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        return uisearchController
    }()
    
    //검색버튼 눌렀을 때
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchPosts.removeAll()
        
        searchPosts = posts.filter({ (post) -> Bool in
            guard let text = searchController.searchBar.text else{return false}
            return post.text.contains(text)
        })
        self.tableView.reloadData()
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
                self.tableView.separatorStyle = .singleLine
                Thread.sleep(forTimeInterval: 1.5)
                //   print("start forTimeInterval")
                self.activityIndicatorView.stopAnimating()
                self.tableView.reloadData()
            }
        }
        
        
        showPost()
        tableView.separatorColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        searchPosts.removeAll()
        searchController.searchBar.delegate = self
        
        //네비게이션 바 색깔 변경
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        self.navigationController?.navigationBar.isTranslucent = false
        
        
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        self.navigationItem.title = "동네홍보"
        //navigationController?.navigationBar.prefersLargeTitles = false
        //navigationItem.searchController = searchController
        
        
        
        if let currentEmail = Auth.auth().currentUser?.email {
            print("소식방에 접근한 아이디 \(currentEmail )")
            if(currentEmail == "admin@naver.com" || currentEmail == "admin1@naver.com"||currentEmail == "admin2@naver.com"||currentEmail == "admin3@naver.com" || currentEmail == "admin4@naver.com"){
                //글쓰기 방
                self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_border_color.png"), style: .plain, target: self, action:  #selector(writeAction))
            }
        }
        
        tableView.register(MaketingCell.self, forCellReuseIdentifier: cellId)
        
        //self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0);
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        //print("end view didLoad")
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
                    let writeView = MaketingWriteVC()
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
        if(searchController.isActive && searchController.searchBar.text != ""){
            return searchPosts.count
        }
        return posts.count
    }
    
    //테이블 뷰 셀의 구성 및 데이터 할당 부분
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MaketingCell
        
        
        //cell 클릭했을 때 색깔 바꿔주기
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        cell?.selectedBackgroundView = bgColorView
        
        if(searchController.isActive && searchController.searchBar.text != ""){
            cell?.dateLabel.text = searchPosts[indexPath.row].date
            cell?.nameLabel.text = searchPosts[indexPath.row].name
            cell?.replyHitLabel.text = "\(searchPosts[indexPath.row].reply!) 개 댓글"
            cell?.pidLabel.text = searchPosts[indexPath.row].pid
            cell?.hitLabel.text = "\(searchPosts[indexPath.row].hit!) 번 읽음"
            cell?.txtLabel.text = searchPosts[indexPath.row].text
            cell?.uidLabel.text = searchPosts[indexPath.row].uid
            
        }else{
            cell?.txtLabel.text = posts[indexPath.row].text
            cell?.hitLabel.text = "\(posts[indexPath.row].hit!) 번 읽음"
            cell?.dateLabel.text = posts[indexPath.row].date
            cell?.nameLabel.text = posts[indexPath.row].name
            cell?.pidLabel.text = posts[indexPath.row].pid
            cell?.replyHitLabel.text = "\(posts[indexPath.row].reply!) 개 댓글"
            cell?.uidLabel.text = posts[indexPath.row].uid
            
        }
        
        return cell!
    }
    
    //셀의 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    //셀을 클릭했을 때
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        print("셀 클릭")
        
        //선택한 셀 정보 가져오기
        let cell = tableView.cellForRow(at: indexPath) as? MaketingCell
        
        //값 할당
        let name = cell?.nameLabel.text
        let text = cell?.txtLabel.text
        let hit = cell?.hitLabel.text
        let date = cell?.dateLabel.text
        let pid = cell?.pidLabel.text
        let replyHitLabel = cell?.replyHitLabel.text
        let uid = cell?.uidLabel.text
        
        //조회수 문자를 배열로 변경
        let xs = hit!.characters.split(separator:" ").map{ String($0) }
        let hitNum = Int(xs[0])! + 1
        
        //fb db 연결 후 posts 테이블에 key가 pid인 데이터의 hit 개수 변경해주기
        let hiting = ["hit" : hitNum]
        //여기가 문제
        let ref = Database.database().reference()
        ref.child("maketings").child(pid!).updateChildValues(hiting)
        
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
        
        //디테일 페이지로 이동
        let detailTalkViewController = MaketingDetailVC()
        detailTalkViewController.onePost = onePost
        //글쓰기 화면을 rootView로 만들어 주기
        navigationController?.pushViewController(detailTalkViewController, animated: true)
    }
    
    //포스트 조회 함수
    func showPost(){
        //AppDelegate.instance().showActivityIndicator()
        print("start showPost")
        let ref = Database.database().reference()
        ref.child("maketings").queryOrdered(byChild: "date").observe(.value) { (snapshot) in
            self.posts.removeAll() //배열을 안지워 주면 계속 중복해서 쌓이게 된다.
            for child in snapshot.children{
                
                let postToShow = Post() //데이터를 담을 클래스
                let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                
                
                if let name = childValue["name"],  let date = childValue["date"], let hit = childValue["hit"], let pid = childValue["pid"], let uid = childValue["uid"], let text = childValue["text"], let reply = childValue["reply"] {
                    
                    //firebase에서 가져온 날짜 데이터를 ios 맞게 변환
                    if let t = date as? TimeInterval {
                        let date = NSDate(timeIntervalSince1970: t/1000)
                        // print("---------------------\(NSDate(timeIntervalSince1970: t/1000))")
                        let dayTimePeriodFormatter = DateFormatter()
                        dayTimePeriodFormatter.dateFormat = "MMM d일 hh:mm a"
                        let dateString = dayTimePeriodFormatter.string(from: date as Date)
                        postToShow.date = dateString
                    }
                    postToShow.name = name as! String
                    postToShow.hit = String(describing: hit)
                    postToShow.pid = pid as! String
                    postToShow.text = text as! String
                    postToShow.uid = uid as! String
                    postToShow.reply = String(describing: reply)
                }
                self.posts.insert(postToShow, at: 0) //
            }
            self.tableView.reloadData()
        }
        
        print("end showPost")
        //activityIndicatorView.stopAnimating()
    }
    
    


}
