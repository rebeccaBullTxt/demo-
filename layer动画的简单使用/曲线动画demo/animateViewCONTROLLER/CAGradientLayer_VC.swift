//
//  CAGradientLayer_VC.swift
//  曲线动画demo
//
//  Created by SXF on 2021/7/13.
//

import UIKit

class CAGradientLayer_VC: UIViewController {

    
    
    var gradientLayer2 : CAGradientLayer!
    
    var timer : Timer!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.red
        bgView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        bgView.center = self.view.center
        bgView.center.y = self.view.center.y - 150
        self.view.addSubview(bgView)
        self.view.backgroundColor = .white
        
        let gradientLayer = CAGradientLayer()
                
        gradientLayer.colors = [UIColor.red.cgColor, UIColor.white.cgColor, UIColor.red.cgColor]
        
        //决定方向
        gradientLayer.locations = [-0.2,-0.1,0]  //决定中间阴影的搏击宽度
        
        //决定角度
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0)
        
        //
        gradientLayer.frame = bgView.bounds
        
        gradientLayer.type = .axial
        
        bgView.layer.addSublayer(gradientLayer)
        
        
        
        //做动画
        let baseAnimate = CABasicAnimation(keyPath: "locations")
        baseAnimate.fromValue =  [-0.2,-0.1,0]
        baseAnimate.toValue = [1,1.2, 1.3]
        baseAnimate.duration = 1
        baseAnimate.repeatCount = 10000
        baseAnimate.autoreverses = true
//        baseAnimate.repeatDuration = 1
        
        gradientLayer.add(baseAnimate, forKey: "anite1")
        
        
        
        
        
        
        
        
        
        
        
        let bgView2 = UIView()
        bgView2.backgroundColor = UIColor.red
        bgView2.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        bgView2.center = self.view.center
        bgView2.center.y = self.view.center.y + 200
        self.view.addSubview(bgView2)
        self.view.backgroundColor = .white
        
        let gradientLayer2 = CAGradientLayer()
                
        gradientLayer2.colors = [UIColor.red.cgColor, UIColor.white.cgColor, UIColor.red.cgColor]
        
        //决定方向
        gradientLayer2.locations = [-0.2,-0.1,0]  //决定中间阴影的搏击宽度
        
        //决定角度
        gradientLayer2.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer2.endPoint = CGPoint(x: 1, y: 1)
        
        //
        gradientLayer2.frame = bgView2.bounds
        
        gradientLayer2.type = .axial
        
        bgView2.layer.addSublayer(gradientLayer2)
        
        let layer2 = CALayer()
        layer2.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        layer2.backgroundColor = UIColor.purple.cgColor
        bgView2.layer.mask = layer2
        
        
//        let maskImaV = CALayer()
//        maskImaV.contents = UIImage(named: "testimage.png")
//        maskImaV.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
//        maskImaV.position = CGPoint(x: 100, y: 100)
//        bgView2.layer.mask = maskImaV
        
        
        
        

        self.gradientLayer2 = gradientLayer2
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (_) in
            let baseAnimate2 = CABasicAnimation(keyPath: "locations")
            baseAnimate2.fromValue =  [-0.2,-0.1,0]
            baseAnimate2.toValue = [1,1.2, 1.3]
            baseAnimate2.duration = 1
    //        baseAnimate2.repeatCount = 1
    //        baseAnimate2.autoreverses = true
    //        baseAnimate.repeatDuration = 1
    //        baseAnimate2.isRemovedOnCompletion = true
            gradientLayer2.add(baseAnimate2, forKey: "anite2")
        })
        timer.fire()
        
        
        
        
        
        self.crateaCheckBox()

    }
    
    
    fileprivate func crateaCheckBox(){
        let checkBox = SXF_checkBoxView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        checkBox.center = self.view.center
        checkBox.center.y = screenH - 200
        checkBox.normalSelected = true
        checkBox.cornerRadius = 3 //圆角
        checkBox.selecteCallback = {[weak self](selecte) in
            print((selecte == true) ? "选中" : "未选中")
        }
        self.view.addSubview(checkBox)
        
    }
    
    

    
    
    
    
    
    
    
    

}
