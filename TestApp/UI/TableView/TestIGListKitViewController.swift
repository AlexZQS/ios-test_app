//// 
//  TestIGListKitViewController.swift
//  TestApp
//  Created by ___ORGANIZATIONNAME___ on 2024/12/30
//  
//
//

import UIKit
import IGListKit


final class Person: ListDiffable {

    let pk: Int
    let name: String
    let content: String
    let time: String
    let sort: Int
    
    init (pk: Int, name: String, content: String, time: String,sort: Int) {
        self.pk = pk
        self.name = name
        self.content = content
        self.time = time
        self.sort = sort
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return pk as NSNumber
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Person else { return false }
        return self.name == object.name && self.content == object.content
    }

}

class TestIGListKitViewController: BaseViewController {
    
    lazy var adapter: ListAdapter = {
            return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 1)
        }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(UINib.init(nibName: "TableViewCell1", bundle: nil), forCellReuseIdentifier: "userCell")
        return tableView
    }()
    
    let oldPeople = [
        Person(pk: 1, name: "Kevin",content: "好舒服",time: "2024/11/30",sort:1),
        Person(pk: 2, name: "Mike",content: "哈哈",time: "2024/10/30",sort:2),
        Person(pk: 3, name: "Ann",content: "今天吃什么",time: "2024/9/30",sort:3),
        Person(pk: 4, name: "Jane",content: "不是这个意思",time: "2024/8/30",sort:4),
        Person(pk: 5, name: "Philip",content: "衣服多少钱",time: "2024/7/30",sort:5),
        Person(pk: 6, name: "Mona",content: "11111",time: "2024/6/30",sort:6),
        Person(pk: 7, name: "Tami",content: "下班啊",time: "2024/5/30",sort:7),
        Person(pk: 8, name: "Jesse",content: "起床",time: "2024/4/30",sort:8),
        Person(pk: 9, name: "Jaed",content: "水电费娇娥",time: "2024/3/30",sort:9)
        ]
    
    let newPeople = [
        Person(pk: 2, name: "Mike",content: "哈哈1",time: "2025/10/30",sort: 1),
        Person(pk: 10, name: "Marne",content: "今天周几",time: "2025/10/29",sort: 2),
        Person(pk: 5, name: "Philip",content: "不知道啊",time: "2025/10/28",sort: 3),
        Person(pk: 1, name: "Kevin",content: "api地址是多少",time: "2025/10/27",sort: 4),
        Person(pk: 3, name: "Ryan",content: "今天收入100",time: "2025/10/26",sort: 5),
        Person(pk: 8, name: "Jesse",content: "来一包中华",time: "2025/10/25",sort: 6),
        Person(pk: 7, name: "Tami",content: "mbp 16",time: "2025/10/24",sort: 7),
        Person(pk: 4, name: "Jane",content: "来来来",time: "2025/10/23",sort: 8),
        Person(pk: 9, name: "Chen",content: "滚滚滚",time: "2025/10/22",sort: 9)
    ]
    
    lazy var people: [Person] = {
        return self.oldPeople
    }()
    
    var usingOldPeople = true

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.tableView)
        // Do any additional setup after loading the view.
        self.tableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(view.snp.topMargin)
        }
        
        let popUpButton = UIButton.init(type: .system)
//      popUpButton.frame = CGRect.init(x: 100, y: 100, width: 100, height: 100)
        popUpButton.setTitle("Edit", for: .normal)
        popUpButton.showsMenuAsPrimaryAction = true
        popUpButton.menu = UIMenu(children: [
            UIAction(title: "update", handler: { action in
                self.update()
            }),
            
            UIAction(title: "move", handler: { action in
                self.move()
            }),
        ])

        let bar = UIBarButtonItem(customView: popUpButton)
        self.navigationItem.rightBarButtonItem = bar
    }
    
    func update() {
        let from = people
        var to = usingOldPeople ? newPeople : oldPeople
        usingOldPeople = !usingOldPeople
        to.sort { model1, model2 in
            model1.sort <= model2.sort
        }
        people = to
        
        let result = ListDiffPaths(fromSection: 0, toSection: 0, oldArray: from, newArray: to, option: .equality).forBatchUpdates()
        
        tableView.beginUpdates()
        tableView.deleteRows(at: result.deletes, with: .fade)
        tableView.insertRows(at: result.inserts, with: .fade)
        result.moves.forEach { tableView.moveRow(at: $0.from, to: $0.to) }
        tableView.endUpdates()
    }
    
    func move() {
        let from = people
        var newPeople = [
            Person(pk: 2, name: "Mike",content: "哈哈1",time: "2025/10/30",sort: 3),
            Person(pk: 10, name: "Marne",content: "今天周几",time: "2025/10/29",sort: 4),
            Person(pk: 5, name: "Philip",content: "不知道啊",time: "2025/10/28",sort: 1),
            Person(pk: 1, name: "Kevin",content: "api地址是多少",time: "2025/10/27",sort: 2),
            Person(pk: 3, name: "Ryan",content: "今天收入100",time: "2025/10/26",sort: 5),
            Person(pk: 8, name: "Jesse",content: "来一包中华",time: "2025/10/25",sort: 6),
            Person(pk: 7, name: "Tami",content: "mbp 16",time: "2025/10/24",sort: 7),
            Person(pk: 4, name: "Jane",content: "来来来",time: "2025/10/23",sort: 8),
            Person(pk: 9, name: "Chen",content: "滚滚滚",time: "2025/10/22",sort: 9)
        ]
        newPeople.sort { model1, model2 in
            model1.sort <= model2.sort
        }
        people = newPeople
        let result = ListDiffPaths(fromSection: 0, toSection: 0, oldArray: from, newArray: newPeople, option: .equality).forBatchUpdates()
        
        tableView.beginUpdates()
        tableView.deleteRows(at: result.deletes, with: .fade)
        tableView.insertRows(at: result.inserts, with: .fade)
        result.moves.forEach { tableView.moveRow(at: $0.from, to: $0.to) }
        tableView.endUpdates()
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

extension TestIGListKitViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "userCell") as? TableViewCell1
        
        if cell == nil {
            cell = TableViewCell1.init(style: .default, reuseIdentifier: "userCell")
        }
        let peopleItem = people[indexPath.row]
        
        print("set model 开始了，peopleItem:\(peopleItem.name) indexPath.row:\(indexPath.row)")
        cell?.mBodyView.text = peopleItem.content
        cell?.mTitleView.text = peopleItem.name
        cell?.mTimeView.text = peopleItem.time
        return cell!
    }
    
}
