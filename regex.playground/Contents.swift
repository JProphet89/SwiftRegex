import RegexBuilder
import UIKit

let toParse = "Monday, June 6 2022 at 10:49am pretzel@gmail.com"

// MARK: - Literal Regex

let regexLiteral = /\w+,\s+\w+\s+\d+\s+\d+/

// MARK: - Using Regex Builder

let weekDay = Reference(Substring.self)
let refDate = Reference(Substring.self)

let regex = Regex {
    Capture {
        Capture(as: weekDay) {
            OneOrMore(.word)
        }
        ","
        OneOrMore(.whitespace)
        Capture(as: refDate){            
            OneOrMore(.word)
            OneOrMore(.whitespace)
            OneOrMore(.digit)
            OneOrMore(.whitespace)
            OneOrMore(.digit)
        }
    }
}.ignoresCase()

// MARK: - Results From literal

if let matches = toParse.firstMatch(of: regexLiteral) {
    let match = matches.output
    print(match)
}

// MARK: - Results From builder

if let matches = toParse.firstMatch(of: regex) {
    let match = matches.output
    /***
     To access more directly the fields we can use References in the capture
     */
    print(matches[weekDay]) //Should print "Monday"
    print(matches[refDate]) //Should print "June 6 2022"
}
