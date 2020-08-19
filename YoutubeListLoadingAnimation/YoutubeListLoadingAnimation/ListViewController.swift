//
//  ListViewController.swift
//  YoutubeListLoadingAnimation
//
//  Created by cpo007@qq.com on 2020/8/19.
//  Copyright © 2020 cpo007@qq.com. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    var scrollView: AnimationScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView = AnimationScrollView(frame: CGRect.init(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64))
        self.view.addSubview(self.scrollView!)
        self.view.backgroundColor = UIColor.white
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView?.startAnimation()
        
    }
    

}
