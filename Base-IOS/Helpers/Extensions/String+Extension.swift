
import UIKit

extension String {
    var trimmingSpacesAndNewlines: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    var urlEncodingString: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
    
    var notificationName: Notification.Name {
        return Notification.Name(self)
    }

    var isNumber : Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    func matched(_ regex: String) -> Bool {
        return range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
    func standardUrlPath(withParams params: [String: Any]?) -> String {
        guard let myParams = params else { return self }
        
        var path = self + "?"
        for (key, value) in myParams {
            let valueStr = value as? String
            path += "\(key)=\(valueStr != nil ? valueStr!.urlEncodingString : value)&"
        }
        path = String(path.prefix(path.count - 1))
        return path
    }
    

}

// MARK: - Calculate text width, height

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font : font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
    
    func substring(from: Int, to: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        let end = index(start, offsetBy: to - from)
        return String(self[start ..< end])
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    var firstUppercased: String {
        return prefix(1).uppercased() + dropFirst()
    }
    var firstCapitalized: String {
        return String(prefix(1)).capitalized + dropFirst()
    }
    
    func removeBrace() -> String {
        return self.replacingOccurrences(of: "[", with: "").replacingOccurrences(of: "]", with: "").replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "").replacingOccurrences(of: "<", with: "").replacingOccurrences(of: ">", with: "").replacingOccurrences(of: "-", with: " ")
    }
}

extension NSMutableAttributedString {
    
    func underLineLbl(regex: String) -> NSMutableAttributedString {
        replaceStr(regex: regex)
        return self
    }
    
    func replaceStr(regex: String) {
        let regPattern = regex
        if let regex = try? NSRegularExpression(pattern: regPattern, options: []) {
            let matchesArray = regex.matches(in: self.string, options: [], range: NSRange(location: 0, length: self.length))
            if let match = matchesArray.first {
                let string = self.string.substring(from: match.range.lowerBound + 1, to: match.range.upperBound - 1)
                let attributedText = NSMutableAttributedString(string: string)
                attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedText.length))
                self.replaceCharacters(in: match.range, with: attributedText)
                self.replaceStr(regex: regPattern)
            }
        }
    }
}

extension String {
    subscript(value: CountableClosedRange<Int>) -> Substring? {
        get {
            guard let lowerBound = index(at: value.lowerBound),
                let upperBound = index(at: value.upperBound) else { return nil }

            return self[lowerBound...upperBound]
        }
    }

    subscript(value: CountableRange<Int>) -> Substring? {
        get {
            guard let lowerBound = index(at: value.lowerBound),
                let upperBound = index(at: value.upperBound) else { return nil }

            return self[lowerBound..<upperBound]
        }
    }

    subscript(value: PartialRangeUpTo<Int>) -> Substring? {
        get {
            guard let upperBound = index(at: value.upperBound) else { return nil }
            return self[..<upperBound]
        }
    }

    subscript(value: PartialRangeThrough<Int>) -> Substring? {
        get {
            guard let upperBound = index(at: value.upperBound) else { return nil }

            return self[...upperBound]
        }
    }

    subscript(value: PartialRangeFrom<Int>) -> Substring? {
        get {
            guard let lowerBound = index(at: value.lowerBound) else { return nil }
            return self[lowerBound...]
        }
    }

    func index(at offset: Int) -> String.Index? {
        return index(startIndex, offsetBy: offset, limitedBy: endIndex)
    }
}

//MARK: - get array word
extension String {
    func findArrayString(withRegex regex: String) -> [String] {
        let regPattern = regex
        var arrStr = [String]()
        if let regex = try? NSRegularExpression(pattern: regPattern, options: []) {
            let matchesArray = regex.matches(in: self, options: [], range: NSRange(location: 0, length: self.count))
            for item in matchesArray {
                let subStr = self.substring(from: item.range.lowerBound + 1, to: item.range.upperBound - 1)
                arrStr = subStr.components(separatedBy: ",")
            }
        }
        return arrStr
    }
    
    func replaceString(withRegex regex: String, by strValue: String) -> String {
        let regex = try! NSRegularExpression(pattern: regex, options: NSRegularExpression.Options.caseInsensitive)
        let range = NSMakeRange(0, self.count)
        if range.location != NSNotFound {
            return regex.stringByReplacingMatches(in: self, options: [], range: range, withTemplate: strValue)
        } else {
            return self
        }
    }
    
    func getUnderLineAttibuteString(withUnderLight strValue: String, color: UIColor? = nil) -> NSMutableAttributedString {
        let attStr = NSMutableAttributedString(string: self)
        let range = (self as NSString).range(of: strValue)
        if let underColor = color {
            attStr.addAttributes([.underlineStyle: 1, .underlineColor: underColor], range: range)
        } else {
            attStr.addAttributes([.underlineStyle: 1], range: range)
        }
        return attStr
    }
    
}

public extension String {
    
    var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }
    
    var stringByDeletingLastPathComponent: String {
        return (self as NSString).deletingLastPathComponent
    }
    
    var stringByDeletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    
    var pathComponents: [String] {
        return (self as NSString).pathComponents
    }
    
    func appendingPathComponent(_ path: String) -> String {
        let nsSt = self as NSString
        return nsSt.appendingPathComponent(path)
    }
    
    func appendingPathExtension(_ ext: String) -> String? {
        let nsSt = self as NSString
        return nsSt.appendingPathExtension(ext)
    }
    
    func matchesForRegexInText(_ regex: String!) -> [String] {
        do {
            let regEx = try NSRegularExpression(pattern: regex, options: NSRegularExpression.Options())
            let nsString = self as NSString
            let results: [NSTextCheckingResult] = regEx.matches(in: self, options: NSRegularExpression.MatchingOptions(), range: NSMakeRange(0, nsString.length))
            
            return results.map{ nsString.substring(with: $0.range)}
        } catch {
            return []
        }
    }
    
    func toNumber() -> NSNumber? {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.number(from: self)
    }
}

