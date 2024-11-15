//// 
//  TestUiTableIndexViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/11
//  
//
//

import UIKit

class TestUiTableIndexViewController: BaseViewController {
    
    var sectionTitles = ["A","C","F","G","H","M","S","T","X","Z"]
    
    var contentsArray = [["阿为","周杰伦","无敌"],["阿为","老牛","理想"],["文杰","宝石","法撒旦法"],["娃儿","老板","员工"],["科比","乔丹","麦迪"],["邓肯","wet","无敌"],["卡卡","我","你说呢"],["无合肥","但凡你","保持"],["我合计","吴江市","赛诺菲"],["试试","世界等级","酸奶粉"],["邙","实际交付","你回到家"],["啥的姐夫","我饿甲方","省得麻烦"],["额无人","重合度","queue"]]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.sectionIndexBackgroundColor = UIColor.red
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


extension TestUiTableIndexViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contentsArray[section].count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "abc")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .value1, reuseIdentifier: "abc")
        }
        
        //default 只显示textLabel和imageView
        //subtitle value1 三个都显示
        //value2 只显示textLabel 和 textLabel
//        cell?.contentView.backgroundColor = UIColor.red
        let content =  self.contentsArray[indexPath.section][indexPath.row]
        cell?.textLabel?.text = content
        cell?.detailTextLabel?.text = "detail \(content)"
        cell?.imageView?.image = UIImage.init(named: "more_icon_sendfriend")
        return cell!
        
    }
    
    
}

extension TestUiTableIndexViewController: UITableViewDelegate {
    
    //索引的标题
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return self.sectionTitles
    }
    
    //点击索引
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        print(title)
        
        //一定要返回index
        return index
    }
    
}
