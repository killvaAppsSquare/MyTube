//
//  VideoModel.swift
//  Youtube
//
//  Created by Macbook Pro on 8/2/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class VideoModel {
    
    private var _title :String?
    private var _viewNum : NSNumber?
    private var _thumpnailImageName : String?
    var channel : Channel?
    
    var title : String  {
        guard  let x = _title else { return "" }
        return x
    }
    
    var viewsNum : NSNumber  {
        guard  let x = _viewNum else { return 0 }
        return x
    }
    
    var thumbnailImageName : String  {
        guard  let x = _thumpnailImageName else { return "" }
        return x
    }
    
    init(_ json : JSON) {
        
        _title = json["title"].stringValue
        _viewNum = json["number_of_views"].numberValue
        _thumpnailImageName = json["thumbnail_image_name"].stringValue
    }
}

class Channel {
    
    private var _name :String?
     private var _profileImageName : String?
    
    var name : String  {
        guard  let x = _name else { return "" }
        return x
    }
 
    var profileImageName : String  {
        guard  let x = _profileImageName else { return "" }
        return x
    }
    
    init(_ json : JSON) {
        
        _name = json["name"].stringValue
         _profileImageName = json["profile_image_name"].stringValue
    }
}
