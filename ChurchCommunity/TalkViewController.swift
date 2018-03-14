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
        
        self.navigationItem.title = "수다방"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "logout", style: .plain, target: self, action: #selector(logoutAction))
        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "글쓰기", style: .plain, target: self, action: #selector(writeAction))
        
        tableView.register(TalkCell.self, forCellReuseIdentifier: cellId)
        
        //self.tableView.contentInset = UIEdgeInsetsMake(5, 0, 5, 0);
        
        
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
        
        //let post=posts.reversed()[indexPath.row]
        //self.posts = self.posts.reversed()
        cell?.txtLabel.text = posts[indexPath.row].text
        cell?.hitLabel.text = "\(posts[indexPath.row].hit!) 번읽음"
        cell?.dateLabel.text = posts[indexPath.row].date
        cell?.nameLabel.text = posts[indexPath.row].name
        
        return cell!
    }
    
    //셀의 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
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

