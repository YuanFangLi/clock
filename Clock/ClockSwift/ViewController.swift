//
//  ViewController.swift
//  ClockSwift
//
//  Created by Stan on 2017-02-03.
//  Copyright © 2017 stan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dialLayer = CALayer()
        dialLayer.bounds = CGRect(x: 0, y: 0, width: 150, height: 150)
        
        dialLayer.position = view.center
        dialLayer.contents = UIImage(named: "clock")?.cgImage
        
        
        view.layer.addSublayer(dialLayer)
        
        
        //设置秒针，并加到view中
        secondHandView.center = view.center
        view.addSubview(secondHandView)
        
        //设置分针，并加到view中
        minuteHandView.center = view.center
        view.addSubview(minuteHandView)
        
        //设置时针，并加到view中
        hourHandView.center = view.center
        view.addSubview(hourHandView)
        
        
        
        
        
        
        //    创建CADisplayLink
        let link = CADisplayLink(target: self, selector: #selector(clockRunning))
        //将创建的CADisplayLink加入到主线程中
        link.add(to: RunLoop.main, forMode: RunLoopMode.defaultRunLoopMode)
    }
    
    
    @objc private func clockRunning() {
        let tZone = NSTimeZone.local
        
        var calendar = NSCalendar.current
        
        let currentDate = Date()
        calendar.timeZone = tZone
        
        let currentTime = calendar.dateComponents([Calendar.Component.hour,Calendar.Component.minute,Calendar.Component.second], from: currentDate)
        
        //设置秒针
        let angle  = Double (currentTime.second!) * (Double.pi * 2.0 / 60)
        
        secondHandView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
        
        //设置分针
        let minuteAngle = Double (currentTime.minute!) * (Double.pi * 2.0 / 60)
        
        minuteHandView.transform = CGAffineTransform(rotationAngle: CGFloat(minuteAngle))
        
        //设置时针
        let hourAngle = Double (currentTime.hour!) * (Double.pi * 2.0 / 12)
        
        hourHandView.transform = CGAffineTransform(rotationAngle: CGFloat(hourAngle))
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //    MARK: - 懒加载
    //秒针
    lazy var secondHandView : UIView = {
        //设置秒针
        let secondHandView = UIView()
        secondHandView.backgroundColor = UIColor.red
        secondHandView.bounds = CGRect(x: 0, y: 0, width: 1, height: 60)
        
        //修改锚点
        secondHandView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        return secondHandView
    }()
    
    
    //分针
    lazy var minuteHandView : UIView = {
        //设置分针针
        let minuteHandView = UIView()
        minuteHandView.backgroundColor = UIColor.darkGray
        minuteHandView.bounds = CGRect(x: 0, y: 0, width: 3, height: 60)
        
        //修改锚点
        minuteHandView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        return minuteHandView
    }()
    
    
    //时针
    lazy var hourHandView : UIView = {
        //设置时针
        let hourHandView = UIView()
        hourHandView.backgroundColor = UIColor.darkGray
        hourHandView.bounds = CGRect(x: 0, y: 0, width: 1, height: 60)
        
        //修改锚点
        hourHandView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
        
        return hourHandView
    }()
    
}

