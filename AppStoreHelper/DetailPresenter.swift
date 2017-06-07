//
//  DetailPresenter.swift
//  AppStoreHelper
//
//  Created by dwkim on 2017. 6. 6..
//  Copyright © 2017년 dwkim. All rights reserved.
//

import Foundation

class DetailPresenter: DetailViewPresenterInterface
    
{
  
	// MARK: - Property
    var detailInteractor: DetailViewInteractorInterface? = DetailInteractor()
    var detailViewRouter: DetailViewWireframeInterface? = DetailWireframe()
    weak var detailView: DetailViewInterface?
    var appInfo: AppDefaultInfo?
    var appDetailInfo: AppDetailInfo?
        
    func viewDidLoad() {
        detailInteractor?.detailViewPresenter = self
        detailInteractor?.fetch(to: self.appInfo)
    }
    
    func didReceive(_ appDetailInfo:AppDetailInfo?) {
        self.appDetailInfo = appDetailInfo
        detailView?.show(from: appDetailInfo!)
    }

    // MARK: - Detail module interface
    
    // MARK: - Detail interactor output interface

    // MARK: - Converting entities
}
