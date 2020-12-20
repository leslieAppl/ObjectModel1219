//
//  IBMessageBox.swift
//  ObjectModel1219
//
//  Created by leslie on 12/19/20.
//

import UIKit

class IBMessageBoxDismiss: NSObject {
    
    fileprivate var messageBox: UIAlertController
    fileprivate var parentViewController: UIViewController
    
    init(parentViewController: UIViewController) {
        
        self.parentViewController = parentViewController
        self.messageBox = UIAlertController(title: "", message: "", preferredStyle: .alert)
        self.messageBox.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
    }
    
    convenience init(parentViewController: UIViewController, title: String, message: String) {
        
        self.init(parentViewController: parentViewController)
        messageBox.title = title
        messageBox.message = message
    }
    
    func display() -> Bool {
        
        if messageBox.message != "" && messageBox.title != "" {
            
            parentViewController.present(messageBox, animated: true, completion: nil)
            return true
        }
        else {
            return false
        }
    }
    
    func display(title: String, message:String) -> Bool {
        
        if message != "" && title != "" {
            messageBox.message = message
            messageBox.title = title
            parentViewController.present(messageBox, animated: true, completion: nil)
            return true
        }
        else {
            return false
        }
    }
    
    func getTitle() -> String {
        
        if let title = messageBox.title {
            print("IBMessageBoxDismiss: \(title)")
            return title
        }
        else {
            return ""
        }
    }
    
    func makeRightmostButtonPreferred() -> Void {
        
        let lastActionIndex = messageBox.actions.count - 1
        messageBox.preferredAction = messageBox.actions[lastActionIndex]
        
    }
    
}

class IBMessageBoxDismissAndOK: IBMessageBoxDismiss {
    
    fileprivate var onOKTapAction: (UIAlertAction) -> Void
    
    init(parentViewController: UIViewController, completionClosure: @escaping (UIAlertAction) -> Void, makesChanges: Bool) {
        
        onOKTapAction = completionClosure
        
        // BE CAREFUL TO INITIALIZE THIS CLASS'S MEMBER PROPERTIES <<<BEFORE>>> CALLING super.init;
        // otherwise you'll get error "IBMessageBox.swift:... Property 'self.onOKTapAction' not initialized at super.init call"
        super.init(parentViewController: parentViewController)
        
        if makesChanges {
            
            self.messageBox.addAction(UIAlertAction(title: "OK", style: .destructive, handler: completionClosure))
        }
        else {
            
            self.messageBox.addAction(UIAlertAction(title: "OK", style: .default, handler: completionClosure))
        }
    }
    
    convenience init(parentViewController: UIViewController, title: String, message: String, completionClosure: @escaping (UIAlertAction) -> Void, makesChanges: Bool) {
        
        self.init(parentViewController: parentViewController, completionClosure: completionClosure, makesChanges: makesChanges)
        
        messageBox.title = title
        
        messageBox.message = message
    }
    
    override func getTitle() -> String {
        
        let title = super.getTitle()
        print("IBMessageBoxDismiss: \(title)")
        return title
    }
}

// quick way of accessing the text typed into the message box's textfield
var capturedTextField: UITextField?

class IBMessageBoxDismissAndOKWithTextField: IBMessageBoxDismissAndOK {
    
    init(parentViewController: UIViewController, title: String, message: String, completionClosure: @escaping (UIAlertAction) -> Void, makesChanges: Bool) {
        
        super.init(parentViewController: parentViewController, completionClosure: completionClosure, makesChanges: makesChanges)
        
        messageBox.title = title
        
        messageBox.message = message
        
        messageBox.addTextField { (textField) in
            textField.keyboardType = .default
            textField.clearButtonMode = .always
            capturedTextField = self.messageBox.textFields![0]
        }
    }
    
    override func getTitle() -> String {
        
        let title = super.getTitle()
        print("IBMessageBoxDismissAndOK: \(title)")
        return title
    }
}

