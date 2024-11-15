////
//  UIDiffTableViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/9/14
//
//
//

import UIKit

class UIDiffTableViewController: BaseViewController {
    enum Section: Hashable {
        case specificDate(Int)  // 使用日期字符串来确保唯一性
    }
    
    private lazy var dataSource = configureDataSource()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.rowHeight = 70
        tableView.register(MessageViewCell.classForCoder(), forCellReuseIdentifier: "MessageViewCell")
        tableView.separatorStyle = .none
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Diff TableView"
        self.view.addSubview(tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp_topMargin).offset(1)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
       
        
        let popUpButton = UIButton.init(type: .system)
        //        popUpButton.frame = CGRect.init(x: 100, y: 100, width: 100, height: 100)
        popUpButton.setTitle("Edit", for: .normal)
        popUpButton.showsMenuAsPrimaryAction = true
        popUpButton.menu = UIMenu(children: [
            UIAction(title: "添加数据", handler: { action in
                self.initData()
            }),
            UIAction(title: "更新数据", handler: { action in
                
            }),
            UIAction(title: "删除数据", handler: { action in
                
            }),
        ])
        
        let bar = UIBarButtonItem(customView: popUpButton)
        self.navigationItem.rightBarButtonItem = bar
        
        
        // 添加长按删除手势
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(_:)))
        self.tableView.addGestureRecognizer(longPressGesture)
        
        // Do any additional setup after loading the view.
    }
    
    func configureDataSource() -> UITableViewDiffableDataSource<Section,MessageVo> {
        let dataSource = UITableViewDiffableDataSource<Section, MessageVo>(tableView: tableView) { (tableView, indexPath, item) -> UITableViewCell? in
            var cell = tableView.dequeueReusableCell(withIdentifier: "MessageViewCell") as? MessageViewCell
            
            if cell == nil {
                cell = MessageViewCell.init(style: .default, reuseIdentifier: "MessageViewCell")
            }
            print("item \(item.name) 更新了")
            cell?.setModel(messageVo: item)
            return cell
        }
        tableView.dataSource = dataSource
        return dataSource
    }
    
    // 处理长按删除
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        let location = gesture.location(in: tableView)
        if let indexPath = tableView.indexPathForRow(at: location), gesture.state == .began {
            // 获取要删除的 cell
            if let cell = tableView.cellForRow(at: indexPath) {
                performSmashAnimation(on: cell, messageVo: dataSource.snapshot().itemIdentifiers[indexPath.row])
            }
        }
    }
    
    func performSmashAnimation(on cell: UITableViewCell, messageVo: MessageVo) {
            
    }
    
    func initData() {
        var datas = [MessageVo]()
        
        // 2024-09-9 12:16:52
        let data1 = MessageVo(id: 1, content: "哈哈哈", name: "陆建新", sort: 1, time: 1725855412000)
        datas.append(data1)
        
        // 2024-09-10 12:16:52
        let data2 = MessageVo(id: 2, content: "11111", name: "陆建新1", sort: 2, time: 1725941812000)
        datas.append(data2)
        
        // 2024-09-11 12:18:52
        let data3 = MessageVo(id: 3, content: "这是地方撒旦", name: "陆建新2", sort: 3, time: 1726028332000)
        datas.append(data3)
        
        // 2024-09-12 12:18:52
        let data4 = MessageVo(id: 4, content: "为荣", name: "陆建新3", sort: 4, time: 1726114732000)
        datas.append(data4)
        
        // 2024-09-12 13:18:52
        let data5 = MessageVo(id: 5, content: "不去了，吃过了", name: "陆建新4", sort: 5, time: 1726118332000)
        datas.append(data5)
        
        // 2024-09-13 13:18:52
        let data6 = MessageVo(id: 6, content: "买不买新手机", name: "陆建新5", sort: 6, time: 1726204732000)
        datas.append(data6)
        
        // 2024-09-14 13:18:52
        let data7 = MessageVo(id: 7, content: "限额了", name: "陆建新6", sort: 7, time: 1726291132000)
        datas.append(data7)
        
        // 2024-09-15 13:18:52
        let data8 = MessageVo(id: 8, content: "下班了", name: "陆建新7", sort: 8, time: 1726377532000)
        datas.append(data8)
        
        // 2024-09-16 13:18:52
        let data9 = MessageVo(id: 9, content: "今天没课", name: "陆建新8", sort: 9, time: 1726463932000)
        datas.append(data9)
        
        
        // 2024-09-17 13:18:52
        let data10 = MessageVo(id: 10, content: "今天没课", name: "陆建新9", sort: 9, time: 1726550332000)
        datas.append(data10)
        
        // 2024-09-17 14:18:52
        let data11 = MessageVo(id: 11, content: "哈哈哈", name: "陆建新10", sort: 9, time: 1726553932000)
        datas.append(data11)
        
        // 2024-09-17 16:18:52
        let data12 = MessageVo(id: 12, content: "获取当前时间戳", name: "陆建新11", sort: 9, time: 1726561132000)
        datas.append(data12)
        
        // 2024-09-17 18:19:52
        let data13 = MessageVo(id: 13, content: "sdk 1.8.0", name: "陆建新12", sort: 9, time: 1726568392000)
        datas.append(data13)
        
        // 2024-09-18 10:19:52
        let data14 = MessageVo(id: 14, content: "北京时间", name: "陆建新13", sort: 9, time: 1726625992000)
        datas.append(data14)
        
        // 2024-09-18 10:22:53
        let data15 = MessageVo(id: 15, content: "在线工具", name: "陆建新14", sort: 10, time: 1726626173000)
        datas.append(data15)
        
        applySnapshot(messages: datas,animatingDifferences: false)
    }
    
    func applySnapshot(messages: [MessageVo], animatingDifferences: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, MessageVo>()
        
        var datas = [Int:[MessageVo]]()
        for i in 0...(messages.count - 1) {
            let messageVo = messages[i]
            let currentTime = messageVo.time
            let currentTimeSection = Section.specificDate(messageVo.time)
            
            if i == 0 {
                if !snapshot.sectionIdentifiers.contains(currentTimeSection) {
                    snapshot.appendSections([currentTimeSection])
                    snapshot.appendItems([messageVo], toSection: currentTimeSection)
                }
            } else {
                let previousMessageVo = messages[i - 1]
                let previousTime = previousMessageVo.time
                let previousDate =  Date(timeIntervalSince1970: TimeInterval(previousTime/1000))
                let currentDate =  Date(timeIntervalSince1970: TimeInterval(currentTime/1000))
                let isSameDay = previousDate.isSameDay3(previousDate, currentDate)
                if !isSameDay {
                    snapshot.appendSections([currentTimeSection])
                    snapshot.appendItems([messageVo], toSection: currentTimeSection)
                } else {
                    if let previousTimeSection = snapshot.sectionIdentifier(containingItem: previousMessageVo) {
                        if !snapshot.sectionIdentifiers.contains(previousTimeSection) {
                            snapshot.appendSections([previousTimeSection])
                        }
                        snapshot.appendItems([messageVo], toSection: previousTimeSection)
                    }
                }
            }
           
        }
        
        dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    func updateSnapshot(datas: [MessageVo], animatingDifferences: Bool = true) {
        var snapshot = dataSource.snapshot()
        snapshot.reloadItems(datas)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func timestampToDateString(timestamp: Int) -> String {
        let timeInterval: TimeInterval = TimeInterval(timestamp/1000)
        let date = Date(timeIntervalSince1970: timeInterval)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
}

extension UIDiffTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if dataSource.snapshot().sectionIdentifiers.isEmpty {
            return nil
        }
        let headView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 20.0))
        let lab = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 20.0))
        let sectionIdentifier = dataSource.snapshot().sectionIdentifiers[section]
        var title = ""
        switch sectionIdentifier {
        case .specificDate(let dateString):
            title = timestampToDateString(timestamp: dateString)
        }
        lab.text = title
        lab.backgroundColor = UIColor.red
        lab.textAlignment = .center
        
        headView.addSubview(lab)
        lab.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        return headView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionIdentifier = dataSource.snapshot().sectionIdentifiers[section]
        switch sectionIdentifier {
        case .specificDate(let dateString):
            return timestampToDateString(timestamp: dateString)
        }
    }
}
