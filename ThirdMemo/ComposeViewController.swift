//
//  ComposeViewController.swift
//  ThirdMemo
//
//  Created by 이수한 on 2018. 3. 4..
//  Copyright © 2018년 이수한. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        guard let ad = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        return ad.persistentContainer.viewContext
    }
    
    func show(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}

class ComposeViewController: UIViewController {
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var contentField: UITextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        guard let title = titleField.text, title.count > 0 else {
            show(message: "제목을 입력하세요.")
            return
        }
        
        guard let content = contentField.text, content.count > 0 else {
            show(message: "내용을 입력하세요.")
            return
        }
        
        if let newMemo = NSEntityDescription.insertNewObject(forEntityName: "Memo", into: context) as? MemoEntity {
            newMemo.title = title
            newMemo.content = content
            newMemo.insertDate = Date()
        }
        
        do {
            try context.save()
            dismiss(animated: true, completion: nil)
        } catch {
            show(message: error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { [weak self] (noti) in
            if let value = noti.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                let frame = value.cgRectValue
                self?.bottomConstraint.constant = frame.height + 20
                
                UIView.animate(withDuration: 0.3, animations: {
                    self?.view.layoutIfNeeded()
                })
            }
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { [weak self] (noti) in
            self?.bottomConstraint.constant = 20
            
            UIView.animate(withDuration: 0.3, animations: {
                self?.view.layoutIfNeeded()
            })
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if titleField.isFirstResponder {
            titleField.resignFirstResponder()
        }
        
        if contentField.isFirstResponder {
            titleField.resignFirstResponder()
        }
    }

}


























