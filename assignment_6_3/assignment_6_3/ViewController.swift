//
//  ViewController.swift
//  assignment_6_3
//
//  Created by Betty on 2/16/16.
//  Copyright © 2016 Betty. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var counter: Int = 0
    
    var done: Bool = false
    
    var results: [Int:String] = [1:"", 2:"", 3:"", 4:"", 5:"", 6:"", 7:"", 8:"", 9:""]
    
    var sound_0 : AVAudioPlayer?
    var sound_1 : AVAudioPlayer?
    var sound_2 : AVAudioPlayer?
    var sound_3 : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let sound_0 = setupAudioPlayerWithFile("sound_0", type:"mp3") {
            self.sound_0 = sound_0
        }
        if let sound_1 = setupAudioPlayerWithFile("sound_1", type:"mp3") {
            self.sound_1 = sound_1
        }
        if let sound_2 = setupAudioPlayerWithFile("sound_2", type:"mp3") {
            self.sound_2 = sound_2
        }
        if let sound_3 = setupAudioPlayerWithFile("sound_3", type:"mp3") {
            self.sound_3 = sound_3
        }

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if counter == 0{
            UIView.animateWithDuration(2.0, animations: {self.view.viewWithTag(115)?.transform = CGAffineTransformMakeScale(2.0, 2.0); self.view.viewWithTag(115)?.alpha = 0.5}, completion: nil)
            UIView.animateWithDuration(1.0, animations: {self.view.viewWithTag(115)?.transform = CGAffineTransformMakeScale(1, 1); self.view.viewWithTag(115)?.alpha = 1}, completion: nil)
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handlePAn(recognizer: UIPanGestureRecognizer){
        var order: Int = 0
        order = counter%2
        
        if order == 1{
            let translation = recognizer.translationInView(self.view)
            if let view = recognizer.view{
                view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            }
            recognizer.setTranslation(CGPointZero, inView: self.view)
            
            var numIntersect: Int = 0 // the number of how many squares are intersect with the recognizer.view
            var squareIntersect: Int = 0 //track the number of the square that is intersect with recognizer.view
            
            if recognizer.state == UIGestureRecognizerState.Ended{
                
                if counter < 10{
                    
                    for i in 1...9{
                        if CGRectIntersectsRect((view.viewWithTag(100+i)?.frame)!, recognizer.view!.frame){
                            //print("intersect")
                            //print("i \(i) \((view.viewWithTag(100+i)?.frame))")
                            //print(" R \(recognizer.view!.frame)")
                            squareIntersect = 100 + i
                            numIntersect++
                        }
                    }
                    //print("\(numIntersect)")
                    if numIntersect == 1{
                        if checkForOverlap(squareIntersect-100){
                            recognizer.view?.center = (view.viewWithTag(squareIntersect)?.center)!
                            //view.viewWithTag(squareIntersect)?.addSubview(recognizer.view!)
                            recognizer.view!.userInteractionEnabled = false
                            numIntersect = 0
                            counter++
                            results[squareIntersect-100] = "o"
                            checkForWin()
                        }else{
                            recognizer.view!.center.x = 233 + 50
                            recognizer.view?.center.y = 505 + 50
                        }
                    }
                    else{
                        //print("walala")
                        recognizer.view!.center.x = 233 + 50
                        recognizer.view?.center.y = 505 + 50
                        numIntersect = 0
                    }
                }
                }
        }
        print(counter)
    }
    
    @IBAction func handlePAn2(recognizer: UIPanGestureRecognizer){
        
        var order: Int = 0
        order = counter%2
        
        if order == 0{
            let translation = recognizer.translationInView(self.view)
            if let view = recognizer.view{
                view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            }
            recognizer.setTranslation(CGPointZero, inView: self.view)

            var numIntersect: Int = 0 // the number of how many squares are intersect with the recognizer.view
            var squareIntersect: Int = 0 //track the number of the square that is intersect with recognizer.view

            
            if recognizer.state == UIGestureRecognizerState.Ended{
                
                if counter < 10{
                    
                    for i in 1...9{
                        if CGRectIntersectsRect((view.viewWithTag(100+i)?.frame)!, recognizer.view!.frame){
                            //print("intersect")
                            //print("i \(i) \((view.viewWithTag(100+i)?.frame))")
                            //print(" R \(recognizer.view!.frame)")
                            squareIntersect = 100 + i
                            numIntersect++
                        }
                    }
                    //print("\(numIntersect)")
                    if numIntersect == 1{
                        if checkForOverlap(squareIntersect-100){
                            recognizer.view?.center = (view.viewWithTag(squareIntersect)?.center)!
                            //view.viewWithTag(squareIntersect)?.addSubview(recognizer.view!)
                            recognizer.view!.userInteractionEnabled = false
                            numIntersect = 0
                            counter++
                            results[squareIntersect-100] = "x"
                            checkForWin()
                        }else{
                            recognizer.view!.center.x = 52 + 50
                            recognizer.view?.center.y = 505 + 50
                        }
                    }
                    else{
                        //print("walala")
                        recognizer.view!.center.x = 52 + 50
                        recognizer.view?.center.y = 505 + 50
                        numIntersect = 0
                    }
                }
                
            }
        }
        print(counter)
    }
    
    func checkForWin(){
        
        print("check for win")
        
        
            if ((results[1] == results[2] &&  results[2] == results[3]) && (results[1] != "" &&  results[2] != "" && results[3] != "")){
                if let value = results[1]{
                    print("1 \(value) wins!")
                    drawLine(1,num3: 3)
                    sound_2?.play()
                    reset("win", who: "\(value)")
                    
                }
            }
            else if ((results[4] == results[5] && results[5] == results[6]) && (results[4] != "" &&  results[5] != "" && results[6] != "")){
                if let value = results[4]{
                    print("2 \(value) wins!")
                    drawLine(4,num3: 6)
                    sound_2?.play()
                    reset("win", who: "\(value)")
                    
                }
            }
            else if ((results[7] == results[8] && results[8] == results[9]) && (results[7] != "" &&  results[8] != "" && results[9] != "")){
                
                print("789")
                if let value = results[7]{
                    print("3 \(value) wins!")
                    drawLine(7,num3: 9)
                    sound_2?.play()
                    reset("win", who: "\(value)")
                }
            }
            else if ((results[1] == results[4] && results[4] == results[7]) && (results[1] != "" &&  results[4] != "" && results[7] != "")){
                if let value = results[1]{
                    print("4 \(value) wins!")
                    drawLine(1,num3: 7)
                    sound_2?.play()
                    reset("win", who: "\(value)")

                }
            }
            else if ((results[2] == results[5] && results[5] == results[8]) && (results[2] != "" &&  results[5] != "" && results[8] != "")){
                if let value = results[2]{
                    print("5 \(value) wins!")
                    drawLine(2,num3: 8)
                    sound_2?.play()
                    reset("win", who: "\(value)")
                }
            }
            else if ((results[3] == results[6] && results[6] == results[9]) && (results[3] != "" &&  results[6] != "" && results[9] != "")){
                if let value = results[3]{
                    print("6 \(value) wins!")
                    drawLine(3,num3: 9)
                    sound_2?.play()
                    reset("win", who: "\(value)")
                }
            }
            else if ((results[1] == results[5] && results[5] == results[9]) && (results[1] != "" &&  results[5] != "" && results[9] != "")){
                if let value = results[1]{
                    print("7 \(value) wins!")
                    drawLine(1,num3: 9)
                    sound_2?.play()
                    reset("win", who: "\(value)")
                }
            }
            else if ((results[3] == results[5] && results[5] == results[7]) && (results[3] != "" &&  results[5] != "" && results[7] != "")){
                if let value = results[3]{
                    print("8 \(value) wins!")
                    drawLine(3,num3: 7)
                    sound_2?.play()
                    reset("win", who: "\(value)")
                }
            }
            else{
                //if counter <9, the game is continue
                if counter < 9 {
                    print("continue")
                    //view.viewWithTag(121)?.transform = CGAffineTransformMakeScale(2, 2)
                    if counter == 1{
                        UIView.animateWithDuration(2.0, animations: {self.view.viewWithTag(124)?.transform = CGAffineTransformMakeScale(1.5, 1.5); self.view.viewWithTag(124)?.alpha = 0.5}, completion: nil)
                        UIView.animateWithDuration(1.0, animations: {self.view.viewWithTag(124)?.transform = CGAffineTransformMakeScale(1, 1); self.view.viewWithTag(124)?.alpha = 1}, completion: nil)
                    }
                    else if counter == 2{
                        UIView.animateWithDuration(2.0, animations: {self.view.viewWithTag(114)?.transform = CGAffineTransformMakeScale(2, 2); self.view.viewWithTag(114)?.alpha = 0.5}, completion: nil)
                        UIView.animateWithDuration(1.0, animations: {self.view.viewWithTag(114)?.transform = CGAffineTransformMakeScale(1, 1); self.view.viewWithTag(114)?.alpha = 1}, completion: nil)
                    }
                    else if counter == 3{
                        UIView.animateWithDuration(2.0, animations: {self.view.viewWithTag(123)?.transform = CGAffineTransformMakeScale(1.5, 1.5); self.view.viewWithTag(123)?.alpha = 0.5}, completion: nil)
                        UIView.animateWithDuration(1.0, animations: {self.view.viewWithTag(123)?.transform = CGAffineTransformMakeScale(1, 1); self.view.viewWithTag(123)?.alpha = 1}, completion: nil)
                    }
                    else if counter == 4{
                        UIView.animateWithDuration(2.0, animations: {self.view.viewWithTag(113)?.transform = CGAffineTransformMakeScale(1.5, 1.5); self.view.viewWithTag(113)?.alpha = 0.5}, completion: nil)
                        UIView.animateWithDuration(1.0, animations: {self.view.viewWithTag(113)?.transform = CGAffineTransformMakeScale(1, 1); self.view.viewWithTag(113)?.alpha = 1}, completion: nil)
                    }
                    else if counter == 5{
                        UIView.animateWithDuration(2.0, animations: {self.view.viewWithTag(122)?.transform = CGAffineTransformMakeScale(1.5, 1.5); self.view.viewWithTag(122)?.alpha = 0.5}, completion: nil)
                        UIView.animateWithDuration(1.0, animations: {self.view.viewWithTag(122)?.transform = CGAffineTransformMakeScale(1, 1); self.view.viewWithTag(122)?.alpha = 1}, completion: nil)
                    }
                    else if counter == 6{
                        UIView.animateWithDuration(2.0, animations: {self.view.viewWithTag(112)?.transform = CGAffineTransformMakeScale(1.5, 1.5); self.view.viewWithTag(112)?.alpha = 0.5}, completion: nil)
                        UIView.animateWithDuration(1.0, animations: {self.view.viewWithTag(112)?.transform = CGAffineTransformMakeScale(1, 1); self.view.viewWithTag(112)?.alpha = 1}, completion: nil)
                   
                    }
                    else if counter == 7{
                        UIView.animateWithDuration(2.0, animations: {self.view.viewWithTag(121)?.transform = CGAffineTransformMakeScale(1.5, 1.5); self.view.viewWithTag(121)?.alpha = 0.5}, completion: nil)
                        UIView.animateWithDuration(1.0, animations: {self.view.viewWithTag(121)?.transform = CGAffineTransformMakeScale(1, 1); self.view.viewWithTag(121)?.alpha = 1}, completion: nil)
                    }
                    else if counter == 8{
                        UIView.animateWithDuration(2.0, animations: {self.view.viewWithTag(111)?.transform = CGAffineTransformMakeScale(2, 2); self.view.viewWithTag(111)?.alpha = 0.5}, completion: nil)
                        UIView.animateWithDuration(1.0, animations: {self.view.viewWithTag(111)?.transform = CGAffineTransformMakeScale(1, 1); self.view.viewWithTag(111)?.alpha = 1}, completion: nil)
                    }
                    
                }
                //if counter ==9, it's a tie, restart the game
                if counter == 9 {
                    print("its a tie!")
                    reset("tie", who: "x")
                }
        }
    }
    
    func checkForOverlap(position: Int) ->Bool{
        if (results[position] == "x" || results[position] == "o"){
            //print("false")
            sound_3?.play()
            return false
        }else{
            //print("true")
            sound_0?.play()
            return true
        }
    }
    
    func drawLine(num1: Int, num3: Int){
       
//        let aPath = UIBezierPath()
//        
//        aPath.moveToPoint(CGPoint(x:view.viewWithTag(100+num1)!.center.x, y:view.viewWithTag(100+num1)!.center.y))
//        
//        aPath.addLineToPoint(CGPoint(x:view.viewWithTag(100+num3)!.center.x, y:view.viewWithTag(100+num3)!.center.y))
//        
//        UIColor.redColor().set()
//        //Keep using the method addLineToPoint until you get to the one where about to close the path
//        print("start draw")
//        aPath.closePath()

    }
    
    func reset(status: String, who: String){
        //show view
        let endView=UIView(frame: CGRectMake((view.viewWithTag(101)?.center.x)!, (view.viewWithTag(101)?.center.y)!, 200, 300))
        endView.backgroundColor=UIColor.whiteColor()
        endView.layer.cornerRadius=25
        endView.layer.borderWidth=2
        let button_0 = UIButton(frame: CGRect(x: (view.viewWithTag(101)?.center.x)! + 20, y: (view.viewWithTag(101)?.center.y)!+20, width: 100, height: 100))
        button_0.setTitle("Ok", forState: .Normal)
        button_0.setTitleColor(UIColor.darkGrayColor(),forState: .Normal)
        button_0.addTarget(self, action: "buttonTapped:", forControlEvents:UIControlEvents.TouchUpInside)
        endView.tag = 200
        
        let endLabel: UILabel = UILabel()
        endLabel.frame = CGRectMake(50, 150, 200, 21)
        //endLabel.backgroundColor = UIColor.orangeColor()
        endLabel.textColor = UIColor.blackColor()
        endLabel.textAlignment = NSTextAlignment.Center
        if status == "win" {
            endLabel.text = "\(who) wins!"
        }else{
            endLabel.text = "It's a tie!"
        }
        
        endView.addSubview(endLabel)
        
        endView.addSubview(button_0)
        self.view.addSubview(endView)
    }
    
    func buttonTapped(sender:UIButton!){
        
        for i in 1...5 {
            view.viewWithTag(110 + i)!.userInteractionEnabled = true
            view.viewWithTag(110 + i)!.center = CGPoint(x: 52 + 50 , y: 505 + 50)
        }
        for i in 1...4 {
            view.viewWithTag(120 + i)!.userInteractionEnabled = true
            view.viewWithTag(120 + i)!.center = CGPoint(x: 233 + 50 , y: 505 + 50)
        }
        for i in 1...9{
            results[i] = ""
        }
        counter = 0
        print("\(counter)")
        print("button tapped")
        
        view.viewWithTag(200)?.removeFromSuperview()
        
        print("remove superview")
        sound_0?.play()
    }
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer?  {
        //1
        let path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        let url = NSURL.fileURLWithPath(path!)
        
        //2
        var audioPlayer:AVAudioPlayer?
        
        // 3
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: url)
        } catch {
            print("Player not available")
        }
        
        return audioPlayer
    }
    
    
}

