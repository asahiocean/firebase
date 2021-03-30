import Foundation
import UIKit

@objc extension EmailAuthViewController {
    private func mainStackPosition(userInfo: [AnyHashable : Any]?, show: Bool) {
        guard let info = userInfo else { fatalError() }
        guard let keyboardDurationNumber = info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber, let keyboardCurveNumber = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber, let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else { return }
        let duration = keyboardDurationNumber.doubleValue
        let keyboardRect = keyboardFrame.cgRectValue
        let point = (view.bounds.height - keyboardRect.height) - view.center.y
        
        UIView.animate(withDuration: duration, delay: 0, options: [.allowUserInteraction, .init(rawValue: keyboardCurveNumber.uintValue)], animations: { [self] in
            mainViewCenterYConstraint?.constant = show ? -(point / 2) : 0
            view.layoutIfNeeded()
        })
    }
    
    private func keyboardWillShow(_ notification: Notification) {
        mainStackPosition(userInfo: notification.userInfo, show: true)
    }
    
    private func keyboardWillHide(_ notification: Notification) {
        mainStackPosition(userInfo: notification.userInfo, show: false)
    }
    
    func keyboardVisibilityObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
