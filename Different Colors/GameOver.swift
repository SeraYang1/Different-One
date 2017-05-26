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
    @IBOutlet weak var homeImage: UIButton!
    @IBOutlet weak var restartImage: UIButton!
    @IBOutlet weak var score: UILabel!
    var points = ""
    var survivalOrTimed = false

    @IBAction func restartbutton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        
        let survival = storyBoard.instantiateViewController(withIdentifier: "Survival") as! Survival
        
        let timed = storyBoard.instantiateViewController(withIdentifier: "Timed") as! Timed
        
        if (survivalOrTimed == false){
            self.present(timed, animated: true, completion:nil)
        }else{
            self.present(survival, animated: true, completion: nil)
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Sets game over score
        score.text = points
        homeImage.layer.cornerRadius = 10
        restartImage.layer.cornerRadius = 10
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
