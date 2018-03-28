import UIKit
import Firebase

protocol CollectionViewCellDelegate: class {
    func writeAction()
    
    func showAllPosts()
}

class PageCell: UICollectionViewCell {
    //컨트롤에서 넘겨줄 모델 데이터 받을 변수
    var delegate: CollectionViewCellDelegate?
    
    var itemCheck:Int?
    var page: Page? {
        didSet {
            
            if(itemCheck == 0){
                writeButton.isHidden = true
                writeButton.isEnabled = false
                lookButton.isHidden = true
                lookButton.isEnabled = false
                
            }else if(itemCheck == 1){
                lookButton.isHidden = true
                lookButton.isEnabled = false
            }else if(itemCheck == 2){
                writeButton.isHidden = true
                writeButton.isEnabled = false
            }
            
            //언래핑:널값을 안전하게 처리하기 위해서 언래핑 해준다.
            guard let unwrappedPage = page else { return }
            //위에서 언래핑한 객체모델.변수 이름으로 데이터 view에 뿌려주기
            //myImageView.image = UIImage(named: unwrappedPage.imageName)
            let paragraphStyle = NSMutableParagraphStyle()
            //높이 설정
            paragraphStyle.lineSpacing = 11
            let attributedText = NSMutableAttributedString(string: unwrappedPage.headerText, attributes: [NSAttributedStringKey.font: UIFont(name: "NanumMyeongjo-YetHangul", size: 24.5)])
            attributedText.append(NSAttributedString(string: "\n\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedStringKey.font: UIFont(name: "NanumMyeongjo-YetHangul", size: 15.5), NSAttributedStringKey.foregroundColor:UIColor(red:0.17, green:0.17, blue:0.17, alpha:1.0)]))
            //줄간격설정
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range: NSMakeRange(0, attributedText.length))
            myTextView.attributedText = attributedText
            myTextView.textAlignment = .center
        
        }
        
    }
    
    //쓰기 버튼
    lazy var writeButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "pencil.png"), for: UIControlState())
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(writeAction), for: .touchUpInside)
        return btn
    }()
    //글쓰러가기 버튼
    @objc func writeAction(){
        print("글쓰러가기 버튼")
        delegate?.writeAction()
     

    }
    
    //글보기 버튼
    lazy var lookButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(#imageLiteral(resourceName: "see.png"), for: UIControlState())
        btn.backgroundColor = .clear
        btn.addTarget(self, action: #selector(showAction), for: .touchUpInside)
        return btn
    }()
    //글 보러가기 버튼
    @objc func showAction(){
          print("글보러가기 버튼")
         delegate?.showAllPosts()
    }
    

    let dateLable: UILabel = {
        let lable = UILabel()
        lable.translatesAutoresizingMaskIntoConstraints = false
       lable.font = UIFont(name: "NanumMyeongjo-YetHangul", size: 14.5)
        lable.textColor = UIColor.lightGray
        lable.adjustsFontSizeToFitWidth=true
        lable.minimumScaleFactor=0.5;
        return lable
    }()
    
    ////클로저 기능으로 textView객체 만들어주기(내부에서 속성정의)
    let myTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    //부모 인스턴스를 초기화 해줘야 커스터마이징 해줄 수 있다.
    override init(frame: CGRect) {
        super.init(frame: frame)
        getSingle()
        setupLayout()
    }
    //현재 날짜 한글
    func getSingle(){
        let date = Date()
        let calendar = Calendar.current //켈린더 객체 생성
        let year = calendar.component(.year, from: date)    //년
        let month = calendar.component(.month, from: date)  //월
        let day = calendar.component(.day, from: date)      //일
        dateLable.text = "\(year)년 \(month)월 \(day)일, 맑음"
       
    }
    private func setupLayout() {

        
        addSubview(lookButton)
        addSubview(writeButton)
        
        addSubview(dateLable)
        
        dateLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        dateLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        //현재 cell에 textview 추가
        addSubview(myTextView)
        myTextView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        myTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        myTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        myTextView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        
        writeButton.topAnchor.constraint(equalTo: myTextView.bottomAnchor, constant: 50).isActive = true
        writeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        writeButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        writeButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
         lookButton.topAnchor.constraint(equalTo: writeButton.bottomAnchor, constant: 10).isActive = true
       lookButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lookButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        lookButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

