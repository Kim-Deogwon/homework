//
//  ListWireframe.swift
//  AppStoreHelper
//
//  Created by dwkim on 2017. 6. 5..
//  Copyright © 2017년 dwkim. All rights reserved.
//

import Foundation
import UIKit

let ListViewControllerIdentifier: String = "ListViewController"

class ListWireframe: ListViewWireframeInterface
{
	// MARK: - Property

    var listPresenter: ListPresenter? = nil
    var rootWireframe : RootWireframe?

    // MARK: - Presentation

    func presentInterface(fromWindow window: UIWindow)
    {
    	
        let viewController = self.viewControllerFromStoryboard()
        

        /*let navigationViewController = self.navigationControllerFromStoryboard()
        if let viewController = navigationViewController.viewControllers.first as? ListViewController*/
        
        viewController.listPresenter = self.listPresenter
        self.listPresenter?.listView = viewController
        rootWireframe?.showRootViewController(viewController, inWindow: window)
    }
    
    // MARK: - Storyboard
    
    private func mainStoryboard() -> UIStoryboard
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle:Bundle.main)
        return storyboard
    }
    
    
    private func viewControllerFromStoryboard() -> ListViewController
    {
    let storyboard = self.mainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier:ListViewControllerIdentifier) as! ListViewController
    
    return viewController
    }
    
    
    /*
    private func navigationControllerFromStoryboard() -> UINavigationController
    {
    let storyboard = self.mainStoryboard()
    let navigationController = storyboard.instantiateViewControllerWithIdentifier(ListViewControllerIdentifier) as! UINavigationController
    return navigationController
    }*/
    
    func presentAppDetailView(from view:ListViewInterface , _ app: AppDefaultInfo)
    {
        let viewController = DetailWireframe.presentInterface(appInfo: app)
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(viewController, animated: true)
       }
    }
    
}
