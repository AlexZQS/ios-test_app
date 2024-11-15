//// 
//  SnapKitViewController2.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/22
//  
//
//

import UIKit

class SnapKitViewController2: UIViewController {
    
    
    lazy var view1 = UIView()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        
        self.view1.backgroundColor = UIColor.red
        self.view.addSubview(self.view1)
        
        
//        self.view1.snp.remakeConstraints { make in
//            
//        }
        self.view1.snp.updateConstraints { make in
            
        }
        self.view1.snp.makeConstraints { make in
            
            make.edges.equalTo(self.view).inset(UIEdgeInsets.init(top: 20, left: 20, bottom: 20, right: 20))
        }
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view1.snp.updateConstraints { make in
            make.edges.equalTo(self.view).inset(UIEdgeInsets.init(top: 100 , left: 100, bottom: 100, right: 100))
            
        }
        UIView.animate(withDuration: 1.5) {
            self.view.layoutIfNeeded()
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
