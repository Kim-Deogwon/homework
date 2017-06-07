//
//  ListDataManager.swift
//  AppStoreHelper
//
//  Created by dwkim on 2017. 6. 5..
//  Copyright © 2017년 dwkim. All rights reserved.
//

import Foundation

class ListDataManager
{
    // MARK: - Property
    
    // MARK: - Life cycle
    
    // MARK: - Data management
    
    func fetchAppList(genre:genreType, completeHandler:@escaping ((_ AppList: [AppDefaultInfo]?)->()))
    {
        if let genreID = genre.id {
            
            let jsonDataUrl = "https://itunes.apple.com/kr/rss/topfreeapplications/limit=50/genre=\(genreID)/json"
            
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
                        completeHandler(self.parsingData(json!))
                    })
                    
                    
                })
                
                task.resume()
                
            }
            
            getDataFromUrl(jsonDataUrl)
            
        }
        
    }
    
    func parsingData(_ data:String) -> [AppDefaultInfo]?{
        
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
        
        guard let feed = root["feed"] as? Dictionary<String,AnyObject> else {
            return nil
        }
        
        guard let list = feed["entry"] as? Array<AnyObject> else {
            return nil
        }
        
        var appList = [AppDefaultInfo]()
        for i in 0 ..< list.count {
            
            let appDefaultInfo = AppDefaultInfo()
            guard let item = list[i] as? Dictionary<String,AnyObject> else {
                continue
            }
            
            //appid
            guard let idInfo = item["id"] as? Dictionary<String,AnyObject>else {
                continue
            }
            
            guard let idAttribute = idInfo["attributes"] as? Dictionary<String,AnyObject>else {
                continue
            }
            
            guard let appId = idAttribute["im:id"] as? String else {
                continue
            }
            
            //title
            guard let nameInfo = item["im:name"] as? Dictionary<String,AnyObject>else {
                continue
            }
            
            guard let name = nameInfo["label"] as? String else {
                continue
            }
            
            //imageurl
            guard let imageInfoList = item["im:image"] as? Array<AnyObject> else {
                continue
            }
            
            guard let imageInfo = imageInfoList.last as? Dictionary<String,AnyObject> else {
                continue
            }
            
            guard let imageUrl = imageInfo["label"] as? String else {
                continue
            }
            
            appDefaultInfo.id = appId
            appDefaultInfo.imageUrl = imageUrl
            appDefaultInfo.name = name
            
            appList.append(appDefaultInfo)
            
            
        }
        
        return appList
        
    }
}
