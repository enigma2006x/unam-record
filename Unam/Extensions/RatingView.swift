//
//  RatingView.swift
//  Unam
//
//  Created by Jose Antonio Trejo Flores on 12/04/21.
//  Copyright © 2021 Jose Antonio Trejo Flores. All rights reserved.
//

import UIKit
import SwiftUI

final class RatingView: UIView, CAAnimationDelegate {
    
    private let circleLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()
    private let duration: TimeInterval = 0.40
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        createCircularPath()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        createCircularPath()
    }
    
    private func createCircularPath() {
        
        let halfSize = min(bounds.size.width / 2, bounds.size.height / 2)
        let arcCenter = CGPoint(x: halfSize, y: halfSize)
        let desiredLineWidth: CGFloat = 6
        let circularPath = UIBezierPath(arcCenter: arcCenter,
                                        radius: CGFloat( halfSize - (desiredLineWidth/2) ),
                                        startAngle: -.pi / 2,
                                        endAngle: 3 * .pi / 2,
                                        clockwise: true)
        
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.lineWidth = desiredLineWidth
        circleLayer.strokeColor = UIColor.black.cgColor
      
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = desiredLineWidth - 0.5
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = UIColor.red.cgColor
        
        gradientLayer.frame = bounds
       
        gradientLayer.startPoint = CGPoint(x: 0.48, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.mask = progressLayer
        
        layer.addSublayer(circleLayer)
        layer.addSublayer(gradientLayer)
        
        backgroundColor = .clear
        
        titleLabel.bounds = bounds
        titleLabel.center = arcCenter
        addSubview(titleLabel)
    }

    func showProgress(withColors colors: [CGColor], toValue value: Double) {
        
        gradientLayer.colors = colors
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = value
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
    
}

struct RatingChart: UIViewRepresentable {
    
    var value: Double

    func makeUIView(context: Context) -> RatingView {
        RatingView()
    }

    func updateUIView(_ uiView: RatingView, context: Context) {
        
        let valueText = value.removeDecimals()
        
        var attrsPercent: [NSAttributedString.Key: Any] = [:]
        if let smallFont = UIFont.mbBold {
            attrsPercent[NSAttributedString.Key.font] = smallFont
        }
        
        let percentValue =  NSMutableAttributedString(string: valueText, attributes: attrsPercent)
        
        var attrs: [NSAttributedString.Key: Any] = [NSAttributedString.Key.baselineOffset: 9]
        if let smallFont = UIFont.mbSmall {
            attrs[NSAttributedString.Key.font] = smallFont
        }
        
        let percentString = NSMutableAttributedString(string:"%", attributes:attrs)
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(percentValue)
        attributedString.append(percentString)
        uiView.titleLabel.attributedText = attributedString
      
        uiView.showProgress(withColors: [UIColor.customGold.cgColor, UIColor.customGold.cgColor], toValue: value / 100)
        
    }
}
