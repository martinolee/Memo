//
//  ViewController.swift
//  ThirdMemo
//
//  Created by 이수한 on 2018. 3. 4..
//  Copyright © 2018년 이수한. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    var list = [MemoEntity]()
    
    lazy var df: DateFormatter = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .none
        
        return f
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        listTableView.estimatedRowHeight = 100
        listTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func fetchMemo() {
        list.removeAll()
        
        let request = NSFetchRequest<MemoEntity>(entityName: "Memo")
        
        let sortByDate = NSSortDescriptor(key: "insertDate", ascending: false)
        let sortByTitle = NSSortDescriptor(key: "title", ascending: true)
        
        request.sortDescriptors = [sortByDate, sortByTitle]
        
        do {
            let list = try context.fetch(request)
            self.list = list
            
            listTableView.reloadData()
        } catch {
            show(message: error.localizedDescription)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case .some("detailSegue"):
            if let vc = segue.destination as? DetailViewController, let cell = sender as? UITableViewCell, let indexPath = listTableView.indexPath(for: cell) {
                vc.memo = list[indexPath.row]
            }
        default:
            super.prepare(for: segue, sender: sender)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchMemo()
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier) as! MemoTableViewCell
        
        let target = list[indexPath.row]
        
        cell.memoTitleLabel.text = target.title
        
        if let content = target.content, content.count > 200 {
            let to = content.index(content.startIndex, offsetBy: 200)
            cell.memoContentLabel.text = "\(content[..<to])..."
        } else {
            cell.memoContentLabel.text = target.content
        }
        
        cell.memoDateLabel.text = df.string(for: target.insertDate)
        
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate {
    
}
