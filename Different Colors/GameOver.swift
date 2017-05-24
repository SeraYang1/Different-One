//
//  GameOver.swift
//  Different Colors
//
//  Created by Sera Yang on 5/23/17.
//  Copyright © 2017 com.DifferentColors. All rights reserved.
//

import Foundation
import UIKit

class GameOver: UIViewController {
    //variables
    @IBOutlet weak var score: UILabel!
    var points = ""

    @IBAction func restartbutton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Survival") as! Survival
        self.present(newViewController, animated: true, completion: nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sets game over score
        score.text = points
        //Game Over setup
//        gameOverSmallScreen.layer.cornerRadius = 10
//        gameOverBlueBorder.layer.cornerRadius = 10
//        restartButton.layer.cornerRadius = 10
//        homeButton.layer.cornerRadius = 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
