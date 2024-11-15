//// 
//  CALayerCoreViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/10/8
//  
//
//

import UIKit

class CALayerCoreViewController: BaseViewController {
    
    private lazy var view1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
    
    private lazy var view2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "CALayer Core Animation"
        // Do any additional setup after loading the view.
        self.view.addSubview(self.view1)
        self.view.addSubview(self.view2)
        
        let image = UIImage(named: "img.png")
        self.view.layer.contents = image?.cgImage
        self.view.layer.contentsGravity = .resizeAspect
        
        // 当用代码设置contents图片时，要手动设置图层的contentsScale的属性，避免Retina屏幕显示错误
        self.view.layer.contentsScale = UIScreen.main.scale
        
        // 显示是否能超出边界内容
        self.view.layer.masksToBounds = true
        
        self.view1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.view.snp_topMargin).offset(5)
            make.size.equalTo(80)

        }
        
        self.view2.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(80)

        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
