//// 
//  TestUITableViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/9
//  
//
//

import UIKit

class TestUITableViewController: BaseViewController, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var content: Array<String>?
    var detailContent: Array<String>?
    
    
    //有多少个分组
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //一个分组中有多少行
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.content!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /* 
        //纯代码实现复用
        var cell = tableView.dequeueReusableCell(withIdentifier: "abc")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "abc")
        }
        
        //default 只显示textLabel和imageView
        //subtitle value1 三个都显示
        //value2 只显示textLabel 和 textLabel
        cell?.textLabel?.text = "aaa"
        cell?.detailTextLabel?.text = "detail"
        cell?.imageView?.image = UIImage.init(named: "more_icon_sendfriend")
        return cell!
        */
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "abc")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "abc")
        }
        
        //default 只显示textLabel和imageView
        //subtitle value1 三个都显示
        //value2 只显示textLabel 和 textLabel
//        cell?.contentView.backgroundColor = UIColor.red
        cell?.contentView.backgroundColor = UIColor.white
        cell?.textLabel?.text = self.content?[indexPath.row]
        cell?.detailTextLabel?.text = self.detailContent?[indexPath.row]
        cell?.imageView?.image = UIImage.init(named: "more_icon_sendfriend")
        cell?.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
        return cell!
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.darkGray
        tableView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()

        }
        tableView.dataSource = self
        tableView.transform = CGAffineTransform(scaleX: 1, y: -1)

//        self.content = ["Android1","Android2","Android3","Android4","Ansdroid5","Android6","Android7",
//        "Android8","Android9","Android10","Android11","Android12"]
        
        self.content = ["Android1","Android2","Android3"]
        
        self.detailContent = ["Android1 - zzz","Android2 - zzz","Android3 -zzz","Android4 -zzz","Ansdroid5 -zzz","Android6 -zzz","Android7 -zzz",
        "Android8 -zzz","Android9 -zzz","Android10 -zzz","Android11 -zzz","Android12 -zzz"]
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
