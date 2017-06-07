//
//  DetailInteractor.swift
//  AppStoreHelper
//
//  Created by dwkim on 2017. 6. 6..
//  Copyright © 2017년 dwkim. All rights reserved.
//

import Foundation

class DetailInteractor: DetailViewInteractorInterface
{

	// MARK: - Property
    weak var detailViewPresenter: DetailViewPresenterInterface?
    //var genre: genreType?
    func fetch(to appInfo:AppDefaultInfo?) {
        if let appInfo = appInfo {

            DetailDataManager().fetchAppDetail(appInfo:appInfo) {[weak self] (appDetailInfo: AppDetailInfo?) in
                self?.detailViewPresenter?.didReceive(appDetailInfo)
            }
            
        }
   

    }
    
   // var output: DetailInteractorOutput? = nil
    //lazy private var dataManager: DetailDataManager = DetailDataManager()

    // MARK: - Detail interactor input interface

    // MARK: - Converting raw datas
}
