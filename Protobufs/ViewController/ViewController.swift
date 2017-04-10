//
//  ViewController.swift
//  Protobufs
//
//  Created by Joshua Sullivan on 4/3/17.
//  Copyright © 2017 The Nerdery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var responseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sendTapped(sender: AnyObject?) {
        guard
            let message = inputField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
            !message.isEmpty
        else {
            return
        }
        APIService.shared.send(message: message) {
            [weak self]
            result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let returnMessage):
                strongSelf.responseLabel.text = returnMessage
            case .failure(let optError):
                if let error = optError {
                    strongSelf.responseLabel.text = "ERROR: \(error.localizedDescription)"
                    return
                }
                strongSelf.responseLabel.text = "UNKOWN ERROR"
            }
        }
    }

}

