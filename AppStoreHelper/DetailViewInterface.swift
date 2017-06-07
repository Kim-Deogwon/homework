//
//  DetailViewInterface.swift
//  AppStoreHelper
//
//  Created by dwkim on 2017. 6. 6..
//  Copyright © 2017년 dwkim. All rights reserved.
//
import UIKit

protocol DetailViewInterface: class {
    var detailPresenter: DetailViewPresenterInterface? {get set}
    func show(from appDetail:AppDetailInfo)

}

protocol DetailViewPresenterInterface: class
{
    var detailViewRouter: DetailViewWireframeInterface? {get}
    weak var detailView: DetailViewInterface? {get set}
    var appInfo: AppDefaultInfo? {get}
    var appDetailInfo: AppDetailInfo? {get}
    
    func viewDidLoad()
    func didReceive(_ appDetailInfo:AppDetailInfo?)
}

protocol DetailViewInteractorInterface: class
{
    weak var detailViewPresenter: DetailViewPresenterInterface? {get set}
    
    func fetch(to appInfo:AppDefaultInfo?)
}

protocol DetailViewWireframeInterface: class
{
    static func presentInterface(appInfo:AppDefaultInfo?) -> UIViewController
}
