//
//  DetailViewController.swift
//  ThirdMemo
//
//  Created by 이수한 on 2018. 3. 4..
//  Copyright © 2018년 이수한. All rights reserved.
//

import UIKit
import MessageUI

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
    
    @IBAction func sendEmail(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let composer = MFMailComposeViewController()
            composer.mailComposeDelegate = self
            
            if let subject = memo?.title {
                composer.setSubject(subject)
            }
            
            if let body = memo?.content {
                composer.setMessageBody(body, isHTML: false)
            }
        } else {
            show(message: "메일을 전송할 수 없습니다.")
        }
    }
    
    
}

extension DetailViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .sent:
            show(message: "전송되었습니다.")
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
}















