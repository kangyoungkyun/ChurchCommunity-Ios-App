//
//  MemoryViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 20..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit
import Firebase
class MemoryViewController: UITableViewController {

    let tableViewFooterView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 300, height: Int(20.5))
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    var videos:[Video] = [Video]()
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        //tableView.estimatedRowHeight = 180
        //tableView.rowHeight = UITableViewAutomaticDimension
        
        print("메모리 방에 들어왔슴다~~")
        tableView.tableFooterView = tableViewFooterView
        tableView.tableHeaderView = tableViewFooterView
         //self.tableView.contentInset = UIEdgeInsetsMake(10, 0, 30, 0);
        tableView.register(MemoryCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        showVideo()
        
        //let model = VideoModel()
        //self.videos = model.getVideo()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        self.navigationController?.navigationBar.isTranslucent = false
        //navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "영상방"
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? MemoryCell

        
        //cell.detailLabel.preferredMaxLayoutWidth = cell.frame.width
        //cell?.selectionStyle = UITableViewCellSelectionStyle.none
        let videoTitle = videos[indexPath.row].videoTitle
        
        //cell?.textLabel?.text = videoTitle
        cell?.uidLable.text = videoTitle
        
        let videoThumbnailUrlString = "https://i1.ytimg.com/vi/"+videos[indexPath.row].videoId!+"/mqdefault.jpg"
        //url 객체
        let videoThumnailUrl = URL(string: videoThumbnailUrlString)

        //조사
        if videoThumnailUrl != nil {
            let request = URLRequest(url: videoThumnailUrl!)
            
            //urlsession 객체를 통해 전송 및 응답값 처리 로직 작성
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                
                //서버가 응답이 없거나 통신이 실패했을 때
                if let e = error{
                    NSLog("an error has occurred: \(e.localizedDescription)")
                    return
                }
                
                DispatchQueue.main.async {
                    //셀에 있는 이미지뷰를 테그 값으로 가져오기
                    //let imageView = cell.viewWithTag(1) as! UIImageView
                    cell?.myImageView.image = UIImage(data:data!)
                }
                
            })
            task.resume()
        }
        return cell!
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width = self.view.frame.size.width
        let height = width/320 * 180
        return height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("추억방 셀 눌림")
        
        let selectedViedo = videos[indexPath.row]
       
        let viewController = VideoDetailViewController()
        viewController.selectedVideo = selectedViedo
        self.navigationController?.pushViewController(viewController, animated: true)
    }
  
    
    func showVideo(){
        print("showvideo")
        let ref = Database.database().reference()
        ref.child("youtube").observe(.value) { (snapshot) in
            self.videos.removeAll() //배열을 안지워 주면 계속 중복해서 쌓이게 된다.
            for child in snapshot.children{
                
                let video = Video() //데이터를 담을 클래스
                let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                
               
                if let id = childValue["id"], let title = childValue["title"],let des = childValue["des"]{
                    video.videoId = id as? String
                    video.videoTitle = title as? String
                    video.videoDescription = des as? String
                    self.videos.append(video)
                }
            }
            self.tableView.reloadData()
        }
        ref.removeAllObservers()
    }

    
}
