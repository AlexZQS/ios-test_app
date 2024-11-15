//// 
//  UITableCustomCellViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/6/11
//  
//
//

import UIKit

class UITableCustomCellViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
//    var pics = ["58","60","62","63","64","66","67","70","72","73","89","98","74","76","77"]
    
    
//    var datas = [ChatVo]()
    
    enum Section: Hashable {
        case main
    }
    
    var dataSource: UITableViewDiffableDataSource<Section,ChatVo>!

    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.rowHeight = 100
        let popUpButton = UIButton.init(type: .system)
//        popUpButton.frame = CGRect.init(x: 100, y: 100, width: 100, height: 100)
        popUpButton.setTitle("Edit", for: .normal)
        popUpButton.showsMenuAsPrimaryAction = true
        popUpButton.menu = UIMenu(children: [
            UIAction(title: "添加数据", handler: { action in
                self.insert()
            }),
            UIAction(title: "更新数据", handler: { action in
                self.update()
            }),
            UIAction(title: "删除数据", handler: { action in
                self.delete()
            }),
            UIAction(title: "移动数据", handler: { action in
                self.move()
            }),
        ])

        let bar = UIBarButtonItem(customView: popUpButton)
        self.navigationItem.rightBarButtonItem = bar
//        self.tableView.register(TableViewCell1.self, forCellReuseIdentifier: "userCell")
        self.tableView.register(UINib.init(nibName: "TableViewCell1", bundle: nil), forCellReuseIdentifier: "userCell")
        // Do any additional setup after loading the view.
        configureDataSource()
        initData()
    }
    
    func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, ChatVo>(tableView: tableView) { (tableView, indexPath, item) -> UITableViewCell? in
            var cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? TableViewCell1
            
            if cell == nil {
                cell = TableViewCell1.init(style: .default, reuseIdentifier: "userCell")
            }
            print("item \(item.name) 更新了 内容是 \(item.content)")
            cell?.selectionStyle = UITableViewCell.SelectionStyle.none
//            var data = datas[indexPath.row]
            cell?.mBodyView.text = item.content
            cell?.mTitleView.text = item.name
            cell?.mTimeView.text = item.time
            
            return cell
        }
        dataSource.defaultRowAnimation = .automatic
        tableView.dataSource = dataSource
        // 初始数据加载
    }
    
    func applySnapshot(datas:[ChatVo],animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ChatVo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(datas,toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func updateSnapshot(datas:[ChatVo],animatingDifferences: Bool = true) {
        var snapshot = dataSource.snapshot()
        snapshot.reloadItems(datas)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func initData() {
        var datas = [ChatVo]()
        var chatVo1 = ChatVo()
        chatVo1.id = 1
        chatVo1.name = "alex"
        chatVo1.time = "4.11 11:22"
        chatVo1.content = "山姆开业了"
        chatVo1.sort = 1
        datas.append(chatVo1)
        
        var chatVo2 = ChatVo()
        chatVo2.id = 2
        chatVo2.name = "frank"
        chatVo2.time = "4.11 12:22"
        chatVo2.content = "快来开会"
        chatVo2.sort = 2
        datas.append(chatVo2)
        
        var chatVo3 = ChatVo()
        chatVo3.id = 3
        chatVo3.name = "json"
        chatVo3.time = "4.11 15:22"
        chatVo3.content = "下班了"
        chatVo3.sort = 3
        datas.append(chatVo3)

        
        var chatVo4 = ChatVo()
        chatVo4.id = 4
        chatVo4.name = "tom"
        chatVo4.time = "4.11 15:23"
        chatVo4.content = "好久请客"
        chatVo4.sort = 4
        datas.append(chatVo4)

        
        var chatVo5 = ChatVo()
        chatVo5.id = 5
        chatVo5.name = "mancy"
        chatVo5.time = "4.11 18:01"
        chatVo5.content = "好久放假"
        chatVo5.sort = 5
        datas.append(chatVo5)

        
        var chatVo6 = ChatVo()
        chatVo6.id = 6
        chatVo6.name = "ocen"
        chatVo6.time = "4.11 19:22"
        chatVo6.content = "日清"
        chatVo6.sort = 6
        datas.append(chatVo6)
        datas.sort { model1, model2 in
            model1.sort <= model2.sort
        }
        applySnapshot(datas: datas, animatingDifferences: false)
    }
    
    func insert() {
        var mDatas = [ChatVo]()
        var chatVo7 = ChatVo()
        chatVo7.id = 7
        chatVo7.name = "老李"
        chatVo7.time = "4.12 20:22"
        chatVo7.content = "this is a big sss"
        chatVo7.sort = 7
        mDatas.append(chatVo7)
        
        var chatVo8 = ChatVo()
        chatVo8.id = 8
        chatVo8.name = "老张"
        chatVo8.time = "4.12 20:29"
        chatVo8.content = "你好啊"
        chatVo8.sort = 8
        mDatas.append(chatVo8)
        
//        var chatVo1 = ChatVo()
//        chatVo1.id = 1
//        chatVo1.name = "aaa"
//        chatVo1.time = "20:19"
//        chatVo1.content = "给dataSource设置snapshot"
//        mDatas.append(chatVo1)
        let datas = dataSource.snapshot().itemIdentifiers
        let newDatas = Set(datas).union(mDatas)
        var newDataArray = Array(newDatas)
        newDataArray.sort { model1, model2 in
            model1.sort >= model2.sort
        }
        applySnapshot(datas: newDataArray, animatingDifferences: true)
        
//        var chatVo3 = ChatVo()
//        chatVo3.id = 3
//        chatVo3.name = "aaa"
//        chatVo3.time = "9:22"
//        datas.append(chatVo3)
//
//        
//        var chatVo4 = ChatVo()
//        chatVo4.id = 4
//        chatVo4.name = "aaa"
//        chatVo4.time = "10:50"
//        datas.append(chatVo4)
//
//        
//        var chatVo5 = ChatVo()
//        chatVo5.id = 5
//        chatVo5.name = "aaa"
//        chatVo5.time = "11:01"
//        datas.append(chatVo5)
//
//        
//        var chatVo6 = ChatVo()
//        chatVo6.id = 6
//        chatVo6.name = "aaa"
//        chatVo6.time = "14:29"
//        datas.append(chatVo6)
    }
    
    func update() {
        var mDatas = [ChatVo]()
        var chatVo7 = ChatVo()
        chatVo7.id = 1
        chatVo7.name = "alex"
        chatVo7.time = "9:11"
        chatVo7.content = "哈哈哈"
        chatVo7.sort = 12
        mDatas.append(chatVo7)
        
        var chatVo8 = ChatVo()
        chatVo8.id = 2
        chatVo8.name = "frank"
        chatVo8.time = "9:22"
        chatVo8.content = "笑死我了"
        chatVo8.sort = 13
        mDatas.append(chatVo8)
        
        //        var chatVo1 = ChatVo()
        //        chatVo1.id = 1
        //        chatVo1.name = "aaa"
        //        chatVo1.time = "20:19"
        //        chatVo1.content = "给dataSource设置snapshot"
        //        mDatas.append(chatVo1)
        let datas = dataSource.snapshot().itemIdentifiers
        let newDatas = Set(mDatas).union(datas)
        var newDataArray = Array(newDatas)
        newDataArray.sort { model1, model2 in
            model1.sort >= model2.sort
        }
//        self.datas = newDataArray
        applySnapshot(datas: newDataArray,animatingDifferences: false)
//        updateSnapshot(datas: mDatas, animatingDifferences: false)
    }
    
    func delete() {
        
        //        var chatVo1 = ChatVo()
        //        chatVo1.id = 1
        //        chatVo1.name = "aaa"
        //        chatVo1.time = "20:19"
        //        chatVo1.content = "给dataSource设置snapshot"
        //        mDatas.append(chatVo1)
        let datas = dataSource.snapshot().itemIdentifiers
        var newDataArray = Array(datas)
        newDataArray.remove(at: 3)
        applySnapshot(datas: newDataArray, animatingDifferences: true)
    }
    
    func move() {
        let chatVoa = ChatVo.init(id: 1, name: "alex", content: "hahaha", time: "12:11", sort: 7)
        let chatVob = ChatVo.init(id: 6,name: "ocen", content: "0000", time: "12:11", sort: 6)
        var snaopshot = dataSource.snapshot()
        snaopshot.moveItem(chatVoa, afterItem: chatVob)
        dataSource.apply(snaopshot, animatingDifferences: true) {
            var datas = [ChatVo]()
            var chatVo1 = ChatVo()
            chatVo1.id = 1
            chatVo1.name = "alex"
            chatVo1.time = "4.11 11:22"
            chatVo1.content = "hahaha"
            chatVo1.sort = 7
            datas.append(chatVo1)
            
            var chatVo2 = ChatVo()
            chatVo2.id = 2
            chatVo2.name = "frank"
            chatVo2.time = "4.11 12:22"
            chatVo2.content = "快来开会"
            chatVo2.sort = 2
            datas.append(chatVo2)
            
            var chatVo3 = ChatVo()
            chatVo3.id = 3
            chatVo3.name = "json"
            chatVo3.time = "4.11 15:22"
            chatVo3.content = "下班了"
            chatVo3.sort = 3
            datas.append(chatVo3)

            
            var chatVo4 = ChatVo()
            chatVo4.id = 4
            chatVo4.name = "tom"
            chatVo4.time = "4.11 15:23"
            chatVo4.content = "好久请客"
            chatVo4.sort = 4
            datas.append(chatVo4)

            
            var chatVo5 = ChatVo()
            chatVo5.id = 5
            chatVo5.name = "mancy"
            chatVo5.time = "4.11 18:01"
            chatVo5.content = "好久放假"
            chatVo5.sort = 5
            datas.append(chatVo5)

            
            var chatVo6 = ChatVo()
            chatVo6.id = 6
            chatVo6.name = "ocen"
            chatVo6.time = "4.11 19:22"
            chatVo6.content = "日清"
            chatVo6.sort = 6
            datas.append(chatVo6)
            datas.sort { model1, model2 in
                model1.sort <= model2.sort
            }
            self.applySnapshot(datas: datas, animatingDifferences: false)
            self.updateSnapshot(datas: [chatVoa,chatVob],animatingDifferences: false)
        }

        
    }

}

//extension UITableCustomCellViewController: UITableViewDataSource {
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return datas.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? TableViewCell1
//        
//        if cell == nil {
//            cell = TableViewCell1.init(style: .default, reuseIdentifier: "userCell")
//        }
//        cell?.selectionStyle = UITableViewCell.SelectionStyle.none
//        cell?.mBodyView.text = bodys[indexPath.row]
//        cell?.mTitleView.text = titles[indexPath.row]
//        cell?.mTimeView.text = times[indexPath.row]
//        cell?.mImageView.image = UIImage(named: pics[indexPath.row])
//        
//        return cell!
//    }
//    
//}

extension UITableCustomCellViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
//        return .delete
//    }
//    
//    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
//        return "Delete"
//    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let defaultAction = UITableViewRowAction(style: .default, title: "Default")     { (action, indexPath) in
            self.alertTitle("Default action at \(indexPath)")
        }
        let normalAction = UITableViewRowAction(style: .normal, title: "Normal") { (action, indexPath) in
            self.alertTitle("Normal action at \(indexPath)")
        }
        let destructiveAction = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.alertTitle("Delete action at \(indexPath)")
        }
        return [defaultAction, normalAction, destructiveAction]
    }

    func alertTitle(_ title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(alert, animated: true)
    }


}
