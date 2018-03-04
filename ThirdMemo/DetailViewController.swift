//
//  DetailViewController.swift
//  ThirdMemo
//
//  Created by 이수한 on 2018. 3. 4..
//  Copyright © 2018년 이수한. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var memo: MemoEntity?
    
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = memo?.title
        contentTextView.text = memo?.content
        
        let df = DateFormatter()
        df.dateStyle = .medium
        df.timeStyle = .none
        
        dateLabel.text = df.string(for: memo?.insertDate)
    }
    
    @IBAction func confirmDelete(_ sender: Any) {
        let alert = UIAlertController(title: "삭제", message: "삭제 하시겠습니까?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "삭제", style: .destructive) { (action) in
            self.deleteMemo()
        }
        alert.addAction(ok)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func deleteMemo() {
        if let target = memo {
            context.delete(target)
        }
        
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            show(message: error.localizedDescription)
        }
    }
    
}


















