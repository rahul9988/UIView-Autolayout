import XCTest

import Loop

final class UIViewAutolayoutTests: XCTestCase {
    let superview = UIView()
    let view = UIView()

    override func setUp() {
        super.setUp()
        superview.add(view)
    }

    func testDisablesTranslatesAutoresizingMaskWhenAdded() {
        XCTAssertFalse(view.translatesAutoresizingMaskIntoConstraints)
    }

    func testAspectRatioConstraints() {
        let constraint = view.constrainAspectRatio(to: 0.5, priority: .defaultHigh, active: false)
        XCTAssert(constraint.firstItem === view)
        XCTAssert(constraint.secondItem === view)
        XCTAssertEqual(constraint.firstAttribute, .width)
        XCTAssertEqual(constraint.secondAttribute, .height)
        XCTAssertEqual(constraint.multiplier, 0.5)
        XCTAssertFalse(constraint.isActive)
        XCTAssertEqual(constraint.priority, .defaultHigh)
    }

    func testVerticalFillConstraints() {
        let constraints = view.constrainFillVertical(insets: 20.0)
        let topConstraint = constraints[0]
        let bottomConstraint = constraints[1]

        XCTAssert(topConstraint.firstItem === view)
        XCTAssert(bottomConstraint.firstItem === superview)

        XCTAssert(topConstraint.secondItem === superview)
        XCTAssert(bottomConstraint.secondItem === view)

        XCTAssertEqual(topConstraint.firstAttribute, .top)
        XCTAssertEqual(bottomConstraint.firstAttribute, .bottom)

        XCTAssertEqual(topConstraint.secondAttribute, .top)
        XCTAssertEqual(bottomConstraint.secondAttribute, .bottom)

        XCTAssert(topConstraint.isActive)
        XCTAssert(bottomConstraint.isActive)
    }

    func testCenterConstraints() {
        let constraints = view.constrainCenter(offset: CGPoint(x: 12.0, y: 16.0))
        let xConstraint = constraints[0]
        let yConstraint = constraints[1]

        XCTAssert(xConstraint.firstItem === view)
        XCTAssert(yConstraint.firstItem === view)

        XCTAssert(xConstraint.secondItem === superview)
        XCTAssert(yConstraint.secondItem === superview)

        XCTAssertEqual(xConstraint.firstAttribute, .centerX)
        XCTAssertEqual(yConstraint.firstAttribute, .centerY)

        XCTAssertEqual(xConstraint.secondAttribute, .centerX)
        XCTAssertEqual(yConstraint.secondAttribute, .centerY)

        XCTAssertEqual(xConstraint.constant, 12.0)
        XCTAssertEqual(yConstraint.constant, 16.0)

        XCTAssert(xConstraint.isActive)
        XCTAssert(yConstraint.isActive)
    }
}
