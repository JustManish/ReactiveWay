//
//  CollectionViewExtension.swift
//  HotshotsLive
//
//  Created by iSHU on 28/07/20.
//  Copyright © 2020 iSHU. All rights reserved.
//

import UIKit

extension UICollectionView {

    func setNoDataMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont.systemFont(ofSize: 20.0)
        messageLabel.sizeToFit()
        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}

extension UITableView {

    func setNoDataMessage(_ message: String) {
        DispatchQueue.main.async {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            messageLabel.text = message
            messageLabel.textColor = .black
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont.systemFont(ofSize: 20.0)
            messageLabel.sizeToFit()
            self.backgroundView = messageLabel;
        }
    }

    func restore() {
        DispatchQueue.main.async {
            self.backgroundView = nil
        }
    }
}
extension Double {
    var clean: String {
        return String(format: "%.2f", self)
     }
}
