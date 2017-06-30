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
    }

    
    @objc func btnPressed() {
        if (open == false) {
            UIView.animate(withDuration: 3,  animations: {
                self.view2.frame = CGRect(x: 0, y: 0, width: self.view2Width, height: 300)
                self.view2.center = CGPoint(x: self.view.center.x + self.view2Width/2, y: self.view.center.y)
            }, completion: {
                (finished) in
                self.open = finished
                self.button.setTitle("CHIUDI", for: .normal)
            })
        } else {
            UIView.animate(withDuration: 3,  animations: {
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

