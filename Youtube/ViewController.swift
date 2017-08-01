//
//  ViewController.swift
//  Youtube
//
//  Created by Macbook Pro on 7/30/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout{

    
    let menuView : UIView = {
       let view = MenuBar()
        view.backgroundColor = .blue
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView?.backgroundColor = .white
        collectionView?.register(MainCell.self , forCellWithReuseIdentifier: "CellId")
        
        setupNavBar()
        
        view.addSubview(menuView)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuView)
        view.addConstraintsWithFormat("V:|[v0(50)]", views: menuView)
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)

    }

    func setupNavBar() {
        navigationController?.navigationBar.isTranslucent = false
        let titleLbl = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width - 32, height: 20))
        titleLbl.text = "Home" ; titleLbl.textColor = .white
        navigationItem.titleView = titleLbl
        titleLbl.font = UIFont.systemFont(ofSize: 20)
        
    }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! MainCell
        
         return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = ( view.frame.size.width - 32 ) * 9/16
        return CGSize(width: view.frame.size.width, height: height + 69)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    

}

class MainCell : UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    let thumpnailImage : UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(named: "taylor_swift_blank_space")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let seprator : UIView = {
       let view = UIView()
        view.backgroundColor = UIColor(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        return view
    }()
    
    let profileImageView : UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named: "taylor_swift_profile")
        imageV.layer.cornerRadius =  22
        imageV.layer.masksToBounds = true
        return imageV
    }()
    
    let videoTitle: UILabel = {
       let labelView = UILabel()
        labelView.text = "Taylor * Love Story"
        labelView.translatesAutoresizingMaskIntoConstraints = false
        return labelView
    }()
    
    let subTitleTextView : UITextView = {
       let textV = UITextView()
        textV.text = "1,000,000,000 views * 2 years"
        textV.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0)
        textV.textColor = .lightGray
        textV.translatesAutoresizingMaskIntoConstraints = false
        return textV
    }()
    
    func setupView() {
    
        addSubview(thumpnailImage)
        addSubview(seprator)
        addSubview(profileImageView)
        addSubview(videoTitle)
        addSubview(subTitleTextView)

         addConstraintsWithFormat("H:|-20-[v0]-20-|", views: thumpnailImage)

         addConstraintsWithFormat("V:|-16-[v0]-[v1(44)]-16-[v2(1)]|", views: thumpnailImage,profileImageView,seprator)
        
        addConstraintsWithFormat("H:|-20-[v0]-20-|", views: seprator)
        
        addConstraintsWithFormat("H:|-20-[v0(44)]", views: profileImageView)
        
        
        addConstraints([NSLayoutConstraint(item: videoTitle, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8)])
        
        addConstraints([NSLayoutConstraint(item: videoTitle, attribute: .top, relatedBy: .equal, toItem: thumpnailImage, attribute: .bottom, multiplier: 1, constant: 8)])
        
        addConstraints([NSLayoutConstraint(item: videoTitle, attribute: .right, relatedBy: .equal, toItem: thumpnailImage, attribute: .right, multiplier: 1, constant: 0)])
        
        addConstraints([NSLayoutConstraint(item: videoTitle, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)])
        
        // subTitleTextView
        addConstraints([NSLayoutConstraint(item: subTitleTextView, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8)])
        
        addConstraints([NSLayoutConstraint(item: subTitleTextView, attribute: .top, relatedBy: .equal, toItem: videoTitle, attribute: .bottom, multiplier: 1, constant: 4)])
        
        addConstraints([NSLayoutConstraint(item: subTitleTextView, attribute: .right, relatedBy: .equal, toItem: thumpnailImage, attribute: .right, multiplier: 1, constant: 0)])
        
        addConstraints([NSLayoutConstraint(item: subTitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30)])

    }
    
    
 
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
