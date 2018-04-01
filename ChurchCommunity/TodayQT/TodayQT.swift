
import UIKit
import Firebase
class TodayQT: UITableViewController,UISearchBarDelegate {
    var activityIndicatorView: UIActivityIndicatorView!
    //테이블 뷰 셀에서 이름이 클릭되었을 때
    func userClickCell(uid: String) {
        let viewController = ShowPageViewController()
        viewController.userUid = uid
        //userProfile 화면을 rootView로 만들어 주기
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    var posts = [Post]()
    var searchPosts = [Post]()
    let cellId = "cellId"
    
    //    let searchController : UISearchController = {
    //        let uisearchController = UISearchController(searchResultsController: nil)
    //        uisearchController.searchBar.placeholder = "검색"
    //        uisearchController.searchBar.backgroundColor =  UIColor(red:0.13, green:0.30, blue:0.53, alpha:1.0)
    //
    //        return uisearchController
    //    }()
    
    //검색버튼 눌렀을 때
    
    //    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    //        searchPosts.removeAll()
    //        //print("서치바 \(String(describing: searchController.searchBar.text!))")
    //        searchPosts = posts.filter({ (post) -> Bool in
    //            guard let text = searchController.searchBar.text else{return false}
    //            return post.text.contains(text)
    //        })
    //        self.tableView.reloadData()
    //    }
    
    var todayPostsCountLable: UILabel = {
        let label = UILabel()
        label.text = "오늘의 묵상글"
        label.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 21.5)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //소개
    lazy var introLable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.sizeToFit()
        label.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 15.5)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        //라벨 줄 간격
        let attributedString = NSMutableAttributedString(string: "삼가 말씀에 주의하는 자는 좋은 것을 얻나니\n여호와를 의지하는 자가 복이 있느니라.")
        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()
        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 2.5 // Whatever line spacing you want in points
        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        // *** Set Attributed String to your label ***
        label.attributedText = attributedString;
        
        return label
    }()
    
    
    //글 개수 / 공개개수
    var countLable: UILabel = {
        let label = UILabel()
        label.text = "오늘 작성된 묵상/   편"
        label.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 11.5)
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let headerView : UIView = {
        let header = UIView()
        header.backgroundColor = UIColor.white
        return header
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //오늘 날짜 체크
        getSingle()
        
        //테이블 뷰 헤더 지정
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height:220)
        tableView.tableHeaderView = headerView
        setHeaderViewLayout()
        
        //인디케이터 작동
        activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -60).isActive = true
        activityIndicatorView.bringSubview(toFront: self.view)
        activityIndicatorView.startAnimating()
        tableView.separatorStyle = .none
        DispatchQueue.main.async {
            OperationQueue.main.addOperation() {
                self.tableView.separatorStyle = .none
                Thread.sleep(forTimeInterval: 1.9)
                self.activityIndicatorView.stopAnimating()
                self.tableView.reloadData()
            }
        }
        
        showPost()
        
        searchPosts.removeAll()
        //searchController.searchBar.delegate = self
        
        //네비게이션 바 색깔 변경
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        
        
        //네비게이션 바 색깔 변경
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.lightGray
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        
        //테이블 배경 및 뒷배경 흰색 지정
        tableView.backgroundColor = .white
        tableView.backgroundView?.backgroundColor = .white
        
        //테이블 셀 등록 및 표시줄 제거
        tableView.register(TalkCell.self, forCellReuseIdentifier: cellId)
        tableView.showsHorizontalScrollIndicator = false
        tableView.showsVerticalScrollIndicator = false
        
        //동적 테이블 셀 높이
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
        
        
        
    }
    
    //동적 테이블 함수
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    //동적 테이블 함수
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    //행 개수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if(searchController.isActive && searchController.searchBar.text != ""){
        //            return searchPosts.count
        //        }
        return posts.count
    }
    
    //테이블 뷰 셀의 구성 및 데이터 할당 부분
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TalkCell
        //cell?.delegate = self
        //let screenSize = UIScreen.main.bounds
        //let separatorHeight = CGFloat(6.0)
        //let additionalSeparator = UIView.init(frame: CGRect(x: 0, y: (cell?.frame.size.height)!-separatorHeight, width: screenSize.width, height: separatorHeight))
        // additionalSeparator.backgroundColor = UIColor(red:0.37, green:0.51, blue:0.71, alpha:1.0)
        
        //cell?.addSubview(additionalSeparator)
        
        cell?.txtLabel.text = posts[indexPath.row].text
        cell?.txtLabel.setLineSpacing(lineSpacing: 7)
        cell?.txtLabel.textAlignment = .center
        cell?.hitLabel.text = "\(posts[indexPath.row].hit!)"
        cell?.dateLabel.text = "\(posts[indexPath.row].date!)"
        cell?.nameLabel.text = posts[indexPath.row].name
        cell?.pidLabel.text = posts[indexPath.row].pid
        cell?.replyHitLabel.text = "\(posts[indexPath.row].reply!) 개 댓글"
        cell?.uidLabel.text = posts[indexPath.row].uid
        cell?.showOrNotButton.setTitle(posts[indexPath.row].show, for: UIControlState())
        if(posts[indexPath.row].blessCount == nil){
            cell?.likesLabel.text = "0"
        }else{
            cell?.likesLabel.text = posts[indexPath.row].blessCount!
        }
        
        return cell!
    }
    
    
    //셀을 클릭했을 때
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("셀 클릭")
        
        //선택한 셀 정보 가져오기
        let cell = tableView.cellForRow(at: indexPath) as? TalkCell
        
        //값 할당
        let name = cell?.nameLabel.text
        let text = cell?.txtLabel.text
        let hit = cell?.hitLabel.text
        let blssCount = cell?.likesLabel.text
        let date = cell?.dateLabel.text
        let pid = cell?.pidLabel.text
        let replyHitLabel = cell?.replyHitLabel.text
        let uid = cell?.uidLabel.text
        let show = cell?.showOrNotButton.titleLabel?.text
        //조회수 문자를 배열로 변경
        let xs = hit!.characters.split(separator:" ").map{ String($0) }
        let hitNum = Int(xs[0])! + 1
        
        //fb db 연결 후 posts 테이블에 key가 pid인 데이터의 hit 개수 변경해주기
        let hiting = ["hit" : hitNum]
        //여기가 문제
        let ref = Database.database().reference()
        ref.child("posts").child(pid!).updateChildValues(hiting)
        
        let xss = replyHitLabel!.characters.split(separator:" ").map{ String($0) }
        let replyNum = Int(xss[0])!
        
        let onePost = Post()
        onePost.name = name
        onePost.text = text
        onePost.hit = String(hitNum)
        onePost.date = date
        onePost.pid = pid
        onePost.reply = String(replyNum)
        onePost.uid = uid
        onePost.show = show
        onePost.blessCount = blssCount
        //디테일 페이지로 이동
        let detailTalkViewController = DetailTalkViewController()
        detailTalkViewController.onePost = onePost
        //글쓰기 화면을 rootView로 만들어 주기
        navigationController?.pushViewController(detailTalkViewController, animated: true)
    }
    
    var today = ""
    //현재 날짜 한글
    func getSingle(){
        let date = Date()
        let calendar = Calendar.current //켈린더 객체 생성
        let month = calendar.component(.month, from: date)  //월
        let day = calendar.component(.day, from: date)      //일
        today = "\(month)\(day)"
        print("\(month)\(day)")
        
    }
    
    //포스트 조회 함수
    func showPost(){
        var todayPost = 0
        let ref = Database.database().reference()
        //T9Hfsjqphlhj2P9Fwp5T2xpLK9A3
        ref.child("posts").queryOrdered(byChild: "date").observe(.value) { (snapshot) in
            self.posts.removeAll() //배열을 안지워 주면 계속 중복해서 쌓이게 된다.
            for child in snapshot.children{
                
                let postToShow = Post() //데이터를 담을 클래스
                let childSnapshot = child as! DataSnapshot //자식 DataSnapshot 가져오기
                let childValue = childSnapshot.value as! [String:Any] //자식의 value 값 가져오기
                
                if let name = childValue["name"],  let date = childValue["date"], let hit = childValue["hit"], let pid = childValue["pid"], let uid = childValue["uid"], let text = childValue["text"], let reply = childValue["reply"],let show = childValue["show"] {
                    
                    //오늘 날짜에 작성된 글 개수 파악
                    if let t = date as? TimeInterval {
                        let date = NSDate(timeIntervalSince1970: t/1000)
                        let calendar = Calendar.current //켈린더 객체 생성
                        let month = calendar.component(.month, from: date as Date)  //월
                        let day = calendar.component(.day, from: date as Date)      //일
                        
                        if("\(month)\(day)" == self.today){
                            todayPost = todayPost + 1
                        }
                        self.countLable.text = "오늘 작성된 묵상/ \(todayPost)편"
                        print("오늘 작성된 시편의 개수는?  \(todayPost) ")
                    }
                    //공개를 허용한 글만 담벼락에 보이기
                    if (uid as? String == "i1OyLDOK7zLC6mSt20qOz7vtTQv2"){
                        ref.child("bless").observe(.value, with: { (snapshot) in
                            for (childs ) in snapshot.children{
                                
                                let childSnapshot = childs as! DataSnapshot
                                let key = childSnapshot.key
                                let val = childSnapshot.value as! [String:Any]
                                if (key == pid as? String) {
                                    print("축복받은 개수 몇개?")
                                    print(pid,key,val.count)
                                    postToShow.blessCount = "\(val.count)"
                                }
                            }
                            self.tableView.reloadData()
                        })
                        
                        //firebase에서 가져온 날짜 데이터를 ios 맞게 변환
                        if let t = date as? TimeInterval {
                            let date = NSDate(timeIntervalSince1970: t/1000)
                            // print("---------------------\(NSDate(timeIntervalSince1970: t/1000))")
                            let dayTimePeriodFormatter = DateFormatter()
                            dayTimePeriodFormatter.dateFormat = "M월 d일 hh시"
                            let dateString = dayTimePeriodFormatter.string(from: date as Date)
                            postToShow.date = dateString
                        }
                        
                        postToShow.name = ""
                        //postToShow.name = name as! String
                        postToShow.hit = String(describing: hit)
                        postToShow.pid = pid as! String
                        postToShow.text = text as! String
                        postToShow.uid = uid as! String
                        postToShow.reply = String(describing: reply)
                        postToShow.show = "공개"
                        self.posts.insert(postToShow, at: 0)
                    }
                    
                }
            }
            todayPost = 0
            print("초기화 됐나요1? \(todayPost)")
        }
        //print("초기화 됐나요2? \(todayPost)")
        ref.removeAllObservers()
        //print("초기화 됐나요3? \(todayPost)")
    }
    
    //헤더뷰 레이아웃
    func setHeaderViewLayout(){
        headerView.addSubview(todayPostsCountLable)
        todayPostsCountLable.topAnchor.constraint(equalTo: headerView.topAnchor,constant:55).isActive = true
        todayPostsCountLable.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,constant:15).isActive = true
        todayPostsCountLable.widthAnchor.constraint(equalTo : headerView.widthAnchor).isActive = true
        todayPostsCountLable.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        headerView.addSubview(introLable)
        introLable.topAnchor.constraint(equalTo: todayPostsCountLable.bottomAnchor,constant:15).isActive = true
        introLable.leadingAnchor.constraint(equalTo: headerView.leadingAnchor,constant:15).isActive = true
        introLable.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant:-35).isActive = true
        introLable.bottomAnchor.constraint(equalTo: headerView.bottomAnchor,constant:-35).isActive = true
        
        headerView.addSubview(countLable)
        countLable.topAnchor.constraint(equalTo: introLable.bottomAnchor,constant:65).isActive = true
        countLable.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant:-15).isActive = true
        countLable.heightAnchor.constraint(equalToConstant: 15).isActive = true
        countLable.bottomAnchor.constraint(equalTo: headerView.bottomAnchor,constant:-10).isActive = true
        
    }
}