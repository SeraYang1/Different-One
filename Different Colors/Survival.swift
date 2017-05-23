//
//  File.swift
//  GradeCalculator
//
//  Created by Sera Yang on 1/10/17.
//  Copyright © 2017 Jiayue Li. All rights reserved.
//

import UIKit

class Survival: UIViewController {
    
    
    @IBOutlet weak var blackLineBot: UIImageView!
    @IBOutlet weak var blackLineTop: UIImageView!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var Score: UILabel!
    var timer = Timer()
    var timeDecrement = 0
    var yHigh = 0
    var yLow = 0
    var yDiff = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        yHigh = Int(blackLineTop.frame.origin.y)
        yLow = Int(blackLineBot.frame.origin.y)
        yDiff = yLow - yHigh - 2
        
        //Starts timer
        Time.text = "10"
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(Survival.update), userInfo: nil, repeats: true)
        
        //Sets up squares
        generateSquares(numSquares: 5, range: 0.1)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //gets where the user pressed
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            let xPos = location.x
            let yPos = location.y
            Score.text = String(describing: xPos)
        }
        super.touchesBegan(touches, with: event)
    }
    
    
    //calls drawRect multiple times to draw the squares
    func generateSquares(numSquares: Int, range: Double){
        //size of board minus border width
        let width = Double(self.view.bounds.width)-2.0*Double(numSquares)
        let size = width/Double(numSquares)
        let r = drand48()*Double(1-range)
        let b = drand48()*Double(1-range)
        let g = drand48()*Double(1-range)
        let color = UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0).cgColor
        
        //Draws all squares same color
        for x in 1...numSquares{
            for y in 1...numSquares{
                drawRect(x: -size+Double(numSquares)+Double(x)*size, y: -size+3.0+Double(numSquares)+Double(yHigh)+Double(y)*size, width: size-2, height: size-2, color: color)
            }
        }
        
        //finds color of incorrect tile
        let wrongColor = UIColor(red: CGFloat(r-range), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0).cgColor
        let ranNum =Int(arc4random_uniform(UInt32(3)))
        
        
        
        
        //draws incorrect tile
        let x = Int(arc4random_uniform(UInt32(numSquares)))
        let y = Int(arc4random_uniform(UInt32(numSquares)))
        drawRect(x: -size+Double(numSquares)+Double(x)*size, y: -size+3.0+Double(numSquares)+Double(yHigh)+Double(y)*size, width: size-2, height: size-2, color: wrongColor)
        print("\(x)   \(y)")
        
    }
    
    
    //draws the rectangle given coordinates and size
    func drawRect(x: Double, y: Double, width: Double, height: Double, color: CGColor){
        let rect = CGRect(x: x, y:y, width: width, height:height )
        let square = UIBezierPath(roundedRect: rect, cornerRadius: 5)
        //draws the path
        let layer = CAShapeLayer()
        layer.path = square.cgPath
        layer.fillColor = color
        layer.strokeColor = color
        view.layer.addSublayer(layer)
    }
    
    
    //updates time
    func update() {
        timeDecrement+=1
        if timeDecrement == 3 {
            //show game over screen
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "GameOver") as! GameOver
            newViewController.points = Score.text!
            self.present(newViewController, animated: true, completion: nil)
        }
        Time.text = String(3-timeDecrement)
    }
    
    
    //send score to game over screen
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let viewController = segue.destination as! ViewController
//        viewController.receivedString = selectedValue
//    }
}
