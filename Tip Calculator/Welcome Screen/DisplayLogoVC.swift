//
//  DisplayLogoVC.swift
//  Tip Calculator
//
//  Created by Gregory Jones on 8/8/19.
//  Copyright © 2019 Gregory Jones. All rights reserved.
//

import UIKit

class DisplayLogoViewController: UIViewController {
    
    private var revealingLoaded = false
    
    // MARK: - Overriden function
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(logoImageView)
        setupLayout()
        switchScreen()
        view.backgroundColor = Colors.darkPurple
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
   
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image:#imageLiteral(resourceName: "tipLogo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private func setupLayout() {
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant:300).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant:300).isActive = true
    }
    
    func switchScreen() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { // Delay the time to push to the next view controller by 7 seconds
            let nextViewController = HomePageViewController()
            self.navigationController?.pushViewController(nextViewController, animated: false)
        }
    }
}


