// Copyright (c) 2017-present Frédéric Maquin <fred@ephread.com> and contributors.
// Licensed under the terms of the MIT License.

import UIKit

extension UIView {

    public var isOutOfSuperview: Bool {
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return isOutOfSuperview(consideringInsets: insets)
    }

    public func isOutOfSuperview(consideringInsets insets: UIEdgeInsets) -> Bool {
        guard let superview = self.superview else {
            return true
        }

        let isInBounds = frame.origin.x >= insets.left && frame.origin.y >= insets.top
                         &&
                         (frame.origin.x + frame.size.width) <=
                         (superview.frame.size.width - insets.right)
                         &&
                         (frame.origin.y + frame.size.height) <=
                         (superview.frame.size.height - insets.bottom)

        return !isInBounds
    }

    public func fillSuperview(insets: UIEdgeInsets) {
        guard let superview = superview else {
            print(ErrorMessage.Warning.noParent)
            return
        }

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right)
        ])
    }

    public func fillSuperview() {
        fillSuperviewVertically()
        fillSuperviewHorizontally()
    }

    public func fillSuperviewVertically() {
        NSLayoutConstraint.activate(makeConstraintToFillSuperviewVertically())
    }

    public func fillSuperviewHorizontally() {
        NSLayoutConstraint.activate(makeConstraintToFillSuperviewHorizontally())
    }

    public func makeConstraintToFillSuperviewVertically() -> [NSLayoutConstraint] {
        guard let superview = superview else {
            print(ErrorMessage.Warning.noParent)
            return []
        }

        return [
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ]
    }

    public func makeConstraintToFillSuperviewHorizontally() -> [NSLayoutConstraint] {
        guard let superview = superview else {
            print(ErrorMessage.Warning.noParent)
            return []
        }

        return [
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor)
        ]
    }

    public func preparedForAutoLayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false

        return self
    }
}
