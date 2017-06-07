//
//  Models.swift
//  AppStoreHelper
//
//  Created by dwkim on 2017. 6. 5..
//  Copyright © 2017년 dwkim. All rights reserved.
//

import UIKit

class AppDefaultInfo: NSObject {
    
    var name: String?
    var id: String?
    var imageUrl: String?
    var rank: Int?

}

class AppDetailInfo: NSObject {
    
    var name: String?
    var id: String?
    var artworkImageUrl: String?
    var screenshotUrls: [String]?
    var descript: String?
    var artistName: String?
    
}

protocol genreType: class {
    var name: String? {get}
    var id: Int? {get}
}

class genres: genreType {
    var name: String?
    var id: Int?
}

////////////////////////
///   리스트뷰 셀관련    ///
///////////////////////
protocol ListCellViewType: class {
    var myRank: UILabel? {get}
    var myImageView: UIImageView? {get}
    var myLabel: UILabel? {get}
}


protocol ListCellViewTypeContainerType {
    var cellView: ListCellViewType?{get}
    func configure(with appDefaultInfo: AppDefaultInfo)
}

extension ListCellViewTypeContainerType {
    func configure(with appDefaultInfo: AppDefaultInfo) {
        if let cellView = self.cellView {
            if let rank = appDefaultInfo.rank {
                cellView.myRank?.text = "\(rank)"
            }
            cellView.myLabel?.text = appDefaultInfo.name
            downloadImage(appDefaultInfo.imageUrl!, cell: cellView as! AppInfoCell)

        }
    }
    
    func downloadImage(_ urlString:String, cell:AppInfoCell) {
        let url:URL = URL(string: urlString)!
        let session = URLSession.shared
        
        let task = session.downloadTask(with: url, completionHandler: {
            (location, response, error) in
            
            guard let _:URL = location, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            
            let imageData = try? Data(contentsOf: location!)
            
            DispatchQueue.main.async(execute: {
           
                cell.myImageView?.image = UIImage(data: imageData!)
                cell.myImageView?.clipsToBounds = true
                cell.myImageView!.layer.cornerRadius = 10
                cell.myImageView?.layer.borderWidth = 0.5
                cell.myImageView?.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).cgColor
                cell.myImageView?.contentMode = .scaleAspectFit
                
                
                
                return
            })
        })
        
        task.resume()
        
    }
}

////////////////////////
/// 디테일뷰 헤더셀 관련  ///
///////////////////////

protocol DetailHeaderCellViewType: class {

    var imageView: UIImageView {get}
    var nameLabel: UILabel {get}
}

protocol DetailHeaderCellViewContainerType {
    var headerCellView: DetailHeaderCellViewType?{get}
    func configure(with appDetailInfo: AppDetailInfo)
}

extension DetailHeaderCellViewContainerType {
    func configure(with appDetailInfo: AppDetailInfo) {
        if let cellView = self.headerCellView {
            if let name = appDetailInfo.name {
                cellView.nameLabel.text = "\(name)"
            }
            downloadImage(appDetailInfo.artworkImageUrl!, cell: cellView as! DetailHeaderCell)
            
        }
    }
    
    func downloadImage(_ urlString:String, cell:DetailHeaderCell) {
        let url:URL = URL(string: urlString)!
        let session = URLSession.shared
        
        let task = session.downloadTask(with: url, completionHandler: {
            (location, response, error) in
            
            guard let _:URL = location, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            
            let imageData = try? Data(contentsOf: location!)
            
            DispatchQueue.main.async(execute: {
                
                cell.imageView.image = UIImage(data: imageData!)
                cell.imageView.clipsToBounds = true
                cell.imageView.layer.cornerRadius = 10
                cell.imageView.layer.borderWidth = 0.5
                cell.imageView.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1.0).cgColor
                cell.imageView.contentMode = .scaleAspectFit
                
                
                
                return
            })
        })
        
        task.resume()
        
    }
}

////////////////////////
///디테일뷰 스크린샷셀 관련///
///////////////////////

protocol DetailScreenshotCellViewType: class {
    
    var screenshotDic: [Int:UIImage] {get set}
    var collectionView: UICollectionView {get}
}

protocol DetailScreenshotCellViewContainerType {
    var screenshotCellView: DetailScreenshotCellViewType?{get}
    func configure(with appDetailInfo: AppDetailInfo)
}

extension DetailScreenshotCellViewContainerType {
    func configure(with appDetailInfo: AppDetailInfo) {
        if let cellView = self.screenshotCellView {
            if let screenshotUrls = appDetailInfo.screenshotUrls {

                let downloadGroup = DispatchGroup()
                for i in 0 ..< screenshotUrls.count {
                    
                    let url = screenshotUrls[i]
                    downloadGroup.enter()
                    downloadImage(url) {(image: UIImage?) in
                        if let inputImage:UIImage = image {
                            cellView.screenshotDic.updateValue(inputImage, forKey: i)
                        }
                       
                        downloadGroup.leave()
                        
                    }
                }
                
                downloadGroup.wait()
                DispatchQueue.main.async {
                    cellView.collectionView.reloadData()
                }
               
            }
            
        }
        
    }
    
    func downloadImage(_ urlString:String, completeHandler:@escaping ((_ image: UIImage?)->())) {
        let url:URL = URL(string: urlString)!
        let session = URLSession.shared
    
        let task = session.downloadTask(with: url, completionHandler: {
            (location, response, error) in
            
            guard let _:URL = location, let _:URLResponse = response, error == nil else {
                print("error")
                return
            }
            
            let imageData = try? Data(contentsOf: location!)
            let image = UIImage(data: imageData!)
            
            completeHandler(image)
            
        })
        
        task.resume()
        
    }
}

