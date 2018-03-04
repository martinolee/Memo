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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
