//
//  ViewController.swift
//  catchKennyTutorial
//
//  Created by Hüseyin Özdemir on 13.07.2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var hightScoreLabel: UILabel!
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    @IBOutlet weak var image9: UIImageView!
    
    
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var imageArray = [UIImageView]()
    var highScore = 0
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counter = 10
        scoreLabel.text = "score: \(score)"
        timeLabel.text = String(counter)
        let storedHighScore = UserDefaults.standard.object(forKey: "highScore")
        if storedHighScore == nil {
                  highScore = 0
                  hightScoreLabel.text = "Highscore: \(highScore)"
            
        }
        if let newScore = storedHighScore as? Int {
            highScore = newScore
            hightScoreLabel.text = "Highscore: \(highScore)"
        }
        
       
        
        
        imageArray = [image1, image2, image3, image4, image5, image6, image7, image8, image9]
       
        
        hideTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(hideFunc), userInfo: nil, repeats: true)
        //images were done enabale for interaction
        image1.isUserInteractionEnabled = true
        image2.isUserInteractionEnabled = true
        image3.isUserInteractionEnabled = true
        image4.isUserInteractionEnabled = true
        image5.isUserInteractionEnabled = true
        image6.isUserInteractionEnabled = true
        image7.isUserInteractionEnabled = true
        image8.isUserInteractionEnabled = true
        image9.isUserInteractionEnabled = true
        
        //done 9 recognizer for 9 image
        let recognizer1 = UITapGestureRecognizer(target:self , action: #selector(recogFunc))
        let recognizer2 = UITapGestureRecognizer(target:self , action: #selector(recogFunc))
        let recognizer3 = UITapGestureRecognizer(target:self , action: #selector(recogFunc))
        let recognizer4 = UITapGestureRecognizer(target:self, action: #selector(recogFunc))
        let recognizer5 = UITapGestureRecognizer(target:self , action: #selector(recogFunc))
        let recognizer6 = UITapGestureRecognizer(target:self , action: #selector(recogFunc))
        let recognizer7 = UITapGestureRecognizer(target:self , action: #selector(recogFunc))
        let recognizer8 = UITapGestureRecognizer(target:self , action: #selector(recogFunc))
        let recognizer9 = UITapGestureRecognizer(target:self , action: #selector(recogFunc))
        
       //9 recognizers were connected to 9 images
        image1.addGestureRecognizer(recognizer1)
        image2.addGestureRecognizer(recognizer2)
        image3.addGestureRecognizer(recognizer3)
        image4.addGestureRecognizer(recognizer4)
        image5.addGestureRecognizer(recognizer5)
        image6.addGestureRecognizer(recognizer6)
        image7.addGestureRecognizer(recognizer7)
        image8.addGestureRecognizer(recognizer8)
        image9.addGestureRecognizer(recognizer9)
        
        
        // ı created timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(cauntDown), userInfo: nil, repeats: true)
        
        
        
      
    }
    
    
    @objc func hideFunc(){
        for i in imageArray{
            i.isHidden = true
            
        }
        let random = Int(arc4random_uniform(UInt32(imageArray.count - 1)))
                imageArray[random].isHidden = false
        
        
    }
    
    
    
    //a func was created it will work when we touch images
    @objc func recogFunc (){
        score += 1
        scoreLabel.text = "score: \(score)"
       
        
        
    }
    
    // it is a selector for timer
    @objc func cauntDown(){
        counter -= 1
        timeLabel.text = String(counter)
        
        if counter == 0 {
            timer.invalidate()
            
            // ı defined hideTimer.ivalidate in here
            hideTimer.invalidate()
            for i in imageArray{
                i.isHidden = true
                if self.score > highScore{
                    
                    self.highScore = self.score
                    self.hightScoreLabel.text = "high score: \(self.highScore)"
                    UserDefaults.standard.set(self.highScore, forKey: "highScore")
                    
                }
                
                
                
            }
            
               
                
            // ı did a alert
            let alert = UIAlertController(title: "time's up", message: "do you want try again", preferredStyle: UIAlertController.Style.alert)
            // they are both action
            let okButton = UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.score = 0
                self.counter = 10
                self.scoreLabel.text = "score:\(self.score)"
                self.timeLabel.text = String(self.counter)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.8, target: self, selector: #selector(self.hideFunc), userInfo: nil, repeats: true)
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.cauntDown), userInfo: nil, repeats: true)
            }
                
                // ı connected actions to alert
                alert.addAction(okButton)
                alert.addAction(replayButton)
            
            // ı published alert on view
            self.present(alert, animated: true, completion: nil)
            
        
        }
        
        
        
    }


}

