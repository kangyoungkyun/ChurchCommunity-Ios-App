//
//  SettingViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 12..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit
import Firebase
import MessageUI
class SettingViewController: UITableViewController, MFMailComposeViewControllerDelegate {
     var ref: DatabaseReference!
    
    
    //테이블 풋터 뷰
    let tableViewFooterV: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: Int(0.5))
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
        //섹션 제목 설정
        override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
                let label = UILabel()
                //label.text = "Header"
                label.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.96, alpha:1.0)
                return label
            }

        let twoDimenstionArray = [
                ["아중감 소식","사용설명서","버전정보","오픈소스"],
                ["내가쓴글","내가쓴댓글","로그아웃"],
                ["개발자에게"]
            ]
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 17.0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = tableViewFooterV
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.98, green:0.72, blue:0.16, alpha:1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "더보기"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        //firebase 데이터 베이스 초기화
        ref = Database.database().reference()
    }



    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let section = indexPath.section
        let row = indexPath.row
    
        
        //공지사항
        if(section == 0 && row == 0){
           
            ref.child("more").child("notice").observe(.value, with: { (snapshot) in
                let childSnapshot = snapshot as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                if let value = childValue["n"] as? String{
                    let viewController = MoreNoticeViewController()
                    viewController.titleName = "아중감 소식"
                   viewController.text = value
                    self.ref.removeAllObservers()
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
              
            })
            
        
        //사용설명서
        }else if (section == 0 && row == 1){
             print("사용설명서")
            ref.child("more").child("des").observe(.value, with: { (snapshot) in
                let childSnapshot = snapshot as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                if let value = childValue["d"] as? String{
                    let viewController = MoreNoticeViewController()
                    viewController.titleName = "사용설명서"
                    viewController.text = value
                    self.ref.removeAllObservers()
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
                
            })
        }else if (section == 0 && row == 2){
            print("버전정보")
            ref.child("more").child("ver").observe(.value, with: { (snapshot) in
                let childSnapshot = snapshot as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                if let value = childValue["v"] as? String{
                    let viewController = MoreNoticeViewController()
                    viewController.titleName = "버전정보"
                    viewController.text = value
                    self.ref.removeAllObservers()
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
                
            })
        }else if (section == 0 && row == 3){
            print("오픈소스")
            ref.child("more").child("open").observe(.value, with: { (snapshot) in
                let childSnapshot = snapshot as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                if let value = childValue["o"] as? String{
                    let viewController = MoreNoticeViewController()
                    viewController.titleName = "오픈소스"
                    viewController.text = value
                    self.ref.removeAllObservers()
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
                
            })
        }else if (section == 1 && row == 0){
            print("내가쓴글")
            let viewController = MoreWriteTableViewController()
             self.navigationController?.pushViewController(viewController, animated: true)
            
        }else if (section == 1 && row == 1){
            print("내가쓴댓글")
            let viewController = MoreReplyTableViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
        }else if (section == 1 && row == 2){
            print("로그아웃")
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                self.dismiss(animated: true, completion: nil)
            } catch let signOutError as NSError {
                print ("Error signing out: %@", signOutError)
            }
        }else if (section == 2 && row == 0){
            print("개발자에게")
            
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail(){
                self.present(mailComposeViewController, animated: true, completion: nil)
            }else{
                self.showSendMailErrorAlert()
            }
        }
    }
    
    
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return twoDimenstionArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return twoDimenstionArray[section].count

    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

               let name =  twoDimenstionArray[indexPath.section][indexPath.row]
                //let name = self.names[indexPath.row]
                cell.textLabel?.text = name
                cell.textLabel?.text = "\(name)"
                cell.textLabel?.textAlignment = .center
                cell.textLabel?.textColor = UIColor(red:0.98, green:0.72, blue:0.16, alpha:1.0)
                cell.textLabel?.font = UIFont.systemFont(ofSize: 17)
        
        return cell
    }
 

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    
    
    //메일 컨트롤
    func configuredMailComposeViewController() -> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["abcnt@naver.com"])
        mailComposerVC.setSubject("아중감 청년부 앱관련 문의")
        mailComposerVC.setMessageBody("안녕하세요.\n\n\n", isHTML: false)
        return mailComposerVC
    }
    //메일 보내기 에러
    func showSendMailErrorAlert(){
        let sendMailErrorAlert = UIAlertView(title: "알림", message: "메일을 보내지 못했습니다.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    //보내기 버튼 눌렀을때 결과
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result.rawValue {
        case MFMailComposeResult.cancelled.rawValue:
            
            print("메일 보내기가 취소되었습니다.")
        case MFMailComposeResult.sent.rawValue:
            
            print("메일 보내기 성공")
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
    }
}
