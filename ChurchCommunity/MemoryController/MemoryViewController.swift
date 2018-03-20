//
//  MemoryViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 20..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit

class MemoryViewController: UITableViewController {


    var videos:[Video] = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(MemoryCell.self, forCellReuseIdentifier: "reuseIdentifier")
        let model = VideoModel()
        self.videos = model.getVideo()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.98, green:0.72, blue:0.16, alpha:1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "추억방"
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
        return 160
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("추억방 셀 눌림")
        
        let selectedViedo = videos[indexPath.row]
       
        let viewController = VideoDetailViewController()
        viewController.selectedVideo = selectedViedo
        self.navigationController?.pushViewController(viewController, animated: true)
    }
  
}
