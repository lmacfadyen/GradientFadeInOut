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

    override func viewWillAppear(animated: Bool) {
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
        let gradientDark = UIColor.blueColor()
        let gradientLight = UIColor.whiteColor()
        
        let color1 = gradientDark.CGColor as CGColorRef
        let color2 = gradientLight.CGColor as CGColorRef
        let color3 = gradientLight.CGColor as CGColorRef
        let color4 = gradientDark.CGColor as CGColorRef
        
        gradient.colors = [color1, color2, color3, color4]
        self.view.layer.insertSublayer(gradient, atIndex: 0)
    }
    
    func updateGradient()
    {
        gradient.frame = view.bounds
        gradient.locations = gradientLocations()
    }

    func gradientLocations() -> [CGFloat]
    {
        // Determine screen size and height
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let screenHeight = screenSize.height

        // Get the origin of the label
        let labelOrigin = CGPointMake(label.bounds.origin.x,label.bounds.origin.y);
        // Convert the label origin to its origin in the superview coordinate system
        let topInScreen = label.convertPoint(labelOrigin, toView: view)
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

