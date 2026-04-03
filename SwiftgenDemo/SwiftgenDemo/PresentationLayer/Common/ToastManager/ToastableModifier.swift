//
//  ToastableModifier.swift
//  SwiftgenDemo
//
//  Created by Roman Kovalchuk on 20.02.2026.
//

import SwiftUI
import PopupView

struct ToastableModifier: ViewModifier {
    @Bindable var toastManager: ToastManager

    init(toastManager: ToastManager) {
        self._toastManager = Bindable(toastManager)
    }

    func body(content: Content) -> some View {
        content.popup(
            item: $toastManager.toast,
            itemView: { toast in
                switch toast {
                case .error(let message):
                    ErrorToastView(error: message)
                    
                case .success(let message):
                    SuccessToastView(message: message)
                }
            },
            customize: { configuration in
                configuration
                    .type(
                        .floater(
                            verticalPadding: 16,
                            horizontalPadding: 16,
                            useSafeAreaInset: true
                        )
                    )
                    .position(.bottom)
            }
        )
    }
}
