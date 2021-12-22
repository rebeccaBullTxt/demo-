//
//  SXF_checkBoxView.swift
//  曲线动画demo
//
//  Created by SXF on 2021/7/15.
//

import UIKit

class SXF_checkBoxView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.creaWrightView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.creaWrightView()
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    
    
    fileprivate func creaAnimateLayer(){
        
    }
    
    
    //按钮的可交互边距
    var margin = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    //点击按钮的缩放倍数  越小 缩放力度越大  默认 0.8
    var scaleZoom : CGFloat = 0.8
    
   
    
    
    var checkLayer : CAShapeLayer?
    let duration : CGFloat = 0.1
    var checkPath : UIBezierPath?
    let checkNumberLayer = CALayer()
    let upLayer = CALayer()
    var selecteBtn = UIControl()
    //选择回掉
    var selecteCallback : ((Bool)->())?
    
    //设置默认未选中
    var normalSelected = false {
        didSet{
            if normalSelected == true {
                //切换成选中状态
                self.selecteBtn.isSelected = false
                self.clickCheckBtn(sender: self.selecteBtn)
            }
        }
    }
    //默认是圆角
    var cornerRadius : CGFloat = 2 {
        didSet{
            checkNumberLayer.cornerRadius = cornerRadius
            upLayer.cornerRadius = cornerRadius
        }
    }
    
    var boardCorlor : UIColor = UIColor.gray {
        didSet{
            self.checkNumberLayer.borderColor = boardCorlor.cgColor
        }
    }
    var noramlFillCorlor : UIColor = UIColor.white {
        didSet{
            self.upLayer.backgroundColor = noramlFillCorlor.cgColor
        }
    }
    
    fileprivate func creaWrightView(){
        
        
        
        checkNumberLayer.backgroundColor = UIColor.red.cgColor
        
        checkNumberLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width - margin.left - margin.right, height: self.bounds.size.width - margin.bottom - margin.top)
        
       
        
        self.cornerRadius = min(checkNumberLayer.frame.size.width * 0.5, checkNumberLayer.frame.size.height * 0.5)
        
        
        checkNumberLayer.cornerRadius = self.cornerRadius
        
        
        checkNumberLayer.position = CGPoint(x: self.bounds.size.width * 0.5, y:self.bounds.size.height * 0.5)
        checkNumberLayer.masksToBounds = true
        
        checkNumberLayer.borderWidth = 2
        checkNumberLayer.borderColor = UIColor.clear.cgColor
        
        self.layer.addSublayer(checkNumberLayer)
        
        
        upLayer.frame = checkNumberLayer.bounds
        upLayer.backgroundColor = self.noramlFillCorlor.cgColor
        upLayer.transform = CATransform3DMakeScale(0, 0, 1)
        //
        upLayer.cornerRadius = self.cornerRadius
        upLayer.masksToBounds = true
        
        
        checkNumberLayer.addSublayer(upLayer)
        
        
        
//        checkNumberLayer.transform = CATransform3DMakeScale(0, 0, 1)
        
        
//        checkNumberLayerAnimate.repeatCount = MAXFLOAT
//        checkNumberLayerAnimate.autoreverses = true
//        checkNumberLayer.add(checkNumberLayerAnimate, forKey: "")
        
        
        
        
        
        //绘制小对号
        let leftMargin : CGFloat = checkNumberLayer.bounds.size.width * 0.2
        let rightMargin : CGFloat =  checkNumberLayer.bounds.size.width * 0.2
        let topMargin : CGFloat =  checkNumberLayer.bounds.size.height * 0.2
        let bottomMargin : CGFloat =  checkNumberLayer.bounds.size.height * 0.2
        
        let linWidth = checkNumberLayer.bounds.size.width * 0.15
        
        let checkNumberPath = UIBezierPath()
        checkNumberPath.move(to: CGPoint(x: leftMargin, y: checkNumberLayer.bounds.size.height * 0.6))
        checkNumberPath.addLine(to: CGPoint(x: checkNumberLayer.bounds.size.width * 0.4, y: checkNumberLayer.bounds.size.height - bottomMargin * 1.2))
        checkNumberPath.addLine(to: CGPoint(x: checkNumberLayer.bounds.size.width - rightMargin, y: checkNumberLayer.bounds.size.height * (0.3)))
        checkNumberPath.stroke()
        
        self.checkPath = checkNumberPath
        
        let shapLayer = CAShapeLayer()
        shapLayer.path = checkNumberPath.cgPath
        shapLayer.fillColor = UIColor.clear.cgColor
        shapLayer.strokeColor = UIColor.white.cgColor
        shapLayer.lineCap = .round
        shapLayer.lineJoin = .round
        shapLayer.lineWidth = linWidth
        shapLayer.strokeStart = 0.0
        shapLayer.strokeEnd = 1.0 //不写会消失
        checkNumberLayer.addSublayer(shapLayer)
        checkLayer = shapLayer
        
        let btn = UIControl()
        btn.frame = self.bounds
        self.addSubview(btn)
        btn.addTarget(self, action: #selector(clickCheckBtn(sender:)), for: .touchUpInside)
        btn.backgroundColor = .clear
        btn.isSelected = true
        self.selecteBtn = btn
        self.clickCheckBtn(sender: btn)
        
    }
    
//    checkLayer?.removeAllAnimations()
//    checkLayer?.strokeEnd = 0
    @objc func clickCheckBtn(sender : UIControl){
        
        self.checkViewAnimate()
        sender.isSelected = !sender.isSelected
        
        //回掉
        self.selecteCallback?(sender.isSelected)
        
        
        if sender.isSelected == true {
            
            self.checkNumberLayer.borderColor = UIColor.clear.cgColor
            
            self.checkLayer?.removeAllAnimations()
            self.checkLayer?.strokeEnd = 0.0
            upLayer.removeAllAnimations()
            upLayer.transform = CATransform3DMakeScale(0, 0, 1)
            self.startBgAnimate()
            self.selecteBtn.isUserInteractionEnabled = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.selecteBtn.isUserInteractionEnabled = true
                self.startCheckAnimate()
            }
            
        }else{
            
            self.checkNumberLayer.borderColor = self.boardCorlor.cgColor
            
            upLayer.removeAllAnimations()
            upLayer.transform = CATransform3DMakeScale(0, 0, 1)
            
            let shapLayerAnimate = CABasicAnimation(keyPath: "transform")
            shapLayerAnimate.duration = 0.1
            shapLayerAnimate.fromValue = CATransform3DMakeScale(0, 0, 1)
            shapLayerAnimate.toValue = CATransform3DMakeScale(1, 1, 1)
            shapLayerAnimate.fillMode = .forwards
    //        shapLayerAnimate.autoreverses = true
    //        shapLayerAnimate.repeatCount = 1
            shapLayerAnimate.isRemovedOnCompletion = false
            shapLayerAnimate.delegate = self
            upLayer.add(shapLayerAnimate, forKey: "upLayer")
            
            
            self.checkLayer?.removeAllAnimations()
            self.checkLayer?.strokeEnd = 0.0
            
            let shapLayerAnimate1 = CABasicAnimation(keyPath: "strokeEnd")
            shapLayerAnimate1.duration = CFTimeInterval(duration)
            shapLayerAnimate1.fromValue = 1.0
            shapLayerAnimate1.toValue = 0.0
            shapLayerAnimate1.fillMode = .forwards
    //        shapLayerAnimate.autoreverses = true
    //        shapLayerAnimate.repeatCount = 1
            shapLayerAnimate1.isRemovedOnCompletion = true
            shapLayerAnimate1.delegate = self
            
            checkLayer?.add(shapLayerAnimate1, forKey: "checkLayer")
            
            
        }
        
        
    }
    
    
    
    func checkViewAnimate(){
        
        checkNumberLayer.removeAllAnimations()
        checkNumberLayer.transform = CATransform3DMakeScale(scaleZoom, scaleZoom, 1)
        
        //背景做动画
        let checkNumberLayerAnimate = CABasicAnimation(keyPath: "transform")
        checkNumberLayerAnimate.duration = CFTimeInterval(0.2)
        checkNumberLayerAnimate.fromValue = CATransform3DMakeScale(scaleZoom, scaleZoom, 1)
        checkNumberLayerAnimate.toValue = CATransform3DMakeScale(1.0, 1.0, 1)
        checkNumberLayerAnimate.isRemovedOnCompletion = false
        checkNumberLayerAnimate.fillMode = .forwards
        checkNumberLayer.add(checkNumberLayerAnimate, forKey: "checkNumberLayerAnimate")
        
        
        
        
    }
    
    
    
    //选中动画
    func startCheckAnimate(){
        //做动画
        let shapLayerAnimate = CABasicAnimation(keyPath: "strokeEnd")
        shapLayerAnimate.duration = CFTimeInterval(0.1)
        shapLayerAnimate.fromValue = 0.0
        shapLayerAnimate.toValue = 1.0
        shapLayerAnimate.fillMode = .forwards
//        shapLayerAnimate.beginTime = 0.2 // ??这里会失效
//        shapLayerAnimate.autoreverses = true
//        shapLayerAnimate.repeatCount = 1
        shapLayerAnimate.isRemovedOnCompletion = false
        shapLayerAnimate.delegate = self
        
        //动画组
//        let anigroup = CAAnimationGroup()
//
//        anigroup.animations = [shapLayerAnimate]
//        anigroup.isRemovedOnCompletion = false
//        anigroup.fillMode = .forwards
//        anigroup.duration = CFTimeInterval(duration)
        
        checkLayer?.add(shapLayerAnimate, forKey: "checkLayer")
        
    }
    
    func startBgAnimate(){
        let shapLayerAnimate = CABasicAnimation(keyPath: "transform")
        shapLayerAnimate.duration = 0.2
        shapLayerAnimate.fromValue = CATransform3DMakeScale(1, 1, 1)
        shapLayerAnimate.toValue = CATransform3DMakeScale(0, 0, 1)
        shapLayerAnimate.fillMode = .forwards
//        shapLayerAnimate.autoreverses = true
//        shapLayerAnimate.repeatCount = 1
        shapLayerAnimate.isRemovedOnCompletion = false
        shapLayerAnimate.delegate = self
        upLayer.add(shapLayerAnimate, forKey: "upLayer")
    }
    
}


extension SXF_checkBoxView : CAAnimationDelegate{
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if anim .isKind(of: CABasicAnimation.self)  {
            guard let baseAnimate = anim as? CABasicAnimation else {
                return
            }
            
//            print("是 baseanimate      \(baseAnimate.keyPath)")
        }
    }
}
