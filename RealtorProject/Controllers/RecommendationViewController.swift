//
//  RecommendationViewController.swift
//  RealtorProject
//
//  Created by Oliver Allen-Cummings on 1/10/23.
//

import UIKit

class RecommendationViewController: UIViewController {

    let recommendationsView = RecommendationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recommendationsView.configure()
        self.view = recommendationsView
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Recommendation"
        // Do any additional setup after loading the view.
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
