//
//  TabBarController.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/9/23.
//

import UIKit

class TabBarController: UITabBarController, ProcessDataDelegate {
    func processData(_ data: Data?, _ response: URLResponse?, _ error: Error?) {
        guard let data = data, error == nil else{
            return
        }
        
        var result:Places?
        do{
            result = try JSONDecoder().decode(Places.self, from: data)
        }catch{
            print(error)
        }
        guard let json = result else {
            return
        }
        print(json.results?.count)
        print(json.results?[0].name)
        print(json.results?.map{$0.name})
        
        
        print(json.results?.map{$0.categories}
            .map{$0?[0].name}
        )
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = self.getViewControllers()
        self.tabBar.backgroundColor = .white
        Task{
            print("Getting data")
            await Webservice.getDataFromFourSquareAPI(
                options: FourSquareAPIUrlOptions(startLocation: StartLocation(coordinates: Coordinates(latitude: 41.8781, longitude: -87.6298)),
                                                 category: FourSquareCategoriesOption(categories: .diningAndDrinking)),
                delegate: self)
            // Do any additional setup after loading the view.
        }
    }
    
    private func getViewControllers() -> [UIViewController]{
        let searchViewController = HomeViewController()
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
