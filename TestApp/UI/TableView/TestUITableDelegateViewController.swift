//// 
//  TestUITableDelegateViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/10
//  
//
//

import UIKit

class TestUITableDelegateViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func editData(_ sender: Any) {
        tableView.setEditing(true, animated: true)
    }
    
    
    @IBAction func done(_ sender: Any) {
        tableView.setEditing(false, animated: true)
    }
    
    var content: Array<String>?
    
    var detailContent: Array<String>?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        self.content = ["Android1","Android2","Android3","Android4","Ansdroid5","Android6","Android7",
        "Android8","Android9","Android10","Android11","Android12"]
        
        self.detailContent = ["Android1 - zzz","Android2 - zzz","Android3 -zzz","Android4 -zzz","Ansdroid5 -zzz","Android6 -zzz","Android7 -zzz",
        "Android8 -zzz","Android9 -zzz","Android10 -zzz","Android11 -zzz","Android12 -zzz"]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "添加数据", style: UIBarButtonItem.Style.plain, target: self, action: #selector(rightClick))
        
    }
    
    @objc func rightClick() {
        
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

extension TestUITableDelegateViewController: UITableViewDataSource {
    
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
        cell?.textLabel?.text = self.content?[indexPath.row]
        cell?.detailTextLabel?.text = self.detailContent?[indexPath.row]
        cell?.imageView?.image = UIImage.init(named: "more_icon_sendfriend")
        return cell!
        
    }
    
}

extension TestUITableDelegateViewController: UITableViewDelegate {
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contentIn = self.content?[indexPath.row]
        print("cotnent is \(contentIn)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Android 大全"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Android 大全1"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
    }
    
    //允许编辑
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //提交编辑
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            content?.remove(at: indexPath.row)
            detailContent?.remove(at: indexPath.row)
    //        tableView.reloadData()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        } else if editingStyle == .insert {
            //增加一行数据
            self.content?.insert("Android 最新", at: indexPath.row)
            self.detailContent?.insert("Android 最新版系统", at: indexPath.row)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
       
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    //编辑的风格(默认是删除)
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .insert
    }
    
    //能否移动
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    //移动表格
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        var content = self.content?[sourceIndexPath.row] ?? ""
        self.content?.remove(at: sourceIndexPath.row)
        
        self.content?.insert(content, at: destinationIndexPath.row)
        
        
        var detailContent = self.detailContent?[sourceIndexPath.row] ?? ""
        self.detailContent?.remove(at: sourceIndexPath.row)
        
        self.detailContent?.insert(content, at: destinationIndexPath.row)
//        tableView.insertRows(at: [destinationIndexPath], with: .automatic)

    }
}
