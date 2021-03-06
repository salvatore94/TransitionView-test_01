//
//  ViewController.swift
//  TransitionView-test_01
//
//  Created by Salvatore  Polito on 30/06/17.
//  Copyright © 2017 Salvatore  Polito. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let button = UIButton(frame: CGRect(x: 0, y: 0, width: 80, height: 60))
    let view1 = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 300))
    let view2 = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
    var open = false
    var touchInside = false
    var view2Width: CGFloat = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        
        view1.translatesAutoresizingMaskIntoConstraints = false
        view1.center = view.center
        view1.backgroundColor = .white
        
        
        view2.translatesAutoresizingMaskIntoConstraints = false
        view2.frame = CGRect(x: 0, y: 0, width: 0, height: 300)
        view2.center = CGPoint(x: view.center.x + self.view2Width, y: view.center.y)
        view2.backgroundColor = .red
        
        
        view.addSubview(view1)
        view.addSubview(view2)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("APRI", for: .normal)
        button.tintColor = .white
        button.center = CGPoint(x: (view.center.x - view1.bounds.width/2) - 70, y: view.center.y)
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(ViewController.btnPressed), for: .touchDown)
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPress(sender:)))
        longPressRecognizer.minimumPressDuration = 1.0
        
        view1.addGestureRecognizer(longPressRecognizer)
    }
    
    @objc func longPress(sender : UIGestureRecognizer) {
        print("longPress")
        print(sender.location(in: self.view))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let touchPoint = touch.location(in: view)
        let center = CGPoint(x: view.center.x + self.view2Width, y: view.center.y)
        let offsetMargin : CGFloat = 30
        
        if (touchPoint.x.distance(to: center.x).isLessThanOrEqualTo(offsetMargin) ) {
            touchInside = true
            
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touchInside {
            let touch = touches.first!
            let touchPoint = touch.location(in: view)
            let center = CGPoint(x: view.center.x + self.view2Width, y: view.center.y)
            let point = center.x - touchPoint.x
               // presentAnimatedView(to: center.x - touchPoint.x)
            if !open {
                if (self.view2.frame.width < self.view2Width/2) {
                    UIView.animate(withDuration: 0.3,  animations: {
                        self.view2.frame = CGRect(x: 0, y: 0, width: point, height: 300)
                        self.view2.center = CGPoint(x: self.view.center.x + self.view1.bounds.width/2 - point/2, y: self.view.center.y)
                    }, completion: {
                        (finished) in
                        if self.view2.frame.width == self.view2Width{
                            self.open = finished
                            self.button.setTitle("CHIUDI", for: .normal)
                        }
                    })
                } else {
                    UIView.animate(withDuration: 0.15,  animations: {
                        self.view2.frame = CGRect(x: 0, y: 0, width: point, height: 300)
                        self.view2.center = CGPoint(x: self.view.center.x + self.view1.bounds.width/2 - point/2, y: self.view.center.y)
                    }, completion: {
                        (finished) in
                        if self.view2.frame.width == self.view2Width{
                            self.open = finished
                            self.button.setTitle("CHIUDI", for: .normal)
                        }
                    })
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touchInside {
            if !open && (self.view2.frame.width > self.view2Width/2) {
                UIView.animate(withDuration: 0.15,  animations: {
                    self.view2.frame = CGRect(x: 0, y: 0, width: self.view2Width, height: 300)
                    self.view2.center = CGPoint(x: self.view.center.x + self.view1.bounds.width/2 - self.view2Width/2, y: self.view.center.y)
                }, completion: {
                    (finished) in
                    self.open = finished
                    self.touchInside = false
                    self.button.setTitle("CHIUDI", for: .normal)
                })
            } else {
                UIView.animate(withDuration: 0.15,  animations: {
                    self.view2.frame = CGRect(x: 0, y: 0, width: 0, height: 300)
                    self.view2.center = CGPoint(x: self.view.center.x + self.view2Width, y: self.view.center.y)
                }, completion: {
                    (finished) in
                    self.open = false
                    self.button.setTitle("APRI", for: .normal)
                })
            }
        }
    }
    
    
    @objc func btnPressed() {
        if (open == false) {
            UIView.animate(withDuration: 0.5,  animations: {
                self.view2.frame = CGRect(x: 0, y: 0, width: self.view2Width, height: 300)
                self.view2.center = CGPoint(x: self.view.center.x + self.view2Width/2, y: self.view.center.y)
            }, completion: {
                (finished) in
                self.open = finished
                self.button.setTitle("CHIUDI", for: .normal)
            })
        } else {
            UIView.animate(withDuration: 0.5,  animations: {
                self.view2.frame = CGRect(x: 0, y: 0, width: 0, height: 300)
                self.view2.center = CGPoint(x: self.view.center.x + self.view2Width, y: self.view.center.y)
            }, completion: {
                (finished) in
                self.open = false
                self.button.setTitle("APRI", for: .normal)
            })
        }
    }
}

