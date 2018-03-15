//
//  TalkTableViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 12..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit
import Firebase
class TalkViewController: UITableViewController {
    
    var posts = [Post]()
    let cellId = "cellId"
    
    override func viewWillAppear(_ animated: Bool) {
        showPost()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션 바 색깔 변경
        self.navigationController?.navigationBar.barTintColor = UIColor.cyan
        self.navigationController?.navigationBar.isTranslucent = false
        
        self.navigationItem.title = "수다방"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(logoutAction))
      
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "글쓰기", style: .plain, target: self, action: #selector(writeAction))
        
        tableView.register(TalkCell.self, forCellReuseIdentifier: cellId)
        
       
        
        //self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0);
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        
        //포스트 조회
        showPost()
    }
    
    //로그아웃
    @objc func logoutAction(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    //글쓰기
    @objc func writeAction(){
        print ("글쓰기 창이 열립니다.")
        //글쓰기 화면
        let writeView = WriteViewController()
        //글쓰기 화면을 rootView로 만들어 주기
        let navController = UINavigationController(rootViewController: writeView)
        present(navController, animated: true, completion: nil)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    //테이블 뷰 셀의 구성 및 데이터 할당 부분
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TalkCell
        
        cell?.txtLabel.text = posts[indexPath.row].text
        cell?.hitLabel.text = "\(posts[indexPath.row].hit!) 번 읽음"
        cell?.dateLabel.text = posts[indexPath.row].date
        cell?.nameLabel.text = posts[indexPath.row].name
        cell?.pidLabel.text = posts[indexPath.row].pid
        
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
        let cell = tableView.cellForRow(at: indexPath) as? TalkCell
        //값 할당
        let name = cell?.nameLabel.text
        let text = cell?.txtLabel.text
        let hit = cell?.hitLabel.text
        //let reply = cell?.replyHitLabel.text
        let date = cell?.dateLabel.text
        let pid = cell?.pidLabel.text
        
      
        //조회수 문자를 배열로 변경
        let xs = hit!.characters.split(separator:" ").map{ String($0) }
        let hitNum = Int(xs[0])! + 1
        
       //fb db 연결 후 posts 테이블에 key가 pid인 데이터의 hit 개수 변경해주기
        
        let hiting = ["hit" : hitNum]
        let ref = Database.database().reference()
        ref.child("posts").child(pid!).updateChildValues(hiting)
        
        
        
        let onePost = Post()
        onePost.name = name
        onePost.text = text
        onePost.hit = String(hitNum)
        onePost.date = date
        onePost.pid = pid
        
        ref.removeAllObservers()
        
        //디테일 페이지로 이동
        let detailTalkViewController = DetailTalkViewController()
        detailTalkViewController.onePost = onePost
        //글쓰기 화면을 rootView로 만들어 주기
        navigationController?.pushViewController(detailTalkViewController, animated: true)
    }
    
    //포스트 조회 함수
    func showPost(){
        let ref = Database.database().reference()
        ref.child("posts").queryOrdered(byChild: "date").observe(.value) { (snapshot) in
            self.posts.removeAll() //배열을 안지워 주면 계속 중복해서 쌓이게 된다.
            for child in snapshot.children{
                
                let postToShow = Post() //데이터를 담을 클래스
                let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                
                if let name = childValue["name"],  let date = childValue["date"], let hit = childValue["hit"], let pid = childValue["pid"], let uid = childValue["uid"], let text = childValue["text"] {

                    //firebase에서 가져온 날짜 데이터를 ios 맞게 변환
                    if let t = date as? TimeInterval {
                        let date = NSDate(timeIntervalSince1970: t/1000)
                        print("---------------------\(NSDate(timeIntervalSince1970: t/1000))")
                        let dayTimePeriodFormatter = DateFormatter()
                        dayTimePeriodFormatter.dateFormat = "YYY-MMM-d hh:mm a"
                        let dateString = dayTimePeriodFormatter.string(from: date as Date)
                        postToShow.date = dateString
                    }
                    postToShow.name = name as! String
                    postToShow.hit = String(describing: hit)
                    postToShow.pid = pid as! String
                    postToShow.text = text as! String
                    postToShow.uid = uid as! String
                }
                self.posts.insert(postToShow, at: 0) //
            }
            self.tableView.reloadData()
        }
        ref.removeAllObservers()
}

}

