//
//  MenuBar.swift
//  Youtube
//
//  Created by Macbook Pro on 8/1/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit

class MenuBar: UIView , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    lazy var  collectionView : UICollectionView = {
       let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = UIColor.rgp(230,  32,  31)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    let imageList = [#imageLiteral(resourceName: "home"),#imageLiteral(resourceName: "trending"),#imageLiteral(resourceName: "subscriptions"),#imageLiteral(resourceName: "account")]
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.register(MenuCell.self , forCellWithReuseIdentifier: "Cell")
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MenuCell
        cell.imageView.image = imageList[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

class  MenuCell :BaseCell {
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        
        return iv
    }()
    override func setUpView() {
        super.setUpView()
        addSubview(imageView)
        addConstraintsWithFormat("H:[v0(32)]", views: imageView)
        addConstraintsWithFormat("V:[v0(32)]", views: imageView)
        
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
    
}
