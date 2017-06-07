//
//  ListViewController.swift
//  AppStoreHelper
//
//  Created by dwkim on 2017. 6. 5..
//  Copyright © 2017년 dwkim. All rights reserved.
//

import Foundation
import UIKit

class ListViewController:UIViewController,ListViewInterface,UITableViewDelegate,UITableViewDataSource
{
	// MARK: - Property

    lazy var listPresenter: ListViewPresenterInterface? = ListPresenter()
    @IBOutlet fileprivate weak var tableView: UITableView!

	// MARK: - Life cycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //tableview setting
        tableView.register(UINib(nibName: "AppInfoCell", bundle: nil), forCellReuseIdentifier: "AppInfoCell")
        //tableView.register(AppInfoCell.self, forCellReuseIdentifier: "AppInfoCell")
       
        listPresenter?.listView = self
        listPresenter?.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func show(from appList:[AppDefaultInfo]?) {

            tableView?.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPresenter?.appList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "AppInfoCell", for: indexPath) as! AppInfoCell
        if let appData = listPresenter?.appList?[indexPath.row] {
            appData.rank = indexPath.row + 1
            cell.configure(with: appData)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        listPresenter?.didSelect(listPresenter?.appList?[indexPath.row])
    }
}
