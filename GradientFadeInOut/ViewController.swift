//
//  ViewController.swift
//  GradientFadeInOut
//
//  Created by Lawrence F MacFadyen on 2016-04-05.
//  Copyright © 2016 LawrenceM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var gradient = CAGradientLayer()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        label.text = "Hoping Apple will soon release an updated MacBook Pro. \n#apple #macbook"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        updateGradient()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradient()
    }
    
    func setupGradient()
    {
        let gradientDark = UIColor.blue
        let gradientLight = UIColor.white
        
        let color1 = gradientDark.cgColor as CGColor
        let color2 = gradientLight.cgColor as CGColor
        let color3 = gradientLight.cgColor as CGColor
        let color4 = gradientDark.cgColor as CGColor
        
        gradient.colors = [color1, color2, color3, color4]
        self.view.layer.insertSublayer(gradient, at: 0)
    }
    
    func updateGradient()
    {
        gradient.frame = view.bounds
        gradient.locations = gradientLocations() as [NSNumber]
    }

    func gradientLocations() -> [CGFloat]
    {
        // Determine screen size and height
        let screenSize: CGRect = UIScreen.main.bounds
        let screenHeight = screenSize.height

        // Get the origin of the label
        let labelOrigin = CGPoint(x: label.bounds.origin.x,y: label.bounds.origin.y);
        // Convert the label origin to its origin in the superview coordinate system
        let topInScreen = label.convert(labelOrigin, to: view)
        // Set the gradient stop position above the label based on the y position in superview
        let topGradientStop = topInScreen.y
        // Compute the gradient stop number between 0 and 1 as ratio of screen height
        let topStopLocation = topGradientStop/screenHeight
        
        // Determine position for gradient to start below label by adding label height
        let bottomGradientStart = topGradientStop + label.bounds.size.height
        // Compute the gradient start number between 0 and 1 as ratio of screen height
        let bottomStartLocation = bottomGradientStart/screenHeight

        return [0.0, topStopLocation, bottomStartLocation, 1.0]
    }

}

