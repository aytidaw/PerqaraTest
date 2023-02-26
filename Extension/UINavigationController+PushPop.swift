//
//  UINavigationController+PushPop.swift
//  PerqaraTest
//
//  Created by aditya  on 26/02/23.
//

import UIKit

extension UINavigationController {
    
    func pop(transitionType type: CATransitionType = .fade, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.popViewController(animated: false)
    }
    
    func push(viewController vc: UIViewController, transitionType type: CATransitionType = .fade, duration: CFTimeInterval = 0.3) {
        self.addTransition(transitionType: type, duration: duration)
        self.pushViewController(vc, animated: false)
    }
    
    private func addTransition(transitionType type: CATransitionType = .fade, duration: CFTimeInterval = 0.3) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.type = type
        self.view.layer.add(transition, forKey: nil)
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        self.pushViewController(viewController, animated: animated)
        self.callCompletion(animated: animated, completion: completion)
    }
    
    func popViewController(animated: Bool, completion: @escaping () -> Void) -> [UIViewController]? {
        let viewController = self.popToRootViewController(animated: animated)
        self.callCompletion(animated: animated, completion: completion)
        return viewController
    }
    
    private func callCompletion(animated: Bool, completion: @escaping () -> Void) {
        if animated, let coordinator = self.transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}
