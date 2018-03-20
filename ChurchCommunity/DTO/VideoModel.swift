//
//  VideoModel.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 20..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit

class VideoModel: NSObject {

    func getVideo() -> [Video]{
        var videos = [Video]()
        
        let video1 = Video()
        
        video1.videoId = "hTWGiPU-SoU"
        video1.videoTitle = "title"
        video1.videoDescription = "재미있는 비디오 입니다."
        
        videos.append(video1)
        
        let video2 = Video()
        
        video2.videoId = "zmpW1Ot8Bgs"
        video2.videoTitle = "신기한 비디오"
        video2.videoDescription = "신기한 비디오 입니다."
        
        videos.append(video2)
        
        let video3 = Video()
        
        video3.videoId = "4pL0MTmUWpg"
        video3.videoTitle = "멋진 비디오"
        video3.videoDescription = "멋진 비디오 입니다."
        
        videos.append(video3)
        
        return videos
    }
  
}
