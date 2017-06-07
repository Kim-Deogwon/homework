//
//  ListPresenter.swift
//  AppStoreHelper
//
//  Created by dwkim on 2017. 6. 5..
//  Copyright © 2017년 dwkim. All rights reserved.
//

import UIKit

class ListPresenter:ListViewPresenterInterface
{
	// MARK: - Property

    var listInteractor: ListViewInteractorInterface? = ListInteractor()
    var listViewRouter: ListViewWireframeInterface? = ListWireframe()
    var genre: genreType?
    weak var listView: ListViewInterface?
    var appList: [AppDefaultInfo]?

    // MARK: - List module interface
    
    // MARK: - List interactor output interface

    // MARK: - Converting entities
    func viewDidLoad()
    {
        self.updateViewTitle()
        listInteractor?.listViewPresenter = self
        listInteractor?.fetch(to: genre)
    }
    
    func didSelect(_ app: AppDefaultInfo?) {
        guard let app = app,
            let listView = self.listView else {
                return
        }
        
        listViewRouter?.presentAppDetailView(from: listView, app)
    }
    
    func didReceive(_ appList:[AppDefaultInfo]?) {
        if let appList = appList {
            for (index, app) in appList.enumerated()
            {
                app.rank = index + 1
            }
        }
        self.appList = appList
        listView?.show(from: appList)
    }
    
    private func updateViewTitle()
    {
        if let viewController = listView as? UIViewController {
            viewController.title = genre?.name
        }
    }
}
