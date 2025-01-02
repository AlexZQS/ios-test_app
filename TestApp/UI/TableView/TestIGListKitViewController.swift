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

    init(pk: Int, name: String) {
        self.pk = pk
        self.name = name
    }

    func diffIdentifier() -> NSObjectProtocol {
        return pk as NSNumber
    }

    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let object = object as? Person else { return false }
        return self.name == object.name
    }

}

class TestIGListKitViewController: BaseViewController {
    
    lazy var adapter: ListAdapter = {
            return ListAdapter(updater: ListAdapterUpdater(), viewController: self, workingRangeSize: 1)
        }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        self.tableView.register(UINib.init(nibName: "TableViewCell2", bundle: nil), forCellReuseIdentifier: "userCell2")
        return tableView
    }()
    
    let oldPeople = [
            Person(pk: 1, name: "Kevin"),
            Person(pk: 2, name: "Mike"),
            Person(pk: 3, name: "Ann"),
            Person(pk: 4, name: "Jane"),
            Person(pk: 5, name: "Philip"),
            Person(pk: 6, name: "Mona"),
            Person(pk: 7, name: "Tami"),
            Person(pk: 8, name: "Jesse"),
            Person(pk: 9, name: "Jaed")
        ]
    
    let newPeople = [
        Person(pk: 2, name: "Mike"),
        Person(pk: 10, name: "Marne"),
        Person(pk: 5, name: "Philip"),
        Person(pk: 1, name: "Kevin"),
        Person(pk: 3, name: "Ryan"),
        Person(pk: 8, name: "Jesse"),
        Person(pk: 7, name: "Tami"),
        Person(pk: 4, name: "Jane"),
        Person(pk: 9, name: "Chen")
    ]
    
    lazy var people: [Person] = {
        return self.oldPeople
    }()
    
    var usingOldPeople = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(view.snp.topMargin)
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
