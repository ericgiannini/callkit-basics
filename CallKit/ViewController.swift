//
//  ViewController.swift
//  CallKit
//
//  Created by Floyd 2001 on 5/7/19.
//  Copyright © 2019 Agora.io. All rights reserved.
//

import UIKit
import CallKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        view.addSubview(buttonOutgoingCall)
        view.addSubview(buttonIncomingCall)
    }
    
    lazy var buttonIncomingCall: UIButton = {
        let buttonForCall = UIButton()
        buttonForCall.frame = CGRect(x:80, y: 100, width: 200, height: 60)
        buttonForCall.backgroundColor = UIColor.lightGray
        buttonForCall.setTitle("Incoming Call", for: .normal)
        buttonForCall.addTarget(self, action:#selector(incomingCall), for: .touchUpInside)
        return buttonForCall
    }()
    
    lazy var buttonOutgoingCall: UIButton = {
        let buttonForCall = UIButton()
        buttonForCall.frame = CGRect(x:80, y: 400, width: 200, height: 60)
        buttonForCall.backgroundColor = UIColor.lightGray
        buttonForCall.setTitle("Outgoing Call", for: .normal)
        buttonForCall.addTarget(self, action:#selector(outgoingCall), for: .touchUpInside)
        return buttonForCall
    }()

    @objc func incomingCall() {
        let provider = CXProvider(configuration: CXProviderConfiguration(localizedName: "My App"))
        provider.setDelegate(self, queue: nil)
        let controller = CXCallController()
        let transaction = CXTransaction(action: CXStartCallAction(call: UUID(), handle: CXHandle(type: .generic, value: "Hey I am calling you!")))
        controller.request(transaction, completion: { error in })
    }
    
    @objc func outgoingCall() {
        let provider = CXProvider(configuration: CXProviderConfiguration(localizedName: "My App"))
        provider.setDelegate(self, queue: nil)
        let controller = CXCallController()
        let transaction = CXTransaction(action: CXStartCallAction(call: UUID(), handle: CXHandle(type: .generic, value: "You are calling me!!!")))
        controller.request(transaction, completion: { error in })
    }
    
}

extension ViewController : CXProviderDelegate {
    
    func providerDidReset(_ provider: CXProvider) {
        }
    
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
            action.fulfill()
        }
    
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
            action.fulfill()
        }
    
}
