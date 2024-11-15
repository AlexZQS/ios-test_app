//// 
//  OtherMainViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/11/15
//  
//
//

import UIKit

class OtherMainViewController: BaseViewController {
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    lazy var fileButton: UIButton = {
        
        var button1 = UIButton(type: .roundedRect)
//        var button = UIButton(configuration: .filled(),primaryAction: UIAction(title: "CALayer Animation",handler: { _ in
//            let vc = CALayerBasicViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
//        }))
        return button1
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "其他"
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp_topMargin)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        stackView.addArrangedSubview(fileButton)
        
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
