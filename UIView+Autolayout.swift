//
//  UIViewController+Extensions.swift
//  SearchController
//
//  Created by Rahul Dhiman on 28/02/19.
//  Copyright © 2019 Rahul Dhiman. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    func getTopSafeMargin() -> CGFloat {
        var top:CGFloat = 0.0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let topPadding = window?.safeAreaInsets.top
            let navHeight = self.navigationController?.navigationBar.frame.size.height ?? 0
            top = topPadding ?? 0
            top += navHeight
        }
        return top
    }
    func getBottomSafeMargin() -> CGFloat {
        var bottom:CGFloat = 0.0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.keyWindow
            let bottomPadding = window?.safeAreaInsets.bottom
            bottom = bottomPadding ?? 0
        }
        return bottom
    }
}
extension UIView {
    fileprivate
    func getSuperView(_ view:UIView?) -> UIView{
        var _withView = superview
        if superview == nil {assertionFailure("superView not found")}
        if view != nil {
            _withView = view
        }
        return _withView!
    }
    
    
    //MARK:  [ ↑ ]
    //
    @discardableResult
    func addTopMargin(_ const:CGFloat = 0.0, withView:UIView? = nil , relation:NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        let _withView = getSuperView(withView)
        self.translatesAutoresizingMaskIntoConstraints = false
        let top = NSLayoutConstraint(item: self,
                                     attribute: .top,
                                     relatedBy: relation,
                                     toItem: _withView,
                                     attribute: .top,
                                     multiplier: 1.0,
                                     constant: const)
        _withView.addConstraint(top)
        return top
    }
    
    //MARK:  [ ↓ ]
    //
    @discardableResult
    func addBottomMargin(_ const:CGFloat = 0.0, withView:UIView? = nil,
                         relation:NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        let _withView = getSuperView(withView)
        self.translatesAutoresizingMaskIntoConstraints = false
        let bottom = NSLayoutConstraint(item: self,
                                     attribute: .bottom,
                                     relatedBy: relation,
                                     toItem: _withView,
                                     attribute: .bottom,
                                     multiplier: 1.0,
                                     constant: -const)
        _withView.addConstraint(bottom)
        return bottom
    }
    
    //MARK: [ ← ]
    @discardableResult
    func addLeadingMargin(_ const:CGFloat = 0.0, withView:UIView? = nil,
                          relation:NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint  {
        let _withView = getSuperView(withView)
        self.translatesAutoresizingMaskIntoConstraints = false
        let leading = NSLayoutConstraint(item: self,
                                        attribute: .leading,
                                        relatedBy: relation,
                                        toItem: _withView,
                                        attribute: .leading,
                                        multiplier: 1.0,
                                        constant: const)
        _withView.addConstraint(leading)
        return leading
    }
    //MARK: [ ← ]
    @discardableResult
    func addTrailingMargin(_ const:CGFloat = 0.0, withView:UIView? = nil,
                           relation:NSLayoutConstraint.Relation = .equal)  -> NSLayoutConstraint{
        let _withView = getSuperView(withView)
        self.translatesAutoresizingMaskIntoConstraints = false
        let trailing = NSLayoutConstraint(item: self,
                                          attribute: .trailing,
                                          relatedBy: relation,
                                          toItem: _withView,
                                          attribute: .trailing,
                                          multiplier: 1.0,
                                          constant: -const)
        _withView.addConstraint(trailing)
        return trailing
    }
    
    //MARK: [trailing ⇆ leading]
    @discardableResult
    func addLeadingTo(view:UIView, const:CGFloat = 0.0,
                           relation:NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint  {
        self.translatesAutoresizingMaskIntoConstraints = false
       let cons = NSLayoutConstraint(item: self,
                           attribute: .leading,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .trailing,
                           multiplier: 1.0,
                           constant: const)
        cons.isActive = true
        return cons
    }
    //MARK: [leading ⇆ trailing]
    @discardableResult
    func addTrailingTo(view:UIView, const:CGFloat = 0.0,
                      relation:NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let cons = NSLayoutConstraint(item: self,
                           attribute: .trailing,
                           relatedBy: relation,
                           toItem: view,
                           attribute: .leading,
                           multiplier: 1.0,
                           constant: -const)
        cons.isActive = true
        return cons
    }
    @discardableResult
    func addTopTo(view:UIView, const:CGFloat = 0.0,
                      relation:NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let cons = NSLayoutConstraint(item: self,
                           attribute: .top,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .bottom,
                           multiplier: 1.0,
                           constant: const)
        cons.isActive = true
        return cons
    }
    @discardableResult
    func addBottomTo(view:UIView, const:CGFloat = 0.0,
                      relation:NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let cons = NSLayoutConstraint(item: self,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .top,
                           multiplier: 1.0,
                           constant: const)
        cons.isActive = true
        return cons
    }
    
    @discardableResult
    func addAllMargins(top:CGFloat = 0.0,
                     bottom:CGFloat = 0.0,
                     leading:CGFloat = 0.0,
                     trailing:CGFloat = 0.0,
                     withView:UIView? = nil)  -> [NSLayoutConstraint] {
        var ar = [NSLayoutConstraint]()
        ar.append( addTopMargin(top))
        ar.append(addBottomMargin(bottom))
        ar.append(addTrailingMargin(trailing))
        ar.append(addLeadingMargin(leading))
        return ar
    }
    
    @discardableResult
    func addWidth(_ width:CGFloat, height:CGFloat) -> [NSLayoutConstraint] {
        var ar = [NSLayoutConstraint]()
        ar.append(addHeightConstraint(height))
        ar.append(addWidthConstraint(width))
        return ar
    }
    @discardableResult
    func addHeightConstraint(_ const:CGFloat,relation:NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint{
        self.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint(item: self,
                                        attribute: .height,
                                        relatedBy: relation,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1.0,
                                        constant: const)
        height.isActive = true
        return height
    }
    @discardableResult
    func addWidthConstraint(_ const:CGFloat,relation:NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint{
        self.translatesAutoresizingMaskIntoConstraints = false
        let width = NSLayoutConstraint(item: self,
                                        attribute: .width,
                                        relatedBy: relation,
                                        toItem: nil,
                                        attribute: .notAnAttribute,
                                        multiplier: 1.0,
                                        constant: const)
        width.isActive = true
        return width
    }
    @discardableResult
    func addEqualWidthConstraint(_ const:CGFloat,
                                 withView:UIView,
                                 relation:NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let width = NSLayoutConstraint(item: self,
                                       attribute: .width,
                                       relatedBy: relation,
                                       toItem: withView,
                                       attribute: .width,
                                       multiplier: 1.0,
                                       constant: const)
        width.isActive = true
        return width
    }
    @discardableResult
    func addEqualHeightConstraint(_ const:CGFloat,
                                 withView:UIView,
                                 relation:NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let height = NSLayoutConstraint(item: self,
                                       attribute: .height,
                                       relatedBy: relation,
                                       toItem: withView,
                                       attribute: .height,
                                       multiplier: 1.0,
                                       constant: const)
        height.isActive = true
        return height
    }
    @discardableResult
    func addEqualWidthNdHeightConstraint(_ const:CGFloat,
                                  withView:UIView,
                                  relation:NSLayoutConstraint.Relation = .equal)
        -> [NSLayoutConstraint]
    {
        var ar = [NSLayoutConstraint]()
        ar.append(addEqualWidthConstraint(const, withView: withView))
        ar.append(addEqualHeightConstraint(const, withView: withView))
        return ar

    }

    @discardableResult
    func addCenterAlignX(_ withView:UIView? = nil,const:CGFloat = 0.0,
                         relation:NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint {
        let _withView = getSuperView(withView)
        let center = NSLayoutConstraint(item: self,
                                                    attribute: .centerX,
                                                    relatedBy: relation,
                                                    toItem: _withView,
                                                    attribute: .centerX,
                                                    multiplier: 1.0,
                                                    constant: const)
        center.isActive = true
        return center
    }
    @discardableResult
    func addCenterAlignY(_ withView:UIView? = nil,const:CGFloat = 0.0,
                         relation:NSLayoutConstraint.Relation = .equal) -> NSLayoutConstraint{
        let _withView = getSuperView(withView)
        let center = NSLayoutConstraint(item: self,
                                                    attribute: .centerY,
                                                    relatedBy: relation,
                                                    toItem: _withView,
                                                    attribute: .centerY,
                                                    multiplier: 1.0,
                                                    constant: const)
        center.isActive = true
        return center
    }
    @discardableResult
    func addCenterAlignXnY(_ withView:UIView? = nil) -> [NSLayoutConstraint] {
        var ar = [NSLayoutConstraint]()
        ar.append(self.addCenterAlignX(withView))
        ar.append(self.addCenterAlignY(withView))
        return ar
    }
    
}
