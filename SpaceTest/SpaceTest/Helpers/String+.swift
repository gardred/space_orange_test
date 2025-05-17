//
//  String+.swift
//  SpaceTest
//
//  Created by M1 Pro on 17.05.2025.
//

import Foundation

extension String {
    func formattedAsLongDate() -> String? {
         let isoFormatter = ISO8601DateFormatter()
         isoFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

         guard let date = isoFormatter.date(from: self) else {
             return nil
         }

         let formatter = DateFormatter()
         formatter.dateStyle = .long
         formatter.timeStyle = .none
         formatter.locale = Locale(identifier: "en_US")

         return formatter.string(from: date)
     }
}
