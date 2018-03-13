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
        
        
        // self.clearsSelectionOnViewWillAppear = false
        
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
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TalkCell
        
        //let post=posts.reversed()[indexPath.row]
        self.posts = self.posts.reversed()
        cell?.txtLabel.text = posts[indexPath.row].text
        cell?.hitLabel.text = "\(posts[indexPath.row].hit!) 번읽음"
        cell?.dateLabel.text = posts[indexPath.row].date
        cell?.nameLabel.text = posts[indexPath.row].name
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
        
    }
    
    //포스트 조회 함수
    func showPost(){
        let ref = Database.database().reference()
        
        

        
        
        
        ref.child("posts").queryOrdered(byChild: "date").observeSingleEvent(of: .value) { (snapshot) in
            let posts = snapshot.value as! [String:AnyObject]
            
            print("posts~~~~~~~~~ \(posts)")
            
            _ = snapshot.key // 키는 "users"
            self.posts.removeAll()
            
            //여기서 value는 full name = kangyoung ~~~ 이하 key:value
            for(_,value) in posts{
                
                if let name = value["name"], let hit = value["hit"], let date = value["date"], let pid = value["pid"] , let text = value["text"] , let uid = value["uid"] {
                    
                    if let name = name,let hit = hit ,let date = date,let pid = pid,let text = text,let uid = uid {
                        let postToShow = Post()
                        
                        
                         if let t = date as? TimeInterval {
                        // Cast the value to an NSTimeInterval
                        // and divide by 1000 to get seconds.
                            let date = NSDate(timeIntervalSince1970: t/1000)
                            
                          print("---------------------\(NSDate(timeIntervalSince1970: t/1000))")
                        
                            let dayTimePeriodFormatter = DateFormatter()
                            dayTimePeriodFormatter.dateFormat = "YYY-MMM-d hh:mm a"
                            
                            let dateString = dayTimePeriodFormatter.string(from: date as Date)
                            print(dateString)
                        // posts.sort({$0.date > $1.date})
                        
                        postToShow.name = name as! String
                        postToShow.hit = String(describing: hit)
                        postToShow.date = dateString
                        postToShow.pid = pid as! String
                        postToShow.text = text as! String
                        postToShow.uid = uid as! String

                        //배열에 넣기
                            //self.posts.insert(postToShow, at: 0)
                           
                            self.posts.append(postToShow)
                            
                        }
                    }
                }

                
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        ref.removeAllObservers()
    }
}



