//
//  MemoryViewController.swift
//  ChurchCommunity
//
//  Created by MacBookPro on 2018. 3. 12..
//  Copyright © 2018년 MacBookPro. All rights reserved.
//

import UIKit

private let reuseIdentifier = "myCell"

class MemoryViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.98, green:0.72, blue:0.16, alpha:1.0)
        self.navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "추억방"
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
       
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 2
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
     cell.backgroundColor = UIColor.lightGray
        return cell
    }

    //cell의 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height / 2)
    }
    
    //컬렉션 뷰의 셀 사이사이마다 간격설정 원래는 디폴드 값으로 10이 지정되어 있음
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
                return 10
            }
    

}
