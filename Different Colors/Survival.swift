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
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var pauseScore: UILabel!
    @IBOutlet weak var pauseSmallScreen: UIView!
    @IBOutlet weak var pauseLabel: UILabel!
    @IBOutlet weak var pauseBlackBackground: UIView!
    @IBOutlet weak var blackLineBot: UIImageView!
    @IBOutlet weak var blackLineTop: UIImageView!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var Score: UILabel!
    
    let botLayer = CAShapeLayer()
    var timer = Timer()
    var timeDecrement = 0
    var yHigh = 0
    var yLow = 0
    var yDiff = 0
    
    //change every time
    var numSquares = 3
    var range = 0.2
    var width = 0.0
    var size = 0.0
    var wrongX = 0
    var wrongY = 0
    var wrongXPos = 0
    var wrongYPos = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        yHigh = Int(blackLineTop.frame.origin.y)
        yLow = Int(blackLineBot.frame.origin.y)
        yDiff = yLow - yHigh - 2
        
        //hide pause screen
        pauseSmallScreen.isHidden = true
        pauseLabel.isHidden = true
        pauseBlackBackground.isHidden = true
        playButton.layer.cornerRadius = 10
        homeButton.layer.cornerRadius = 5
        restartButton.layer.cornerRadius = 5
        
        //edit every time
        width = Double(self.view.bounds.width)-2.0*Double(numSquares)
        size = width/Double(numSquares)
        wrongX = Int(arc4random_uniform(UInt32(numSquares-1)))+1
        wrongY = Int(arc4random_uniform(UInt32(numSquares-1)))+1
        wrongXPos = Int(Double(numSquares)+Double(wrongX)*size)
        wrongYPos = Int(3.0+Double(numSquares)+Double(yHigh)+Double(wrongY)*size)

        
        //Starts timer
        Time.text = "5"
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(Survival.update), userInfo: nil, repeats: true)
        
        //Sets up squares
        generateSquares(numSquares: numSquares, range: range)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //gets where the user pressed
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self.view)
            let xPos = Int(location.x)
            let yPos = Int(location.y)
            if(yPos>yHigh && yPos<yLow){
                print("\(wrongYPos)  \(wrongYPos+Int(size)-2)   \(wrongXPos)  \(wrongXPos+Int(size)-2)")
                print("\(yPos)")
                if(yPos > wrongYPos && yPos < (wrongYPos+Int(size)-2) && xPos > wrongXPos && xPos < (wrongXPos+Int(size)-2)){
                    Score.text = String(describing: Int(Score.text!)!+1)
                    timeDecrement = 0
                    if(numSquares == 5){
                        numSquares = 3
                        range = range * 0.75
                        generateSquares(numSquares: numSquares, range: range)
                    }else{
                        numSquares += 1
                        generateSquares(numSquares: numSquares, range: range)
                    }
                    Time.text = "5"
                }
                else{
                    gameOverLoad()
                }
            }
        }
        super.touchesBegan(touches, with: event)
    }
    
    
    //calls drawRect multiple times to draw the squares
    func generateSquares(numSquares: Int, range: Double){
        //clears background 
        drawRect(x: 0.0, y: 3.0+Double(yHigh), width: width+Double(numSquares)*2.0, height: Double(yDiff)-3.0, color: UIColor.white.cgColor)
        
        //size of board minus border width
        let r = drand48()*Double(1-range)
        let b = drand48()*Double(1-range)
        let g = drand48()*Double(1-range)
        let color = UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0).cgColor
        
        
        //edit every time
        width = Double(self.view.bounds.width)-2.0*Double(numSquares)
        size = width/Double(numSquares)
        wrongX = Int(arc4random_uniform(UInt32(numSquares-1)))+1
        wrongY = Int(arc4random_uniform(UInt32(numSquares-1)))+1
        wrongXPos = Int(Double(numSquares)+Double(wrongX)*size)
        wrongYPos = Int(3.0+Double(numSquares)+Double(yHigh)+Double(wrongY)*size)
        

        
        //Draws all squares same color
        for x in 0...(numSquares-1){
            for y in 0...(numSquares-1){
                drawRect(x: Double(numSquares)+Double(x)*size, y: 3.0+Double(numSquares)+Double(yHigh)+Double(y)*size, width: size-2, height: size-2, color: color)
            }
        }
        
        //finds color of incorrect tile
        var wrongColor = UIColor(red: CGFloat(r+range), green: CGFloat(g), blue: CGFloat(b), alpha: 1.0).cgColor
        let ranNum = Int(arc4random_uniform(UInt32(3)))
        if(ranNum == 0){
            wrongColor = UIColor(red: CGFloat(r), green: CGFloat(g+range), blue: CGFloat(b), alpha: 1.0).cgColor
        }else if(ranNum==1){
            wrongColor = UIColor(red: CGFloat(r), green: CGFloat(g), blue: CGFloat(b+range), alpha: 1.0).cgColor
        }
        
        //draws incorrect tile
        drawRect(x: Double(numSquares)+Double(wrongX)*size, y: 3.0+Double(numSquares)+Double(yHigh)+Double(wrongY)*size, width: size-2, height: size-2, color: wrongColor)
        view.layer.addSublayer(botLayer)
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
        botLayer.addSublayer(layer)
    }
    
    
    //press pause
    @IBAction func pauseButtonLoadScreen(_ sender: Any) {
        pauseBlackBackground.isHidden = false
        pauseLabel.isHidden = false
        pauseSmallScreen.isHidden = false
        pauseScore.text = Score.text!
        botLayer.removeFromSuperlayer()
        timer.invalidate()
    }
    
    //restarts game
    @IBAction func pauseRestart(_ sender: Any) {
        viewDidLoad()
    }
    
    //continues playing game
    @IBAction func pausePlay(_ sender: Any) {
        pauseBlackBackground.isHidden = true
        pauseLabel.isHidden = true
        pauseSmallScreen.isHidden = true
        view.layer.addSublayer(botLayer)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Survival.update), userInfo: nil, repeats: true)
    }
    
    
    
    
    //updates time
    func update() {
        timeDecrement+=1
        if timeDecrement == 5 {
            //show game over screen
            gameOverLoad()
        }
        Time.text = String(5-timeDecrement)
    }
    
    func gameOverLoad(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "GameOver") as! GameOver
        newViewController.points = Score.text!
        newViewController.survivalOrTimed = true
        self.present(newViewController, animated: true, completion: nil)
    }
}
