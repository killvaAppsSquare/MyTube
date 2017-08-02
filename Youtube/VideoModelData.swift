//
//  VideoModelData.swift
//  Youtube
//
//  Created by Macbook Pro on 8/2/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class VideoModelData {
    
    
    func getVideoData(completed : @escaping ([VideoModel]?) ->()) {
        
        let url = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil ).responseJSON { (response:DataResponse<Any>) in
            
            
            switch response.result {
            case .success :
                
                guard response.result.value != nil else { print("response.result.error"); return }
                let  json = JSON(response.result.value!)
                
                var videoClass = [VideoModel]()
                for (_,jData) in json {
                    
                    let x =   VideoModel(jData)
                    x.channel = Channel(jData["channel"] )
                    videoClass.append(x)
                }
                completed(videoClass)
                
            case .failure :
                completed(nil)
                
            }
        }
        
    }
    
    
}
