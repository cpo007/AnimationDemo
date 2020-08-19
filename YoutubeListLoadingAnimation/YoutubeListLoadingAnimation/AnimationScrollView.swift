//
//  AnimationScrollView.swift
//  YoutubeListLoadingAnimation
//
//  Created by cpo007@qq.com on 2020/8/19.
//  Copyright © 2020 cpo007@qq.com. All rights reserved.
//

import UIKit

@objc protocol AnimationScrollViewDelegate {
    func numOfRows() -> Int
}

extension AnimationScrollViewDelegate {
    func numOfRows() -> Int {
        return 2
    }
}

class AnimationScrollView: UIScrollView {
    let gradientLayer = CAGradientLayer()

    weak var animationDelegate: AnimationScrollViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.red
        gradientLayer.startPoint = CGPoint(x: 0, y: -0.25)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1.25)
        gradientLayer.locations = [0.25, 0.5, 0.75]
        let lightGrayColor = UIColor(red: 244 / 255, green: 244 / 255, blue: 244 / 255, alpha: 0.25).cgColor
        let darkGrayColor = UIColor(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 0.25).cgColor

        gradientLayer.colors = [darkGrayColor, lightGrayColor, darkGrayColor]
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    public func startAnimation() {
        let bSize = frame.size
        let backgroundLayer = CALayer()
        backgroundLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)

        let row = animationDelegate?.numOfRows() ?? 2
        let itemWidth = bSize.width
        let itemHeight = bSize.height / CGFloat(row)

        let lightGrayColor = UIColor(red: 244 / 255, green: 244 / 255, blue: 244 / 255, alpha: 1).cgColor
        let darkGrayColor = UIColor(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 1).cgColor

        for i in 0 ..< row {
            let row = CALayer()
            row.frame = CGRect(x: 0, y: CGFloat(i) * itemHeight, width: itemWidth, height: itemHeight)
            row.backgroundColor = lightGrayColor

            let content = CALayer()
            content.frame = CGRect(x: 0, y: 0, width: itemWidth, height: itemHeight * 3 / 5)
            content.backgroundColor = darkGrayColor

            let bottom = CALayer()
            bottom.frame = CGRect(x: 0, y: itemHeight * 3 / 5, width: itemWidth, height: itemHeight * 2 / 5)

            let cornerWidth = itemWidth * 1 / 5
            let lineWidth = itemWidth - cornerWidth
            let topSpace = bottom.frame.height * 1 / 9
            let lineHeight = bottom.frame.height * 1 / 8

            let corner = CALayer()
            corner.frame = CGRect(x: cornerWidth / 4, y: topSpace, width: cornerWidth / 2, height: cornerWidth / 2)
            corner.backgroundColor = darkGrayColor
            corner.cornerRadius = cornerWidth / 2 / 2

            let line1 = CALayer()
            line1.frame = CGRect(x: cornerWidth, y: topSpace * 1, width: lineWidth - 15, height: lineHeight)
            line1.backgroundColor = darkGrayColor

            let line2 = CALayer()
            line2.frame = CGRect(x: cornerWidth, y: topSpace * 2 + lineHeight * 1, width: lineWidth - 15, height: lineHeight)
            line2.backgroundColor = darkGrayColor

            let line3 = CALayer()
            line3.frame = CGRect(x: cornerWidth, y: topSpace * 3 + lineHeight * 2, width: (lineWidth - 15) / 2, height: lineHeight)
            line3.backgroundColor = darkGrayColor

            bottom.addSublayer(corner)
            bottom.addSublayer(line1)
            bottom.addSublayer(line2)
            bottom.addSublayer(line3)

            row.addSublayer(content)
            row.addSublayer(bottom)

            backgroundLayer.addSublayer(row)
        }

        backgroundLayer.backgroundColor = UIColor.lightGray.cgColor
        gradientLayer.frame = bounds

        let gradientAniamtion = CABasicAnimation(keyPath: "locations")
        gradientAniamtion.fromValue = [0.0, 0.0, 0.25]
        gradientAniamtion.toValue = [0.75, 1.0, 1.0]
        gradientAniamtion.duration = 3
        gradientAniamtion.repeatCount = Float.infinity
        gradientLayer.add(gradientAniamtion, forKey: nil)
        backgroundLayer.addSublayer(gradientLayer)
//        backgroundLayer.addSublayer(gradientLayer)
        layer.addSublayer(backgroundLayer)
//        self.layer.masksToBounds = true
    }

    public func stopAnimation() {
        
        
    }
}
