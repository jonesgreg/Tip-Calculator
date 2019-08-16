//
//  AnimationVC.swift
//  Tip Calculator
//
//  Created by Gregory Jones on 8/8/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit
import Lottie

class AnimationViewController: UIViewController {
    
         private var revealingLoaded = false
        
        // MARK: - Overriden function
        override func viewDidLoad() {
            super.viewDidLoad()
            view.addSubview(animationView)
            setupLayout()
            switchScreen()
            view.backgroundColor = Colors.darkPurple
            
        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            // Hide the navigation bar on the this view controller
            self.navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        
        
        
        private let animationView: AnimationView = {
            let animation = AnimationView(name: "Loading")
            animation.loopMode = .loop
            animation.play()
            animation.translatesAutoresizingMaskIntoConstraints = false
            return animation
        }()
        
        func setupLayout() {
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            animationView.widthAnchor.constraint(equalToConstant: 100).isActive = true
            animationView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        }
        
        func switchScreen() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Delay the time to push to the next view controller by 7 seconds
                let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
                let nextViewController = DisplayLogoViewController()
                self.navigationController?.pushViewController(nextViewController, animated: false)
            }
        }
}
