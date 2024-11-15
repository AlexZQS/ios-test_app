//// 
//  SnapKitViewController1.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/22
//  
//
//

import UIKit
import SnapKit

class SnapKitViewController1: BaseViewController {
    
    lazy var redView = UIView()
    lazy var topView = UIView()
    lazy var bottomView = UIView()
    lazy var bottomView1 = UIView()


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "SnapKit"
        redView.backgroundColor = UIColor.red
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(redView)
        
        self.redView.snp.makeConstraints { make in
            make.width.height.equalTo(100)
            make.center.equalTo(self.view)
        }
        
        topView.backgroundColor = UIColor.blue
        self.view.addSubview(topView)
        self.topView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
//            make.top.left.equalTo(20)
            make.left.equalTo(10)
            make.top.equalTo(self.view.snp_topMargin).offset(30)
//            make.top.equalTo(10)
        }
        
        
        bottomView.backgroundColor = UIColor.green
        self.view.addSubview(bottomView)
        self.bottomView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.bottom.right.equalTo(-20)
//            make.left.equalTo(10)
        }
        
        bottomView1.backgroundColor = UIColor.gray
        self.view.addSubview(bottomView1)
        self.bottomView1.snp.makeConstraints { make in
            make.width.height.bottom.equalTo(bottomView)
            make.right.equalTo(bottomView.snp.left).offset(-10)
//            make.left.equalTo(10)
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
