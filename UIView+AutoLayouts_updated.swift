import UIKit

extension UIView {
    // MARK: - Adding views

    public func add(_ views: UIView...) {
        for view in views {
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
    }

    // MARK: - Helper types

    public enum Comparison {
        case equal, lessThanOrEqual, greaterThanOrEqual
    }

    public enum Boundary {
        case view, safeArea, margin, readableContentGuide
    }

    public enum XEdge {
        case leading, trailing
    }

    public enum YEdge {
        case top, bottom
    }

    // MARK: - Fill

    @discardableResult
    public func constrainFill(
        to view: UIView? = nil,
        boundary: Boundary = .view,
        insets: UIEdgeInsets = .zero,
        priority: UILayoutPriority? = nil,
        active: Bool = true
    ) -> [NSLayoutConstraint] {
        [
            constrainTop(to: view, boundary: boundary, inset: insets.top, priority: priority, active: active),
            constrainBottom(to: view, boundary: boundary, inset: insets.bottom, priority: priority, active: active),
            constrainLeading(to: view, boundary: boundary, inset: insets.left, priority: priority, active: active),
            constrainTrailing(to: view, boundary: boundary, inset: insets.right, priority: priority, active: active)
        ]
    }

    @discardableResult
    public func constrainFillHorizontal(
        to view: UIView? = nil,
        boundary: Boundary = .view,
        leadingInset: CGFloat = 0.0,
        trailingInset: CGFloat = 0.0,
        priority: UILayoutPriority? = nil,
        active: Bool = true
    ) -> [NSLayoutConstraint] {
        [
            constrainLeading(to: view, boundary: boundary, inset: leadingInset, priority: priority, active: active),
            constrainTrailing(to: view, boundary: boundary, inset: trailingInset, priority: priority, active: active)
        ]
    }

    @discardableResult
    public func constrainFillHorizontal(
        to view: UIView? = nil,
        boundary: Boundary = .view,
        insets: CGFloat = 0.0,
        priority: UILayoutPriority? = nil,
        active: Bool = true
    ) -> [NSLayoutConstraint] {
        constrainFillHorizontal(to: view, boundary: boundary, leadingInset: insets, trailingInset: insets, priority: priority, active: active)
    }

    @discardableResult
    public func constrainFillVertical(
        to view: UIView? = nil,
        boundary: Boundary = .view,
        topInset: CGFloat = 0.0,
        bottomInset: CGFloat = 0.0,
        priority: UILayoutPriority? = nil,
        active: Bool = true
    ) -> [NSLayoutConstraint] {
        [
            constrainTop(to: view, boundary: boundary, inset: topInset, priority: priority, active: active),
            constrainBottom(to: view, boundary: boundary, inset: bottomInset, priority: priority, active: active)
        ]
    }

    @discardableResult
    public func constrainFillVertical(
        to view: UIView? = nil,
        boundary: Boundary = .view,
        insets: CGFloat = 0.0,
        priority: UILayoutPriority? = nil,
        active: Bool = true
    ) -> [NSLayoutConstraint] {
        constrainFillVertical(to: view, boundary: boundary, topInset: insets, bottomInset: insets, priority: priority, active: active)
    }

    // MARK: - Size

    @discardableResult
    public func constrain(to size: CGSize, comparison: Comparison = .equal, priority: UILayoutPriority? = nil, active: Bool = true) -> [NSLayoutConstraint] {
        [
            constrainWidth(to: size.width, comparison: comparison, priority: priority, active: active),
            constrainHeight(to: size.height, comparison: comparison, priority: priority, active: active)
        ]
    }

    @discardableResult
    public func constrainSquare(_ side: CGFloat, comparison: Comparison = .equal, priority: UILayoutPriority? = nil, active: Bool = true) -> [NSLayoutConstraint] {
        constrain(to: CGSize(width: side, height: side), comparison: comparison, priority: priority, active: active)
    }

    @discardableResult
    public func constrainWidth(to width: CGFloat, comparison: Comparison = .equal, priority: UILayoutPriority? = nil, active: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        let constraint: NSLayoutConstraint

        switch comparison {
        case .equal: constraint = widthAnchor.constraint(equalToConstant: width)
        case .lessThanOrEqual: constraint = widthAnchor.constraint(lessThanOrEqualToConstant: width)
        case .greaterThanOrEqual: constraint = widthAnchor.constraint(greaterThanOrEqualToConstant: width)
        }

        return constraint.priority(priority).active(active)
    }

    @discardableResult
    public func constrainHeight(to height: CGFloat, comparison: Comparison = .equal, priority: UILayoutPriority? = nil, active: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        let constraint: NSLayoutConstraint

        switch comparison {
        case .equal: constraint = heightAnchor.constraint(equalToConstant: height)
        case .lessThanOrEqual: constraint = heightAnchor.constraint(lessThanOrEqualToConstant: height)
        case .greaterThanOrEqual: constraint = heightAnchor.constraint(greaterThanOrEqualToConstant: height)
        }

        return constraint.priority(priority).active(active)
    }

    @discardableResult
    public func constrainWidth(to view: UIView, ratio: CGFloat = 1.0, constant: CGFloat = 0.0, comparison: Comparison = .equal, priority: UILayoutPriority? = nil, active: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        let constraint: NSLayoutConstraint

        switch comparison {
        case .equal: constraint = widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: ratio, constant: constant)
        case .lessThanOrEqual: constraint = widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: ratio, constant: constant)
        case .greaterThanOrEqual: constraint = widthAnchor.constraint(greaterThanOrEqualTo: view.widthAnchor, multiplier: ratio, constant: constant)
        }

        return constraint.priority(priority).active(active)
    }

    @discardableResult
    public func constrainHeight(to view: UIView, ratio: CGFloat = 1.0, constant: CGFloat = 0.0, comparison: Comparison = .equal, priority: UILayoutPriority? = nil, active: Bool = true) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false

        let constraint: NSLayoutConstraint

        switch comparison {
        case .equal: constraint = heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: ratio, constant: constant)
        case .lessThanOrEqual: constraint = heightAnchor.constraint(lessThanOrEqualTo: view.heightAnchor, multiplier: ratio, constant: constant)
        case .greaterThanOrEqual: constraint = heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor, multiplier: ratio, constant: constant)
        }

        return constraint.priority(priority).active(active)
    }

    @discardableResult
    public func constrainAspectRatio(to ratio: CGFloat, priority: UILayoutPriority? = nil, active: Bool = true) -> NSLayoutConstraint {
        widthAnchor.constraint(equalTo: heightAnchor, multiplier: ratio, constant: 0.0).priority(priority).active(active)
    }

    // MARK: - Center

    @discardableResult
    public func constrainCenter(to view: UIView? = nil, offset: CGPoint = .zero, priority: UILayoutPriority? = nil, active: Bool = true) -> [NSLayoutConstraint] {
        [
            constrainCenterX(to: view, offset: offset.x, priority: priority, active: active),
            constrainCenterY(to: view, offset: offset.y, priority: priority, active: active)
        ]
    }

    @discardableResult
    public func constrainCenterX(to view: UIView? = nil, offset: CGFloat = 0.0, priority: UILayoutPriority? = nil, active: Bool = true) -> NSLayoutConstraint {
        guard let view = view ?? superview else {
            assertionFailure("Tried to constrain a view without a superview.")
            return dummyConstraint()
        }

        translatesAutoresizingMaskIntoConstraints = false
        return centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: offset).priority(priority).active(active)
    }

    @discardableResult
    public func constrainCenterY(to view: UIView? = nil, offset: CGFloat = 0.0, priority: UILayoutPriority? = nil, active: Bool = true) -> NSLayoutConstraint {
        guard let view = view ?? superview else {
            assertionFailure("Tried to constrain a view without a superview.")
            return dummyConstraint()
        }

        translatesAutoresizingMaskIntoConstraints = false
        return centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: offset).priority(priority).active(active)
    }

    // MARK: - Top

    @discardableResult
    public func constrainTop(
        to view: UIView? = nil,
        at edge: YEdge = .top,
        comparison: Comparison = .equal,
        boundary: Boundary = .view,
        inset: CGFloat = 0.0,
        priority: UILayoutPriority? = nil,
        active: Bool = true
    ) -> NSLayoutConstraint {
        guard let view = view ?? superview else {
            assertionFailure("Tried to constrain a view without a superview.")
            return dummyConstraint()
        }

        translatesAutoresizingMaskIntoConstraints = false

        let anchor = view.anchor(at: edge, boundary: boundary)
        let constraint: NSLayoutConstraint

        switch comparison {
        case .equal: constraint = topAnchor.constraint(equalTo: anchor, constant: inset)
        case .lessThanOrEqual: constraint = topAnchor.constraint(lessThanOrEqualTo: anchor, constant: inset)
        case .greaterThanOrEqual: constraint = topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: inset)
        }

        return constraint.priority(priority).active(active)
    }

    // MARK: - Bottom

    @discardableResult
    public func constrainBottom(
        to view: UIView? = nil,
        at edge: YEdge = .bottom,
        comparison: Comparison = .equal,
        boundary: Boundary = .view,
        inset: CGFloat = 0.0,
        priority: UILayoutPriority? = nil,
        active: Bool = true
    ) -> NSLayoutConstraint {
        guard let view = view ?? superview else {
            assertionFailure("Tried to constrain a view without a superview.")
            return dummyConstraint()
        }

        translatesAutoresizingMaskIntoConstraints = false

        let anchor = view.anchor(at: edge, boundary: boundary)
        let constraint: NSLayoutConstraint

        // Note: The self-to-parent relationship is inverted here to maintain inset semantics when
        // the constant is adjusted after creation.
        switch comparison {
        case .equal: constraint = anchor.constraint(equalTo: bottomAnchor, constant: inset)
        case .lessThanOrEqual: constraint = anchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: inset)
        case .greaterThanOrEqual: constraint = anchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: inset)
        }

        return constraint.priority(priority).active(active)
    }

    // MARK: - Leading

    @discardableResult
    public func constrainLeading(
        to view: UIView? = nil,
        at edge: XEdge = .leading,
        comparison: Comparison = .equal,
        boundary: Boundary = .view,
        inset: CGFloat = 0.0,
        priority: UILayoutPriority? = nil,
        active: Bool = true
    ) -> NSLayoutConstraint {
        guard let view = view ?? superview else {
            assertionFailure("Tried to constrain a view without a superview.")
            return dummyConstraint()
        }

        translatesAutoresizingMaskIntoConstraints = false

        let anchor = view.anchor(at: edge, boundary: boundary)
        let constraint: NSLayoutConstraint

        switch comparison {
        case .equal: constraint = leadingAnchor.constraint(equalTo: anchor, constant: inset)
        case .lessThanOrEqual: constraint = leadingAnchor.constraint(lessThanOrEqualTo: anchor, constant: inset)
        case .greaterThanOrEqual: constraint = leadingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: inset)
        }

        return constraint.priority(priority).active(active)
    }

    // MARK: - Trailing

    @discardableResult
    public func constrainTrailing(
        to view: UIView? = nil,
        at edge: XEdge = .trailing,
        comparison: Comparison = .equal,
        boundary: Boundary = .view,
        inset: CGFloat = 0.0,
        priority: UILayoutPriority? = nil,
        active: Bool = true
    ) -> NSLayoutConstraint {
        guard let view = view ?? superview else {
            assertionFailure("Tried to constrain a view without a superview.")
            return dummyConstraint()
        }

        translatesAutoresizingMaskIntoConstraints = false

        let anchor = view.anchor(at: edge, boundary: boundary)
        let constraint: NSLayoutConstraint

        // Note: The self-to-parent relationship is inverted here to maintain inset semantics when
        // the constant is adjusted after creation.
        switch comparison {
        case .equal: constraint = anchor.constraint(equalTo: trailingAnchor, constant: inset)
        case .lessThanOrEqual: constraint = anchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: inset)
        case .greaterThanOrEqual: constraint = anchor.constraint(greaterThanOrEqualTo: trailingAnchor, constant: inset)
        }

        return constraint.priority(priority).active(active)
    }

    // MARK: - Dummy constraint

    private func dummyConstraint() -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        return widthAnchor.constraint(equalTo: widthAnchor)
    }
}

// MARK: - Helpers

private extension NSLayoutConstraint {
    // Small helpers to simplify the above implementations:

    func active(_ active: Bool) -> NSLayoutConstraint {
        self.isActive = active
        return self
    }

    func priority(_ priority: UILayoutPriority?) -> NSLayoutConstraint {
        if let priority = priority {
            self.priority = priority
        }

        return self
    }
}

private extension UIView {
    private func anchor(at edge: XEdge, boundary: Boundary) -> NSLayoutXAxisAnchor {
        switch (edge, boundary) {
        case (.leading, .safeArea): return safeAreaLayoutGuide.leadingAnchor
        case (.trailing, .safeArea): return safeAreaLayoutGuide.trailingAnchor
        case (.leading, .margin): return layoutMarginsGuide.leadingAnchor
        case (.trailing, .margin): return layoutMarginsGuide.trailingAnchor
        case (.leading, .readableContentGuide): return readableContentGuide.leadingAnchor
        case (.trailing, .readableContentGuide): return readableContentGuide.trailingAnchor
        case (.leading, .view): return leadingAnchor
        case (.trailing, .view): return trailingAnchor
        }
    }

    private func anchor(at edge: YEdge, boundary: Boundary) -> NSLayoutYAxisAnchor {
        switch (edge, boundary) {
        case (.top, .safeArea): return safeAreaLayoutGuide.topAnchor
        case (.bottom, .safeArea): return safeAreaLayoutGuide.bottomAnchor
        case (.top, .margin): return layoutMarginsGuide.topAnchor
        case (.bottom, .margin): return layoutMarginsGuide.bottomAnchor
        case (.top, .readableContentGuide): return readableContentGuide.topAnchor
        case (.bottom, .readableContentGuide): return readableContentGuide.bottomAnchor
        case (.top, .view): return topAnchor
        case (.bottom, .view): return bottomAnchor
        }
    }
}
