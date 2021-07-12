//
//  String+HTMLToString.swift
//  WorkoutListApp
//
//  Created by Pedro Enrique Trujillo Vargas on 7/10/21.
//

import Foundation
import UIKit

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func htmlToDynamicAttributedString(color:UIColor, font:UIFont) ->NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let ass = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html,
                                                                   .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            let attributedString = NSMutableAttributedString(string:ass.string, attributes:[
                .font:font,
                .foregroundColor:color,
            ])
            return attributedString
        } catch {
            return nil
        }
    }
}
