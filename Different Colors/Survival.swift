//
//  File.swift
//  GradeCalculator
//
//  Created by Sera Yang on 1/10/17.
//  Copyright © 2017 Jiayue Li. All rights reserved.
//

import UIKit

class Survival: UIViewController {
    
    
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var gameOverBlueBorder: UIView!
    @IBOutlet weak var gameOverSmallScreen: UIView!
    @IBOutlet weak var gameOverText: UILabel!
    @IBOutlet weak var gameOverScrene: UIView!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var Score: UILabel!
    var timer = Timer()
    var timeDecrement = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view, typically from a nib.
        Time.text = "10"
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(Survival.update), userInfo: nil, repeats: true)
        
        //Sets up squares
        generateSquares(numSquares: 5, range: 10)
        
        //Game Over setup
        gameOverSmallScreen.layer.cornerRadius = 10
        gameOverBlueBorder.layer.cornerRadius = 10
        restartButton.layer.cornerRadius = 10
        homeButton.layer.cornerRadius = 10
        
        //Game Over Screen
        gameOverText.text = ""
        gameOverScrene.isHidden = true
        gameOverBlueBorder.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            let xPos = location.x
            let yPos = location.y
        }
        super.touchesBegan(touches, with: event)
    }
    
    func update() {
        timeDecrement+=1
        if timeDecrement == 10 {
            gameOverText.text = "GAME OVER"
            gameOverScrene.isHidden = false
            Time.isHidden = true
            gameOverBlueBorder.isHidden = false
        }
        Time.text = String(10-timeDecrement)
    }

    func generateSquares(numSquares: Int, range: Int){
        let width = self.view.bounds.width
        let size = round(width/CGFloat(numSquares) - 2)
        let color = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0).cgColor
        
        
        var k = Draw(frame: CGRect(
            origin: CGPoint(x: 50, y: 50),
            size: CGSize(width: 100, height: 100)))
        
        // Add the view to the view hierarchy so that it shows up on screen
        self.view.addSubview(k)
        
    }
    
    
    }

class Draw: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
//        let h = rect.height
//        let w = rect.width
//        
//        var color:UIColor = UIColor.yellow
//        var drect = CGRect(x: 0,y: 0,width: w,height: h)
//        var bpath:UIBezierPath = UIBezierPath(rect: drect)
//        
//        color.set()
//        bpath.stroke()
}
}
