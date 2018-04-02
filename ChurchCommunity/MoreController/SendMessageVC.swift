//
//  SendMessageVC.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 25..
//  Copyright © 2018년 MacBookPro. All rights reserved.

// 보낸쪽지
import UIKit
import Firebase
class SendMessageVC: UITableViewController {
    var msgs = [Message]()
    var cellId = "sendMsg"
    var myUid : String?
    var activityIndicatorView: UIActivityIndicatorView!
    
    let tableViewFooterView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: Int(0.5))
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(MessageCell.self, forCellReuseIdentifier: cellId)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "이전", style: .plain, target: self, action: #selector(cancel))
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        
        view.backgroundColor = .white
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        self.navigationController?.navigationBar.isTranslucent = false
        ////navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "보낸쪽지"
        let textAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        tableView.tableFooterView = tableViewFooterView //풋터 뷰
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -80).isActive = true
        activityIndicatorView.bringSubview(toFront: self.view)
        activityIndicatorView.startAnimating()
        
        print("start 인디케이터")
        
        DispatchQueue.main.async {
            print("start DispatchQueue")
            OperationQueue.main.addOperation() {
                print("start OperationQueue")
                
                Thread.sleep(forTimeInterval: 1.0)
                print("start forTimeInterval")
                self.activityIndicatorView.stopAnimating()
                
            }
        }
        
        showMessage()
    }
    
    //이전
    @objc func cancel(){
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return msgs.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MessageCell
        cell?.dateLabel.text = msgs[indexPath.row].date
        cell?.nameLabel.text = "To.\(msgs[indexPath.row].name!)"
        cell?.txtLabel.text = msgs[indexPath.row].content
        
        return cell!
    }
    
    //메시지 가져오기
    func showMessage(){
        print("보낸 메시지 가져오기 함수")
        let myUid = Auth.auth().currentUser?.uid
        let ref = Database.database().reference()
        ref.child("messages").queryOrdered(byChild: "date").observe(.value) { (snapshot) in
            self.msgs.removeAll() //배열을 안지워 주면 계속 중복해서 쌓이게 된다.
            for child in snapshot.children{
                
                let messageToShow = Message() //데이터를 담을 클래스
                let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                
                if let name = childValue["toname"], let date = childValue["date"], let fromid = childValue["fromid"], let text = childValue["content"]{
                    
                    if(fromid as? String == myUid!){
                        //firebase에서 가져온 날짜 데이터를 ios 맞게 변환
                        if let t = date as? TimeInterval {
                            let date = NSDate(timeIntervalSince1970: t/1000)
                            // print("---------------------\(NSDate(timeIntervalSince1970: t/1000))")
                            let dayTimePeriodFormatter = DateFormatter()
                            dayTimePeriodFormatter.dateFormat = "MMM d일 hh:mm a"
                            let dateString = dayTimePeriodFormatter.string(from: date as Date)
                            messageToShow.date = dateString
                        }
                        messageToShow.name = name as? String
                        messageToShow.content = text as? String
                        self.msgs.insert(messageToShow, at: 0) //
                    }
                }
            }
            self.tableView.reloadData()
        }
        ref.removeAllObservers()
    }
}
