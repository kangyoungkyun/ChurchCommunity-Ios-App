//
//  BirthViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 19..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit
import Firebase
class BirthViewController: UITableViewController {
    
    
    func getMonth() -> String{
        let date = Date()
        let calendar = Calendar.current //켈린더 객체 생성
        let month = calendar.component(.month, from: date)  //월
        return String(month)
    }
    
    var activityIndicatorView: UIActivityIndicatorView!
    private let reuseIdentifier = "myCell"
    var births = [Birth]()
    //테이블 풋터 뷰
    let tableViewFooterV: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: Int(0.5))
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
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
        
        print("start 인디케이터")
        
        DispatchQueue.main.async {
            print("start DispatchQueue")
            OperationQueue.main.addOperation() {
                print("start OperationQueue")
                self.tableView.separatorStyle = .singleLine
                Thread.sleep(forTimeInterval: 1.5)
                print("start forTimeInterval")
                self.activityIndicatorView.stopAnimating()
                self.tableView.reloadData()
            }
        }
        
        
        view.backgroundColor = .clear
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        self.navigationController?.navigationBar.isTranslucent = false
        //navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = self.getMonth()+"월 생일자"
        
        tableView.register(BirthCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = tableViewFooterV
        loadBirthData()
    }
    
    func loadBirthData(){
        print("loadBirthData")
        let ref = Database.database().reference()
        ref.child("users").queryOrderedByKey().observe(.value) { (snapshot) in
            self.births.removeAll()
            for child in snapshot.children{
                let birthToShow = Birth()
                let childSnapshot = child as! DataSnapshot
                let childValue = childSnapshot.value as! [String:Any]
                
                if let birth =  childValue["birth"]{
                    let result = (birth as? String)?.components(separatedBy: ["월","일"]).joined()
                    let xs = result!.characters.split(separator:" ").map{ String($0) }
                    let month = xs[0]
                    if(month == self.getMonth()){
                        if let uid = childValue["uid"],let name = childValue["name"], let imageURL =  childValue["imgurl"]{
                            
                            birthToShow.uid = uid as? String
                            birthToShow.name = name as? String
                            birthToShow.imageURL = imageURL as? String
                            birthToShow.birth = birth as? String
                            
                            self.births.append(birthToShow)
                        }
                    }
                    
                }
                
            }
            self.tableView.reloadData()
            
        }
        ref.removeAllObservers()
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return births.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? BirthCell
        cell?.textLabel?.text = births[indexPath.row].name
        cell?.detailTextLabel?.text = births[indexPath.row].birth
        cell?.imageUrl = births[indexPath.row].imageURL
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
   

     //테이블 뷰 셀 클릭했을 때 해당 유저 페이지로 넘어가기
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = ShowPageViewController()
        viewController.userUid = births[indexPath.row].uid
        //userProfile 화면을 rootView로 만들어 주기
        navigationController?.pushViewController(viewController, animated: true)
    }
    
 
}
