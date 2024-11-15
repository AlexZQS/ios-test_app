//// 
//  AnimationMainViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/9/30
//  
//
//

import UIKit

class AnimationMainViewController: BaseViewController {
    
    
    private lazy var container: UIStackView = {
        let verticalView = UIStackView()
        verticalView.axis = .vertical
        verticalView.distribution = .fill
        verticalView.alignment = .center
        verticalView.spacing = 10
        return verticalView
    }()
    
//    private lazy var btnCalayerAnimation: UIButton = {
//        var button  = UIButton(configuration: .filled(),primaryAction: UIAction(title: "CALayer Animation",handler: { _ in
//            let vc = CALayerBasicViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }))
//        button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
//        return button
//    }()
//    
//    private lazy var btnCALayerCoreAnimation: UIButton = {
//        var button  = UIButton(configuration: .filled(),primaryAction: UIAction(title: "CALayer Core Animation",handler: { _ in
//            let vc = CALayerCoreViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }))
//        button.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
//        return button
//    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "动画"
        // Do any additional setup after loading the view.
        self.view.addSubview(self.container)
        self.container.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(50) // 左边距 50
            make.right.equalToSuperview().offset(-50) // 右边距 50
            make.top.lessThanOrEqualTo(self.view.snp_topMargin).offset(50) // 顶部距导航栏 50
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50) // 底部距安全区 50
        }
        // 让 childView 自适应内容
//        self.container.snp.makeConstraints { make in
//            make.height.greaterThanOrEqualTo(0) // 设置最小高度，保证内容自适应
//            make.width.equalTo(self.view.snp.width).offset(-100) // 宽度减去左右边距
//        }
//        self.container.addArrangedSubview(self.btnCalayerAnimation)
//        self.container.addArrangedSubview(self.btnCALayerCoreAnimation)
        
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
