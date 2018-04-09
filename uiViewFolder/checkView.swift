//
//  checkView.swift
//  ticTacToeEricW
//
//  Created by Macbook on 4/9/18.
//  Copyright © 2018 Eric Witowski. All rights reserved.
//

import UIKit
import QuartzCore

class checkView: UIView
{
    
    //MARK: Public var
    
    var check: Player? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    
    //MARK: Private func
    
    fileprivate func setupView()
    {
        layer.cornerRadius = 6.0
        layer.masksToBounds = true
        backgroundColor = UIColor.white
    }
    
    
    //MARK: Public func
    
    required override init(frame: CGRect)
    {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    
    /// Draw an X or an O if mark is set, otherwise draw nothing
    
    override func draw(_ rect: CGRect)
    {
        let height = self.bounds.size.height
        backgroundColor = UIColor.clear
        let lineWidth = 0.15*height
        
        if let check = check {
            switch check {
            case .x:
                let color: [CGFloat] = [ 203.0/255.0, 66.0/255.0, 76.0/255.0, 1.0 ]
                let aColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: color)
                let context = UIGraphicsGetCurrentContext()
                context?.setLineWidth(lineWidth)
                context?.setFillColor(aColor!)
                context?.setStrokeColor(aColor!)
                context?.beginPath()
                context?.move(to: CGPoint(x: 0.0, y: 0.0))
                context?.addLine(to: CGPoint(x: bounds.size.width-0.0, y: bounds.size.width-0.0))
                context?.move(to: CGPoint(x: 0.0, y: bounds.size.width-0.0))
                context?.addLine(to: CGPoint(x: bounds.size.width-0.0, y: 0.0))
                context?.closePath()
                context?.strokePath()
            case .o:
                let color: [CGFloat] = [ 40.0/255.0, 140.0/255.0, 180.0/255.0, 1.0 ]
                let aColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: color)
                let context = UIGraphicsGetCurrentContext()
                context?.setLineWidth(lineWidth)
                context?.setFillColor(aColor!)
                context?.setStrokeColor(aColor!)
                let center = CGPoint(x: bounds.size.width / 2.0, y: bounds.size.height / 2.0)
                context?.beginPath()
                context?.addArc(center: center, radius: bounds.size.width/2.6, startAngle: 0, endAngle: CGFloat(2.0*M_PI), clockwise: true)
                context?.strokePath()
            }
        }
    }
    
    
}

