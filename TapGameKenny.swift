//
//  ViewController.swift
//  ExamplesBegin4(GameKenny)
//
//  Created by Buğra Tunçer on 5.05.2019.
//  Copyright © 2019 Buğra Tunçer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    var highScore=0
    var score=0
    var gameTime=30
    var number=0
    var imageKenny: [UIImageView] = []
    var timer=Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
         imageKenny.append(kenny1)
         imageKenny.append(kenny2)
         imageKenny.append(kenny3)
         imageKenny.append(kenny4)
        for i in 0...3
        {
            imageKenny[i].isUserInteractionEnabled=true
            imageKenny[i].isHidden=true
          
        }
        for i in 0...3
        {
            let gestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(ViewController.funcGesture))
            imageKenny[i].addGestureRecognizer(gestureRecognizer)
        }
        timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.kenny), userInfo:nil, repeats: true)
        
        let storedScore=UserDefaults.standard.object(forKey: "save")
        if let newScore=storedScore as? String
        {
            highScoreLabel.text="HighScore: \(String(newScore))"
        }
    }
    @objc func funcGesture()
    {
        score=score+1
        scoreLabel.text="Score: \(String(score))"
    }
    @objc func kenny()
    {
        label1.text="Time: \(String(gameTime))"
        imageKenny[number].isHidden=true
        let randomInt = Int.random(in: 0..<4)
        imageKenny[randomInt].isHidden=false
        number=randomInt
        gameTime=gameTime-1
        
        if gameTime == 0
        {
            if score > highScore
            {
                highScoreLabel.text=String(score)
            }

            UserDefaults.standard.set(highScoreLabel.text, forKey: "save")
            UserDefaults.standard.synchronize()
            let alert=UIAlertController(title:"Try Again", message: "Game is Over", preferredStyle: UIAlertController.Style.alert)
            let okButton=UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
            let replayButton=UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                
                self.score=0
                self.scoreLabel.text="Score: \(String(self.score))"
                self.gameTime=30
                self.label1.text="Time: \(String(self.gameTime))"
                self.timer=Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.kenny), userInfo:nil, repeats: true)
                
                
            }
            alert.addAction(replayButton)
            alert.addAction(okButton)
            self.present(alert,animated: true,completion: nil)
            timer.invalidate()
            label1.text="0"
        }
        
        
    }
    
}

