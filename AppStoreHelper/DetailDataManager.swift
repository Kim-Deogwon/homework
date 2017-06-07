//
//  DetailDataManager.swift
//  AppStoreHelper
//
//  Created by dwkim on 2017. 6. 6..
//  Copyright © 2017년 dwkim. All rights reserved.
//

import Foundation

class DetailDataManager
{
    // MARK: - Property
    
    // MARK: - Life cycle

    // MARK: - Data management
    
    func fetchAppDetail(appInfo:AppDefaultInfo, completeHandler:@escaping ((_ AppDetail: AppDetailInfo?)->()))
    {
        if let appId = appInfo.id {
            
            let jsonDataUrl = "https://itunes.apple.com/lookup?id=\(appId)&country=kr"
            
            let getDataFromUrl = { (url:String) in
                
                let url:URL = URL(string: url)!
                let session = URLSession.shared
                
                let request = NSMutableURLRequest(url: url)
                request.httpMethod = "GET"
                request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
                
                let task = session.dataTask(with: request as URLRequest, completionHandler: {
                    (data, response, error) in
                    
                    guard let _:Data = data, let _:URLResponse = response, error == nil else {
                        print("error")
                        return
                    }
                    
                    let json = String(data: data!, encoding: String.Encoding.utf8)
                    
                    DispatchQueue.main.async(execute: { () -> Void in
                        completeHandler(self.parsingData(json!,appInfo: appInfo))
                    })
                    
                    
                })
                
                task.resume()
                
            }
            
            getDataFromUrl(jsonDataUrl)
            
        }
        
    }
    
    func parsingData(_ data:String, appInfo:AppDefaultInfo) -> AppDetailInfo?{
        
        var parseError: NSError?
        let jsonData:Data = data.data(using: String.Encoding.utf8)!
        let json: AnyObject?
        do {
            json = try JSONSerialization.jsonObject(with: jsonData, options: []) as AnyObject
        } catch let error as NSError {
            parseError = error
            json = nil
        }
        
        guard parseError == nil else {
            return nil
        }
        
        guard let root = json as? Dictionary<String,AnyObject> else {
            return nil
        }
        
        guard let results = root["results"] as? Array<AnyObject> else {
            return nil
        }
        
        guard let result = results[0] as? Dictionary<String,AnyObject> else {
            return nil
        }
        
        let appDetailInfo = AppDetailInfo()
        
        guard let artworkUrl100String = result["artworkUrl100"] as? String else {
            return nil
        }
        
        
        guard let screenShotURLs = result["screenshotUrls"] as? Array<String> else {
            return nil
        }
        
        guard let descript = result["description"] as? String else {
            return nil
        }
        
        
        guard let artistName = result["artistName"] as? String else {
            return nil
        }
        
        //averageUserRating
        //averageUserRatingForCurrentVersion
        
        //옵셔널 처리
        //if let userRating = result["averageUserRating"] as? NSNumber {
        //    dic["averageUserRating"] = userRating as AnyObject?
        //}
        
        
        //if let trackContentRating = result["trackContentRating"] as? String {
        //    dic["trackContentRating"] = trackContentRating as AnyObject?
        //}
        
        //if let userRatingCount = result["userRatingCountForCurrentVersion"] as? NSNumber {
        //    dic["userRatingCountForCurrentVersion"] = userRatingCount as AnyObject?
        //}
        
        appDetailInfo.id = appInfo.id
        appDetailInfo.name = appInfo.name
        appDetailInfo.artworkImageUrl = artworkUrl100String
        appDetailInfo.descript = descript
        appDetailInfo.artistName = artistName
        appDetailInfo.screenshotUrls = screenShotURLs
        
        return appDetailInfo
        
    }
}
