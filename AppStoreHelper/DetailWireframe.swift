//
//  DetailWireframe.swift
//  AppStoreHelper
//
//  Created by dwkim on 2017. 6. 6..
//  Copyright © 2017년 dwkim. All rights reserved.
//

import Foundation
import UIKit

let DetailViewControllerIdentifier: String = "DetailViewController"

class DetailWireframe : DetailViewWireframeInterface
{
	// MARK: - Property

    //var detailPresenter: DetailPresenter? = nil

    // MARK: - Presentation

    static func presentInterface(appInfo:AppDefaultInfo?) -> UIViewController
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle:Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier:DetailViewControllerIdentifier) as! DetailViewController
        
    	/*
        let navigationViewController = self.navigationControllerFromStoryboard()
        if let viewController = navigationViewController.viewControllers.first as? DetailViewController
        */
        let detailPresenter = DetailPresenter()
        detailPresenter.detailView = viewController
        detailPresenter.detailInteractor = DetailInteractor()
        detailPresenter.detailViewRouter = DetailWireframe()
        detailPresenter.appInfo = appInfo
        viewController.detailPresenter = detailPresenter

        return viewController
    }
    
    // MARK: - Storyboard
    
    private func mainStoryboard() -> UIStoryboard
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle:Bundle.main)
        return storyboard
    }
    
    
    private func viewControllerFromStoryboard() -> DetailViewController
    {
        let storyboard = self.mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier:DetailViewControllerIdentifier) as! DetailViewController
        return viewController
    }
    
 
    /*
    private func navigationControllerFromStoryboard() -> UINavigationController
    {
    let storyboard = self.mainStoryboard()
    let navigationController = storyboard.instantiateViewControllerWithIdentifier(DetailViewControllerIdentifier) as! UINavigationController
    return navigationController
    }
    */
}
