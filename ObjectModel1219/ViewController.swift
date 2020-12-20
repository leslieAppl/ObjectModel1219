//
//  ViewController.swift
//  ObjectModel1219
//
//  Created by leslie on 12/19/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var outputConsole: UITextField!
    
    var messageBoxDismiss: IBMessageBoxDismiss?
    
    var messageBoxDismissAndOK: IBMessageBoxDismissAndOK?
    
    var onOKTapAction: ((UIAlertAction) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        messageBoxDismiss = IBMessageBoxDismiss(parentViewController: self)
        
        onOKTapAction =
        { _ in
            print("Message box OK tapped")
            self.outputConsole.text = "Message box OK tapped"
        }
        
        messageBoxDismissAndOK = IBMessageBoxDismissAndOK(parentViewController: self, completionClosure: onOKTapAction!, makesChanges: false)
        messageBoxDismissAndOK?.makeRightmostButtonPreferred()
    }

    @IBAction func showMessageBoxWithNoDefaultText(_ sender: Any) {
        
        if let success = messageBoxDismiss?.display() {
            
            print("IBMessageBoxDismiss shown (true/false)? - \(success)")
            outputConsole.text = "IBMessageBoxDismiss shown (true/false)? - \(success)"
            _ = messageBoxDismiss?.getTitle()
        }
    }
    
    @IBAction func showMsgBoxWithParams(_ sender: Any) {
        
        if let success = messageBoxDismiss?.display(title: "Title", message: "A description") {
            
            print("IBMessageBoxDismiss shown (true/false)? - \(success)")
            outputConsole.text = "IBMessageBoxDismiss shown (true/false)? - \(success)"
            _ = messageBoxDismiss?.getTitle()
        }
    }
    
    @IBAction func showMsgBoxWithNewText(_ sender: Any) {
        
        if let success = messageBoxDismiss?.display(title: "2nd Title", message: "A 2nd description") {
            
            print("IBMessageBoxDismiss shown (true/false)? - \(success)")
            outputConsole.text = "IBMessageBoxDismiss shown (true/false)? - \(success)"
            _ = messageBoxDismiss?.getTitle()
        }
    }
    
    @IBAction func showDismissOKMsgBoxWNoDefaultText(_ sender: Any) {
        
        if let success = messageBoxDismissAndOK?.display() {
            
            print("IBMessageBoxDismissAndOK shown (true/false)? - \(success)")
            outputConsole.text = "IBMessageBoxDismissAndOK shown (true/false)? - \(success)"
            _ = messageBoxDismissAndOK?.getTitle()
        }
    }
    
    @IBAction func showDisOKMsgBoxWithParams(_ sender: Any) {
        
        if let success = messageBoxDismissAndOK?.display(title: "Title", message: "A description") {
            
            print("IBMessageBoxDismissAndOK shown (true/false)? - \(success)")
            outputConsole.text = "IBMessageBoxDismissAndOK shown (true/false)? - \(success)"
            _ = messageBoxDismissAndOK?.getTitle()
        }
    }
    
    @IBAction func showDisOKMsgBoxWithNewText(_ sender: Any) {
        
        if let success = messageBoxDismissAndOK?.display(title: "2nd Title", message: "A 2nd description") {
            
            print("IBMessageBoxDismissAndOK shown (true/false)? - \(success)")
            outputConsole.text = "IBMessageBoxDismissAndOK shown (true/false)? - \(success)"
            _ = messageBoxDismissAndOK?.getTitle()
        }
    }
    
    @IBAction func shownStackDismissOKMsgBox(_ sender: Any) {
        
        let onOKTapAction: ((UIAlertAction) -> Void)? = { _ in
            
            print("Local IBMessageBoxDismissAndOK OK tapped")
            self.outputConsole.text = "Local IBMessageBoxDismissAndOK OK tapped"
        }
        
        let msgBoxDismissOKOnStack = IBMessageBoxDismissAndOK(parentViewController: self, title: "Local Message Box", message: "Created on Stack", completionClosure: onOKTapAction!, makesChanges: true)
        
        _ = msgBoxDismissOKOnStack.display()
        
        _ = msgBoxDismissOKOnStack.getTitle()
    }
    
    func reportMessageBoxText() -> Void {
        
        print("IBMessageBoxDismissAndOKWithTextField text: \((capturedTextField?.text)!)")
        outputConsole.text = "IBMessageBoxDismissAndOKWithTextField text: \((capturedTextField?.text)!)"
    }
    
    @IBAction func showStackDismissOKTextFieldMsgBox(_ sender: Any) {
        
        let onOKTapAction: ((UIAlertAction) -> Void)? = { _ in
            
            self.reportMessageBoxText()
        }
        
        let msgBoxDismissOKTextOnStack = IBMessageBoxDismissAndOKWithTextField(parentViewController: self, title: "Username", message: "Please enter username", completionClosure: onOKTapAction!, makesChanges: true)
        
        _ = msgBoxDismissOKTextOnStack.display()
        
        _ = msgBoxDismissOKTextOnStack.getTitle()
    }
}

