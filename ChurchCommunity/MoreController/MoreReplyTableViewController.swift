//
//  MoreReplyTableViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 19..
//  Copyright © 2018년 MacBookPro. All rights reserved.
// 내가쓴 댓글 보기

import UIKit
import Firebase
class MoreReplyTableViewController: UITableViewController {
    var replys = [Reply]()
    let cellId = "cellId"
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = tableViewFooterView //풋터 뷰
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        self.navigationController?.navigationBar.isTranslucent = false
        
fetchReply()
        self.navigationItem.title = "글목록"
        ////navigationController?.navigationBar.prefersLargeTitles = false
        tableView.register(MoreReplyCell.self, forCellReuseIdentifier: cellId)
        self.tableView.estimatedRowHeight = 80
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }



    let tableViewFooterView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: Int(0.5))
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if replys.count == 0 {
            return 1
        }
        
        return replys.count
    }
    override func tableView(_ : UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:cellId, for: indexPath) as? MoreReplyCell
        //cell?.isExclusiveTouch = true
        
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
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        
    }
    
    
    //댓글 가져오기
    func fetchReply(){
        let ref = Database.database().reference()
        ref.child("replys").queryOrderedByKey().observe(.value) { (snapshot) in
            self.replys.removeAll() //배열을 안지워 주면 계속 중복해서 쌓이게 된다.
            
            let myKey = Auth.auth().currentUser?.uid
            for child in snapshot.children{
                let replyToShow = Reply() //데이터를 담을 클래스
                let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                for (_,val)  in childValue{
                  let uidValue =  val as? [String:Any]
                    if let uid = uidValue {
                        if let uidd = uid["uid"] ,let name = uid["name"],let date = uid["date"],let rid = uid["rid"],let text = uid["text"],let pid = uid["pid"] {
                            
                            if(String(describing: uidd) == myKey){
                                
                                print(String(describing: uidd))
                                print("플리즈")
                                print(myKey)
                               
                                    //firebase에서 가져온 날짜 데이터를 ios 맞게 변환
                                    if let t = date as? TimeInterval {
                                        let date = NSDate(timeIntervalSince1970: t/1000)
                                        print("---------------------\(NSDate(timeIntervalSince1970: t/1000))")
                                        let dayTimePeriodFormatter = DateFormatter()
                                        dayTimePeriodFormatter.dateFormat = "YYY-MMM-d hh:mm a"
                                        let dateString = dayTimePeriodFormatter.string(from: date as Date)
                                        replyToShow.date = dateString
                                    }
                                    replyToShow.name = name as? String
                                    replyToShow.rid = rid as? String
                                    replyToShow.text = text as? String
                                    replyToShow.pid = pid as? String
                                    replyToShow.uid = uidd as? String
                                    self.replys.insert(replyToShow, at: 0)
                                    print(self.replys.count)
                                
                            }
                        }
                    }
                }
            }
            self.tableView.reloadData()
        }
        
        ref.removeAllObservers()
    }
    
    
    //댓글 수정 alert controller 창
    var modifyText:String?
    func popUpController(txt:String,rid:String,pid:String)
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
           ref.child("replys").child(pid).child(rid).updateChildValues(["text":self.modifyText ?? "", "date":ServerValue.timestamp()])
            
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertActionStyle.cancel, handler: {(alert: UIAlertAction!) in print("cancel")})
        
        alertController.addAction(somethingAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion:{})
        
        
    }
    
    
    //댓글 셀을 선택했을 때
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("셀을 선택했습니다~!  \(indexPath.row)")
        
        //선택한 셀 정보 가져오기
        let cell = tableView.cellForRow(at: indexPath) as? MoreReplyCell
        let rid = cell?.ridLable.text
        let uid = cell?.uidLabel.text
        //let name = cell?.nameLabel.text
        let text = cell?.txtLabel.text
        // let date = cell?.dateLabel.text
        let pid = cell?.pidLabel.text
        
        let alertController = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .alert)
        
        let modifyAction = UIAlertAction(title: "댓글수정", style: .default) { (alert) in
            print("댓글 수정")
            
            if(Auth.auth().currentUser?.uid == uid){
                
                self.popUpController(txt: text!,rid:rid!,pid:pid!)
                
            }else{
                
                let alert = UIAlertController(title: "알림 ", message:"본인의 글만 수정할 수 있습니다.", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
        }

        //내가쓴 댓글 삭제
        let deleteAction = UIAlertAction(title: "댓글삭제", style: .destructive) { (alert) in
            if(Auth.auth().currentUser?.uid == uid){
 
                let ref = Database.database().reference()
                ref.child("replys").child(pid!).child(rid!).removeValue()
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
    
}
