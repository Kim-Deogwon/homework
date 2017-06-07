//
//  ListInteractor.swift
//  AppStoreHelper
//
//  Created by dwkim on 2017. 6. 5..
//  Copyright © 2017년 dwkim. All rights reserved.
//

import Foundation

class ListInteractor:ListViewInteractorInterface
{
	// MARK: - Property
    
    weak var listViewPresenter: ListViewPresenterInterface?
    var genre: genreType?
    func fetch(to genre:genreType?) {
        if let genre = genre {
            self.genre = genre
        } else {
            let genre = genres()
            genre.name = "금융"
            genre.id = 6015
            self.genre = genre
        }
        
        ListDataManager().fetchAppList(genre: self.genre!) {[weak self] (appList: [AppDefaultInfo]?) in
            self?.listViewPresenter?.didReceive(appList)
        }
    }

    // MARK: - List interactor input interface

    // MARK: - Converting raw datas
}
