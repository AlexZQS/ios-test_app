//// 
//  FlutterMainViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/8/1
//  
//
//

import UIKit

class FlutterMainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Flutter Test Page"


        // Do any additional setup after loading the view.
        
        // Make a button to call the showFlutter function when pressed.
        let button = UIButton(type:UIButton.ButtonType.custom)
        button.addTarget(self, action: #selector(showFlutter), for: .touchUpInside)
        button.setTitle("Show Flutter!", for: UIControl.State.normal)
        button.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
        button.backgroundColor = UIColor.blue
        self.view.addSubview(button)
    }
    
    @objc func showFlutter() {
//        let flutterEngine = (UIApplication.shared.delegate as! AppDelegate).flutterEngine
//        let flutterViewController =
//            FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
//        self.navigationController?.pushViewController(flutterViewController, animated: true)
//        present(flutterViewController, animated: true, completion: nil)
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
