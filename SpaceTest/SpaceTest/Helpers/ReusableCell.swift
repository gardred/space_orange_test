//
//  ReusableCell.swift
//  SpaceTest
//
//  Created by M1 Pro on 18.05.2025.
//

import UIKit

protocol ReusableCell: AnyObject {
    static var identifier: String { get }
}

extension ReusableCell where Self: UITableViewCell {
    static var identifier: String {
        String(describing: Self.self)
    }
}

extension UITableViewCell: ReusableCell { }
