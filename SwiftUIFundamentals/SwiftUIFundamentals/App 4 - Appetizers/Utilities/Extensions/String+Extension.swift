//
//  String+Extension.swift
//  SwiftUIFundamentals
//
//  Created by CallmeOni on 11/3/2568 BE.
//

import Foundation
import RegexBuilder

extension String {
    
    var isValidEmail: Bool {
        
        let emailRegex = Regex {
            OneOrMore {
                CharacterClass(
                    .anyOf("._%+-"),
                    ("A"..."Z"),
                    ("0"..."9"),
                    ("a"..."z")
                )
            }
            "@"
            OneOrMore {
                CharacterClass(
                    .anyOf("-"),
                    ("A"..."Z"),
                    ("a"..."z"),
                    ("0"..."9")
                )
            }
            "."
            Repeat(2...64) { // min 2, max 64 char
                CharacterClass(
                    ("A"..."Z"),
                    ("a"..."z")
                )
            }
        }
        
        return self.wholeMatch(of: emailRegex) !=  nil
    }
}
