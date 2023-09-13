//
//  UIKitExtension.swift
//  RickAndMortyZaraUIKit
//
//  Created by Lucas Romero Magaña on 12/9/23.
//

import Foundation
import UIKit

extension UIView {
    func makeCircle() {
        layer.cornerRadius = frame.height / 2.0
    }
}

protocol Nibbable: AnyObject {
    var view: UIView! { get set }
}

extension Nibbable where Self: UIView {
    func viewFromNib() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]

        addSubview(view)
    }

    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
            else {
                fatalError("Could not load view with type " + String(describing: type(of: self)))
        }
        return view
    }
}
