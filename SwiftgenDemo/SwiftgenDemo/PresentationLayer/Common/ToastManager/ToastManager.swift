//
//  ToastManager.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import SwiftUI

@Observable
class ToastManager {
    var toast: ToastData?
    
    init() {}
    
    func showToast(_ toast: ToastData, autoDismissDelay: TimeInterval = 2.5) {
        self.toast = toast
        
        DispatchQueue.main.asyncAfter(deadline: .now() + autoDismissDelay) { [weak self] in
            self?.toast = nil
        }
    }
}
