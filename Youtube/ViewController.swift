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
    let blackView = UIView()

    var videosData : [VideoModel] {
        guard let x = _videosData else { return [] }
        return x
    }
    private var _videosData : [VideoModel]?
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
        
        let serachBarBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "search_icon").withRenderingMode(.alwaysOriginal), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(handleSearch))
              let moreBarBtn = UIBarButtonItem(image: #imageLiteral(resourceName: "nav_more_icon").withRenderingMode(.alwaysOriginal), landscapeImagePhone: nil, style: .plain, target: self, action: #selector(handleMore))

        navigationItem.rightBarButtonItems = [moreBarBtn,serachBarBtn]
        
        let data = VideoModelData()
        data.getVideoData { (data) in
            
             DispatchQueue.main.async {
                self._videosData = data
                self.collectionView?.reloadData()
             }
        }
    }
    func handleSearch(){
        
    }
    func handleMore(){
        if let windows = UIApplication.shared.keyWindow{
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handelDismiss)))
            blackView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
           windows.addSubview(blackView)
            blackView.frame = windows.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, animations: { 
                
                self.blackView.alpha = 1
            })
            
        }
        
    }
    
    func handelDismiss() {
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.blackView.alpha = 0
        }){(true) in
           self.blackView.removeFromSuperview()

        }
    }
    func setupNavBar() {
        navigationController?.navigationBar.isTranslucent = false
        let titleLbl = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width - 32, height: 20))
        titleLbl.text = "Home" ; titleLbl.textColor = .white
        navigationItem.titleView = titleLbl
        titleLbl.font = UIFont.systemFont(ofSize: 20)
        
    }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videosData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath) as! MainCell
        cell.videoData = videosData[indexPath.row]
         return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = ( view.frame.size.width - 32 ) * 9/16
        return CGSize(width: view.frame.size.width, height: height + 82)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    

}

class MainCell : UICollectionViewCell {

    var titleLabelHeightConstraint: NSLayoutConstraint?

    var videoData : VideoModel? {
        didSet {
            guard let data = videoData , let channel = data.channel  else { return }
            
            self.videoTitle.text = data.title
            self.thumpnailImage.loadImageUsingUrlString(data.thumbnailImageName)
            self.profileImageView.loadImageUsingUrlString(channel.profileImageName)
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            
            let subtitleText = "\(data.channel?.name ?? "" ) • \(numberFormatter.string(from: data.viewsNum)!) • 2 years ago "
            
            self.subTitleTextView.text = subtitleText
            
//            if let title = videoData?.title{
//                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
//                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
//                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
//                
//                if estimatedRect.size.height > 20 {
//                    titleLabelHeightConstraint?.constant = 44
//                } else {
//                    titleLabelHeightConstraint?.constant = 20
//                }
//            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    let thumpnailImage : CustomImageView = {
       let imageView = CustomImageView()
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
    
    let profileImageView : CustomImageView = {
        let imageV = CustomImageView()
        imageV.image = UIImage(named: "taylor_swift_profile")
        imageV.layer.cornerRadius =  22
        imageV.layer.masksToBounds = true
        return imageV
    }()
    
    let videoTitle: UILabel = {
       let labelView = UILabel()
        labelView.text = "Taylor * Love Story"
        labelView.numberOfLines = 2
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

         addConstraintsWithFormat("V:|-16-[v0]-[v1(44)]-38-[v2(1)]|", views: thumpnailImage,profileImageView,seprator)
        
        addConstraintsWithFormat("H:|-20-[v0]-20-|", views: seprator)
        
        addConstraintsWithFormat("H:|-20-[v0(44)]", views: profileImageView)
        
        
        addConstraints([NSLayoutConstraint(item: videoTitle, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8)])
        
        addConstraints([NSLayoutConstraint(item: videoTitle, attribute: .top, relatedBy: .equal, toItem: thumpnailImage, attribute: .bottom, multiplier: 1, constant: 8)])
        
        addConstraints([NSLayoutConstraint(item: videoTitle, attribute: .right, relatedBy: .equal, toItem: thumpnailImage, attribute: .right, multiplier: 1, constant: 0)])
        
//        titleLabelHeightConstraint =  NSLayoutConstraint(item: videoTitle, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44)
//        addConstraint(titleLabelHeightConstraint!)
        
        // subTitleTextView
        addConstraints([NSLayoutConstraint(item: subTitleTextView, attribute: .left, relatedBy: .equal, toItem: profileImageView, attribute: .right, multiplier: 1, constant: 8)])
        
        addConstraints([NSLayoutConstraint(item: subTitleTextView, attribute: .top, relatedBy: .equal, toItem: videoTitle, attribute: .bottom, multiplier: 1, constant: 4)])
        
        addConstraints([NSLayoutConstraint(item: subTitleTextView, attribute: .right, relatedBy: .equal, toItem: thumpnailImage, attribute: .right, multiplier: 1, constant: 0)])
        
        addConstraints([NSLayoutConstraint(item: subTitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)])
        
        addConstraint(NSLayoutConstraint(item: subTitleTextView, attribute: .bottom, relatedBy: .lessThanOrEqual, toItem: seprator, attribute: .top, multiplier: 1, constant: 8))

    }
    
    
 
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }

}
