//
//  UILabel+Extension.swift
//  SteamGames
//
//  Created by ramil on 31.05.2023.
//

import UIKit

extension String {
    func htmlAttributedString(from string: String, size: CGFloat) -> NSAttributedString? {
        
        let content: String = "<!DOCTYPE html><html>" +
            "<head>" +
            "<meta charset='UTF-8'>" +
            "<style type='text/css'>" +
            "body {" +
            "margin: 0;" +
            "padding: 0;" +
            "}" +
            "img{" +
                "max-width: 100%;" +
                "max-height: 100%;" +
                "width: 100%;" +
                "height: 100%;" +
            "}" +
            "</style>" +
            "</head>" +
            "<body>\(string)</body></html>"
        
        if let htmlData = content.data(using: .utf8) {
            
            if let attributedString = try? NSAttributedString(
                data: htmlData,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil) {
                
                let paragraph = NSMutableParagraphStyle()
                paragraph.alignment = .left
                
                let formatted = NSMutableAttributedString(attributedString: attributedString)
                formatted.addAttributes([
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: size),
                    NSAttributedString.Key.foregroundColor: UIColor.label,
                    NSAttributedString.Key.paragraphStyle: paragraph
                    
                ], range: NSRange.init(location: 0, length: attributedString.length))
                
                return formatted
            }
        }
        return NSAttributedString(string: "")
    }
}
