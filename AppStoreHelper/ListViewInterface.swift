//
//  ListViewInterface.swift
//  AppStoreHelper
//
//  Created by dwkim on 2017. 6. 5..
//  Copyright © 2017년 dwkim. All rights reserved.
//

import UIKit

protocol ListViewInterface : class {
    var listPresenter: ListViewPresenterInterface? {get}
    func show(from appList:[AppDefaultInfo]?)

}

protocol ListViewPresenterInterface: class {
    var listViewRouter: ListViewWireframeInterface? {get}
    weak var listView: ListViewInterface? {get set}
    var genre: genreType? {get}
    var appList: [AppDefaultInfo]? {get set}
    
    func viewDidLoad()
    func didSelect(_ app: AppDefaultInfo?)
    func didReceive(_ appList:[AppDefaultInfo]?)
}

protocol ListViewInteractorInterface: class {
    weak var listViewPresenter: ListViewPresenterInterface? {get set}
    
    func fetch(to genre:genreType?)
}

protocol ListViewWireframeInterface: class {
    func presentInterface(fromWindow window: UIWindow)
    func presentAppDetailView(from view: ListViewInterface , _ app: AppDefaultInfo)
}
