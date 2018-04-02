//
//  VideoDetailViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 20..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit

class VideoDetailViewController: UIViewController {
    var activityIndicatorView: UIActivityIndicatorView!
    var videoId:String?
    var selectedVideo : Video? {
        didSet{
            titleLable.text = selectedVideo?.videoTitle
            describeLable.text = selectedVideo?.videoDescription
            videoId = selectedVideo?.videoId
        }
    }
    
    let myView : UIView = {
      let mywebView = UIView()
        mywebView.backgroundColor = .blue
        mywebView.translatesAutoresizingMaskIntoConstraints = false
        return mywebView
    }()
    
    let myWebView:UIWebView = {
        let webView = UIWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.backgroundColor = UIColor.yellow
        return webView
    }()
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.text = "동영상 제목 입니다.~~~~"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let describeLable: UILabel = {
        
        let label = UILabel()
         label.text = "동영상 설명입니다 입니다.~~~~동영상 설명입니다 입니다.~~~~동영상 설명입니다 입니다.~~~~동영상 설명입니다 입니다 동영상 설명입니다 입니다.~~~~동영상 설명입니다 입니다.~~~~동영상 설명입니다 입니다.~~~~동영상 설명입니다 입니다"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //화면이 나타날때 마다
    override func viewDidAppear(_ animated: Bool) {
        
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -60).isActive = true
        activityIndicatorView.bringSubview(toFront: self.view)
        activityIndicatorView.startAnimating()
        
        print("start 인디케이터")
        
        DispatchQueue.main.async {
            print("start DispatchQueue")
            OperationQueue.main.addOperation() {
                print("start OperationQueue")
                
                Thread.sleep(forTimeInterval: 2.3)
                print("start forTimeInterval")
                self.activityIndicatorView.stopAnimating()
                
            }
        }
        
        let myURL = "https://youtube.com/embed/"+videoId!
        self.myWebView.allowsInlineMediaPlayback = true
        let fbor = "0"
        let width = self.view.frame.size.width
        let height = width/320 * 180
        
        let code:NSString = "<html><iframe src=\(myURL) width=\(width) height=\(height) frameborder=\(fbor) allowfullscreen></iframe></html>" as NSString
        self.myWebView.loadHTMLString(code as String, baseURL: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)

        self.navigationController?.navigationBar.isTranslucent = false
        //navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "영상방"
        view.addSubview(myView)
        view.addSubview(titleLable)
        view.addSubview(describeLable)
        setLayout()
    }
    
    func setLayout(){
       
        myView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        myView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        myView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        myView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        myView.addSubview(myWebView)
        
        myWebView.leadingAnchor.constraint(equalTo: myView.leadingAnchor).isActive = true
        myWebView.trailingAnchor.constraint(equalTo: myView.trailingAnchor).isActive = true
        myWebView.topAnchor.constraint(equalTo: myView.topAnchor).isActive = true
        myWebView.heightAnchor.constraint(equalTo: myView.heightAnchor).isActive = true
        
        titleLable.topAnchor.constraint(equalTo: myView.bottomAnchor, constant: 30).isActive = true
        titleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        titleLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        titleLable.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        describeLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 15).isActive = true
        describeLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        describeLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        describeLable.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }


}
