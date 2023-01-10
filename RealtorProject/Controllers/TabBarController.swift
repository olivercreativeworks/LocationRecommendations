//
//  TabBarController.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/9/23.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = self.getViewControllers()
        self.tabBar.backgroundColor = .white
        Task{
            print("Getting data")
            Webservice().getData()
            print("Done")
        }
        // Do any additional setup after loading the view.
    }
    
    private func getViewControllers() -> [UIViewController]{
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        let favoritesViewController = FavoritesViewController()
        favoritesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let viewControllers = [searchViewController, favoritesViewController ].map{UINavigationController(rootViewController: $0)}
        return viewControllers
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
