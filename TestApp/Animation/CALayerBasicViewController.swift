//// 
//  CALayerBasicViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/10/5
//  
//
//

import UIKit

class CALayerBasicViewController: BaseViewController {

    var mLayer: CALayer? = nil
    
    private lazy var redView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.addSubview(redView)
        self.redView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(80)
        }
        
        let layer = CALayer()
        self.navigationItem.title = "CALayer Basic"
        layer.frame = CGRectMake(100, 100, 100, 100)
        layer.backgroundColor = UIColor.green.cgColor
        self.mLayer = layer
        self.view.layer.addSublayer(layer)
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let animation = CABasicAnimation()
        animation.keyPath = "position.y"
        animation.toValue = 400
        animation.duration = 1
        
        /**
          默认为YES，代表动画执行完毕后就从图层上移除，
          图形会恢复到动画执行前的状态。
          如果想让图层保持显示动画执行后的状态，那就设置为NO，
          不过还要设置fillMode为kCAFillModeForwards
         
         */
        animation.isRemovedOnCompletion = false
        
        
        // 这里有2个图层，原始图层和presentation图层
        // 当动画开始的时候，原始的图层就会隐藏，presentation显示
        // 因为移动的时候，是presentation在移动，不是view本身在移动，
        // 当移动完成后，presentation会从屏幕移除
        // 然后原始图层显示，这种情况下，view就会恢复到原来的状态
        
        /**
         kCAFillModeForwards: 动画结束后，layer会一直保持动画最后的状态
         kCAFillModeBackwards: 动画开始前，只要将动画加入一个layer，layer便立即进入动画的
            初始状态，并等待动画开始
         kCAFillModeBoth: kCAFillModeForwards&kCAFillModeBackwards
         kCAFillModeRemoved: 默认，动画结束后，会恢复到原始状态
         */
        animation.fillMode = .forwards
        
        self.redView.layer.add(animation, forKey: nil)
        
        CATransaction.begin()
        CATransaction.setAnimationDuration(1.0)
        mLayer?.backgroundColor = UIColor.orange.cgColor
        CATransaction.setCompletionBlock {
            if let layer = self.mLayer {
                var transform = layer.affineTransform()
                transform = CGAffineTransformRotate(transform, M_PI_2)
                layer.setAffineTransform(transform)
            }
        }
        CATransaction.commit()
        // 颜色渐变的过程，既没有写动画，动画时间0.25秒。执行: runloop
    }
}
