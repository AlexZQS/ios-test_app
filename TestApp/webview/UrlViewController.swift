//
//  ViewController.swift
//  movie_h5
//
//  Created by 张秋实 on 2023/12/11.
//

import UIKit
import WebKit
import SnapKit

class UrlViewController: BaseViewController {
    
    lazy var btnUrl: UIButton = {
        var button: UIButton = UIButton()
        button.setTitle("open", for: .normal)
        button.addTarget(self, action: #selector(btnUrlClick), for: .touchUpInside)
        button.backgroundColor = .red
        button.titleLabel?.textColor = UIColor.black
        return button
    }()
    
    lazy var tvUrl: UITextField = {
        var textField: UITextField = UITextField()
        textField.layer.cornerRadius = 8.0
        textField.layer.masksToBounds = true
        textField.backgroundColor = .lightGray
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addSubview(tvUrl)
        self.view.addSubview(btnUrl)
        
        self.tvUrl.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 25))
        }
        
        self.btnUrl.snp.makeConstraints { make in
            make.top.equalTo(tvUrl.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 60, height: 25))
        }
    }
    
    @objc func btnUrlClick() {
        if let url = self.tvUrl.text {
            let vc = WebViewPageViewController.init(host: url)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

