//
//  StringUtility.swift
//  Brandi
//
//  Created by Ryan on 2016. 2. 1..
//  Copyright © 2016년 Brandi. All rights reserved.
//

import Foundation
import UIKit

open class StringUtility {
    static func truncateTailString(_ sourceString: String, maxLength: Int) -> String {
        var output: String = sourceString
        if output.count > maxLength {
            output.removeSubrange(output.index(output.endIndex, offsetBy: maxLength - output.count) ..< output.endIndex)
        }
        let lineBreaked = output.components(separatedBy: "\n")
        var finalOutput: String = ""
        for idx in 0 ..< lineBreaked.count {
            if idx < 2 {
                if idx != 0 {
                    finalOutput += "\n"
                }
                finalOutput += lineBreaked[idx]
            }
        }
        Logger.infoLog("final output: \(finalOutput)")
        return finalOutput
    }
    
    static func getAttStringWithRightImage(_ text: String, textColor: UIColor, image: UIImage, imageSize: CGSize) -> NSAttributedString {
        let attTitle = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: textColor])
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 2, y: -2, width: imageSize.width, height: imageSize.height)
        let attTitleImage = NSAttributedString(attachment: attachment)
        attTitle.append(attTitleImage)
        return attTitle
    }
    
    static func getAttStringWithRightImageOptionAddPrice(_ text: String, textColor: UIColor, textSize: CGFloat, image: UIImage?, imageSize: CGSize, addOptionPrice: String, addOptionPriceColor: UIColor) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2.0
        let attTitle = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: textSize, weight: .medium), NSAttributedString.Key.paragraphStyle: paragraphStyle])
        let attAddOption = NSMutableAttributedString(string: addOptionPrice, attributes: [NSAttributedString.Key.foregroundColor: addOptionPriceColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: textSize, weight: .medium)])
        if let image = image {
            let attSpace = NSAttributedString(string: " ")
            let attachment = NSTextAttachment()
            attachment.image = image
            attachment.bounds = CGRect(x: 0, y: -3, width: imageSize.width, height: imageSize.height)
            let attTitleImage = NSAttributedString(attachment: attachment)
            attTitle.append(attSpace)
            attTitle.append(attTitleImage)
            attTitle.append(attSpace)
        }
        attTitle.append(attAddOption)
        return attTitle
    }
    
    static func getAttStringWithRightImageProductDetail(_ text: String, textColor: UIColor, image: UIImage, imageSize: CGSize) -> NSAttributedString {
        let attTitle = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: textColor])
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 2, y: -4, width: imageSize.width, height: imageSize.height)
        let attTitleImage = NSAttributedString(attachment: attachment)
        attTitle.append(attTitleImage)
        return attTitle
    }
    
    static func getAttStringWithRightImageAtZero(_ text: String, textColor: UIColor, image: UIImage, imageSize: CGSize) -> NSAttributedString {
        let attTitle = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: textColor])
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
        let attTitleImage = NSAttributedString(attachment: attachment)
        attTitle.append(attTitleImage)
        return attTitle
    }
    
    static func getAttStringWithRightImageAtZeroBelow(_ text: String, textColor: UIColor, image: UIImage, imageSize: CGSize) -> NSAttributedString {
        let attTitle = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: textColor])
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 4, y: -4, width: imageSize.width, height: imageSize.height)
        let attTitleImage = NSAttributedString(attachment: attachment)
        attTitle.append(attTitleImage)
        return attTitle
    }
    
    static func getTimeStringFromLeftedTime(_ timeString: String) -> String {
        guard let leftTime: Int = Int(timeString) else { return "00:00:00" }
        var hhString = "00"
        var mmString = "00"
        var ssString = "00"
        let ssInt: Int = Int(leftTime%60)
        let mmInt: Int = Int(leftTime/60%60)
        let hhInt: Int = Int(leftTime/60/60)
        hhString = "\(hhInt)"
        mmString = "\(mmInt)"
        ssString = "\(ssInt)"
        if hhString.count < 2 {
            hhString = "0".appending(hhString)
        }
        if mmString.count < 2 {
            mmString = "0".appending(mmString)
        }
        if ssString.count < 2 {
            ssString = "0".appending(ssString)
        }
        let timeString: String = hhString.appending(":").appending(mmString).appending(":").appending(ssString)
        return timeString
    }
    
    static func getTimeStringFromTimeStamp(_ timeStamp: CLongLong) -> String {
        return StringUtility.getTimeStringFromTimeStamp(timeStamp, overrideTimeUnit: false)
    }
    
    static func getTimeStringFromTimeStamp(_ timeStamp: String?, overrideTimeUnit: Bool) -> String {
        if timeStamp == nil {
            return ""
        }
        if let timestring = CLongLong.init(timeStamp!) {
            return StringUtility.getTimeStringFromTimeStamp(timestring, overrideTimeUnit: overrideTimeUnit)
        } else {
            return ""
        }
    }
    
    static func getTimeStringFromTimeStamp(_ timeStamp: String?) -> String {
        return StringUtility.getTimeStringFromTimeStamp(timeStamp, overrideTimeUnit: false)
    }
    
    static func getDateFormatStringFromTimeStamp(_ timeStamp: String, format: String = "yyyy-MM-dd") -> String {
        return self.getDateFormatStringFromTimeStamp(timeStamp, format: format)
    }
    
    static func getDateFormatStringFromTimeStampWithSeconds(_ timeStamp: String) -> String {
        let format = "yyyy-MM-dd HH:mm:ss"
        return self.getDateFormatStringFromTimeStamp(timeStamp, format: format)
    }
    
    static func getDateFormatStringFromTimeStamp(_ timeStamp: String, format: String) -> String {
        if let time = TimeInterval(timeStamp) {
            let date = Date(timeIntervalSince1970: time)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            return dateFormatter.string(from: date)
        }
        return ""
    }
    
    static func getDayOfWeekString(_ timeStamp: String) -> String? {
        if let time = TimeInterval(timeStamp) {
            let date = Date(timeIntervalSince1970: time)
            let calendar = Calendar(identifier: .gregorian)
            let dayOfWeek = calendar.component(.weekday, from: date)
            let locale = SystemUtility.getLocale()
            switch dayOfWeek {
            case 1:
                if locale == .kor {
                    return "일요일"
                } else {
                    return "Sunday"
                }
            case 2:
                if locale == .kor {
                    return "월요일"
                } else {
                    return "Monday"
                }
            case 3:
                if locale == .kor {
                    return "화요일"
                } else {
                    return "Tuesday"
                }
            case 4:
                if locale == .kor {
                    return "수요일"
                } else {
                    return "Wednesday"
                }
            case 5:
                if locale == .kor {
                    return "목요일"
                } else {
                    return "Thursday"
                }
            case 6:
                if locale == .kor {
                    return "금요일"
                } else {
                    return "Friday"
                }
            case 7:
                if locale == .kor {
                    return "토요일"
                } else {
                    return "Saturday"
                }
            default:
                break
            }
        }
        return nil
    }
    
    static func isWeekDayFronString(_ timeStamp: String) -> Bool {
        if let time = TimeInterval(timeStamp) {
            let date = Date(timeIntervalSince1970: time)
            let calendar = Calendar(identifier: .gregorian)
            let dayOfWeek = calendar.component(.weekday, from: date)
            switch dayOfWeek {
            case 1, 7:
                return false
            default:
                return true
            }
        }
        return false
    }
    
//    static func getMaintenanceStringFrom(_ data: MaintenanceModel) -> (String) {
//        var start: String?
//        var end: String?
//        if data.start_time != nil && data.end_time != nil {
//            start = StringUtility.getDateFormatStringFromTimeStamp("\(data.start_time!)", format: ResourceDataStore.strings().STRING_TIMEFORMAT_WITH_UNIT)
//            end = StringUtility.getDateFormatStringFromTimeStamp("\(data.end_time!)", format: ResourceDataStore.strings().STRING_TIMEFORMAT_WITH_UNIT)
//        } else {
//            start = ""
//            end = ""
//        }
//        var message = ResourceDataStore.strings().STRING_ALERT_SERVER_MAINTENANCE_DATE
//        message = message.replacingOccurrences(of: ResourceDataStore.strings().STRING_ALERT_SERVER_MAINTENANCE_DATE_PLACEHOLDER_STARTDATE, with: start!)
//        message = message.replacingOccurrences(of: ResourceDataStore.strings().STRING_ALERT_SERVER_MAINTENANCE_DATE_PLACEHOLDER_ENDDATE, with: end!)
//        return message
//    }
//    
//    static func getMaintenanceDateString(from data: MaintenanceModel) -> String {
//        var start: String = ""
//        var end: String = ""
//        if let startTime = data.start_time, let endTime = data.end_time {
//            start = StringUtility.getDateFormatStringFromTimeStamp("\(startTime)", format: "YYYY.MM.dd HH:mm")
//            end = StringUtility.getDateFormatStringFromTimeStamp("\(endTime)", format: "YYYY.MM.dd HH:mm")
//            return "작업일시\n" + start + " ~ " + end
//        } else {
//            return "작업일시\n"
//        }
//    }
//    
//    static func getAttributedTextFromAlarmContent(_ alarmString: String, fontSize: CGFloat) -> NSAttributedString {
//        let regex = ResourceDataStore.policies().POLICY_REGEX_ALARM
//        let outputString = NSMutableAttributedString(string: alarmString)
//        do {
//            let matches = try NSRegularExpression(pattern: regex, options: .caseInsensitive).matches(in: alarmString, options: [], range: NSRange(location: 0, length: alarmString.count))
//            for match in matches {
//                let range = match.range
//                let font = UIFont.boldSystemFont(ofSize: fontSize)
//                outputString.addAttribute(NSAttributedString.Key.font, value: font, range: range)
//                outputString.addAttribute(NSAttributedString.Key.foregroundColor, value: ResourceDataStore.colors().COLOR_BRANDI_PRIMARY, range: range)
//            }
//            var tempBraces = [NSTextCheckingResult]()
//            let leftBraces = try NSRegularExpression(pattern: "\\{\\{", options: .caseInsensitive).matches(in: alarmString, options: [], range: NSRange(location: 0, length: outputString.length))
//            let rightBraces = try NSRegularExpression(pattern: "\\}\\}", options: .caseInsensitive).matches(in: alarmString, options: [], range: NSRange(location: 0, length: outputString.length))
//            tempBraces.append(contentsOf: leftBraces)
//            tempBraces.append(contentsOf: rightBraces)
//            let braces = tempBraces.sorted(
//                by: { (brace1: NSTextCheckingResult, brace2: NSTextCheckingResult) -> Bool in
//                    return brace1.range.location < brace2.range.location
//                }
//            )
//            let originalLength = outputString.length
//            var lengthReduced = 0
//            for brace in braces {
//                let range = NSRange(location: brace.range.location - lengthReduced, length: brace.range.length)
//                outputString.replaceCharacters(in: range, with: NSAttributedString(string: ""))
//                lengthReduced = originalLength - outputString.length
//            }
//            return outputString
//        } catch {
//            return outputString
//        }
//    }
//    
//    static func getAttributedStringFromCommerceContent(_ sourceString: String, fontSize: CGFloat, highlightColor: UIColor) -> NSAttributedString {
//        let regex = ResourceDataStore.policies().POLICY_REGEX_COMMERCE_FEED
//        let outputString = NSMutableAttributedString(string: sourceString)
//        do {
//            let matches = try NSRegularExpression(pattern: regex, options: .caseInsensitive).matches(in: sourceString, options: [], range: NSRange(location: 0, length: sourceString.count))
//            for match in matches {
//                let range = match.range
//                let subString = String(outputString.string.prefix(range.location))
////                    .substring(with: sourceString.index(sourceString.startIndex, offsetBy: range.location) ..< sourceString.index(sourceString.startIndex, offsetBy: range.location))
//                if subString.contains("%") {
//                    outputString.addAttribute(NSAttributedString.Key.foregroundColor, value: highlightColor, range: range)
//                } else {
//                    outputString.addAttributes([NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0, weight: .bold)], range: range)
//                }
//            }
//            var tempBraces = [NSTextCheckingResult]()
//            let leftBraces = try NSRegularExpression(pattern: "\\{", options: .caseInsensitive).matches(in: sourceString, options: [], range: NSRange(location: 0, length: outputString.length))
//            let rightBraces = try NSRegularExpression(pattern: "\\}", options: .caseInsensitive).matches(in: sourceString, options: [], range: NSRange(location: 0, length: outputString.length))
//            tempBraces.append(contentsOf: leftBraces)
//            tempBraces.append(contentsOf: rightBraces)
//            let braces = tempBraces.sorted(
//                by: { (brace1: NSTextCheckingResult, brace2: NSTextCheckingResult) -> Bool in
//                    return brace1.range.location < brace2.range.location
//                }
//            )
//            let originalLength = outputString.length
//            var lengthReduced = 0
//            for brace in braces {
//                let range = NSRange(location: brace.range.location - lengthReduced, length: brace.range.length)
//                outputString.replaceCharacters(in: range, with: NSAttributedString(string: ""))
//                lengthReduced = originalLength - outputString.length
//            }
//            return outputString
//        } catch {
//            return outputString
//        }
//    }
//    
//    static func getAttributedStringFromCommerceContentToAllBraces(_ sourceString: String, fontSize: CGFloat, highlightColor: UIColor, weight: UIFont.Weight) -> NSAttributedString {
//        let regex = ResourceDataStore.policies().POLICY_REGEX_COMMERCE_FEED
//        let outputString = NSMutableAttributedString(string: sourceString)
//        do {
//            let matches = try NSRegularExpression(pattern: regex, options: .caseInsensitive).matches(in: sourceString, options: [], range: NSRange(location: 0, length: sourceString.count))
//            for match in matches {
//                let range = match.range
//                outputString.addAttributes([NSAttributedString.Key.foregroundColor: highlightColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize, weight: weight)], range: range)
//            }
//            var tempBraces = [NSTextCheckingResult]()
//            let leftBraces = try NSRegularExpression(pattern: "\\{", options: .caseInsensitive).matches(in: sourceString, options: [], range: NSRange(location: 0, length: outputString.length))
//            let rightBraces = try NSRegularExpression(pattern: "\\}", options: .caseInsensitive).matches(in: sourceString, options: [], range: NSRange(location: 0, length: outputString.length))
//            tempBraces.append(contentsOf: leftBraces)
//            tempBraces.append(contentsOf: rightBraces)
//            let braces = tempBraces.sorted(
//                by: { (brace1: NSTextCheckingResult, brace2: NSTextCheckingResult) -> Bool in
//                    return brace1.range.location < brace2.range.location
//                }
//            )
//            let originalLength = outputString.length
//            var lengthReduced = 0
//            for brace in braces {
//                let range = NSRange(location: brace.range.location - lengthReduced, length: brace.range.length)
//                outputString.replaceCharacters(in: range, with: NSAttributedString(string: ""))
//                lengthReduced = originalLength - outputString.length
//            }
//            return outputString
//        } catch {
//            return outputString
//        }
//    }
//    
//    static func isValidInvitationCode(_ code: String) -> Bool {
//        Logger.infoLog("invitation code String received: \(code)")
//        let regex = ResourceDataStore.policies().POLICY_REGEX_NUMBER
//        return self.matches(regex, stringToMatch: code)
//    }
//    
//    static func isValidEmailFormatPart(_ string: String) -> Bool {
//        Logger.infoLog("email part String received: \(string)")
//        let regex = ResourceDataStore.policies().POLICY_REGEX_EMAIL_CHARACTER
//        return self.matches(regex, stringToMatch: string)
//    }
//    
//    static func isValidEmailFormat(_ email: String) -> Bool {
//        Logger.infoLog("email String received: \(email)")
//        let emailRegex = ResourceDataStore.policies().POLICY_REGEX_EMAIL
//        return self.matches(emailRegex, stringToMatch: email)
//    }
//    
//    static func isValidEmailFormat(_ email: String, withMessage: Bool) -> Bool {
//        let valid = self.isValidEmailFormat(email)
//        if !valid && withMessage {
//            SystemUtility.showGlobalNotificationMessagePopup(ResourceDataStore.strings().STRING_ALERT_EMAIL_NOT_VALID)
//        }
//        return valid
//    }
//    
//    static func isValidPasswordFormat(_ passwd: String) -> Bool {
//        return self.isValidPasswordFormat(passwd, withMessage: false)
//    }
//    
//    static func isValidPasswordFormat(_ passwd: String, withMessage: Bool) -> Bool {
//        Logger.infoLog("password String received: \(passwd)")
//        let min = ResourceDataStore.policies().POLICY_PASSWORD_STRING_MINLENGTH
//        let max = ResourceDataStore.policies().POLICY_PASSWORD_STRING_MAXLENGTH
//        let passwdRegex = "^.{\(min),\(max)}$"
//        var count: Int = 0
//        if self.regexMatches(passwdRegex, stringToMatch: passwd) {
//            let regexLc = ResourceDataStore.policies().POLICY_REGEX_PASSWORD_CHARACTER_LOWERCASE
//            let regexUc = ResourceDataStore.policies().POLICY_REGEX_PASSWORD_CHARACTER_UPPERCASE
//            let regexNum = ResourceDataStore.policies().POLICY_REGEX_PASSWORD_CHARACTER_NUMBERS
//            let regexSp = ResourceDataStore.policies().POLICY_REGEX_PASSWORD_CHARACTER_SPECIALS
//            if self.regexMatches(regexLc, stringToMatch: passwd) {
//                count += 1
//            }
//            if self.regexMatches(regexUc, stringToMatch: passwd) {
//                count += 1
//            }
//            if self.regexMatches(regexNum, stringToMatch: passwd) {
//                count += 1
//            }
//            if self.regexMatches(regexSp, stringToMatch: passwd) {
//                count += 1
//            }
//            if count >= 3 {
//                return true
//            } else {
//                if withMessage {
//                    SystemUtility.showGlobalNotificationMessagePopup(ResourceDataStore.strings().STRING_POLICY_REGEX_PASSWORD_PATTERN)
//                }
//                return false
//            }
//        } else {
//            if withMessage {
//                SystemUtility.showGlobalNotificationMessagePopup(ResourceDataStore.strings().STRING_POLICY_REGEX_PASSWORD_PATTERN)
//            }
//            return false
//        }
//    }
//    
//    static func isValidNicknameFormat(_ nickname: String) -> Bool {
//        Logger.infoLog("nickname String received: \(nickname)")
//        let nicknameRegex = ResourceDataStore.policies().POLICY_REGEX_NICKNAME
//        return self.matches(nicknameRegex, stringToMatch: nickname)
//    }
//    
//    static func isValidRealNameFormat(_ realName: String) -> Bool {
//        Logger.infoLog("realname String Received: \(realName)")
//        let realnameRegex = ResourceDataStore.policies().POLICY_REGEX_REALNAME
//        return self.matches(realnameRegex, stringToMatch: realName)
//    }
//    
//    static func isValidNumberFormat(_ number: String) -> Bool {
//        Logger.infoLog("cellNumber String Received: \(number)")
//        let numberRegex = ResourceDataStore.policies().POLICY_REGEX_NUMBER
//        return self.matches(numberRegex, stringToMatch: number)
//    }
//    
//    static func isValidQnaFormat(_ text: String) -> Bool {
//        Logger.infoLog("text String Received: \(text)")
//        let qnaRegex = ResourceDataStore.policies().POLICY_REGEX_QNA
//        return self.matches(qnaRegex, stringToMatch: text)
//    }
//    
//    static func getHashTagsFrom(_ text: String) -> [String] {
//        let hashtagRegex = ResourceDataStore.policies().POLICY_REGEX_HASHTAG
//        let newString = NSString(string: text)
//        var array: [String] = []
//        do {
//            let results = try NSRegularExpression(pattern: hashtagRegex, options: .caseInsensitive).matches(in: text, options: [], range: NSRange(location: 0, length: text.count))
//            for result in results {
//                array.append(String(newString.substring(with: result.range)).replacingOccurrences(of: "#", with: ""))
//            }
//            return array
//        } catch {
//            return array
//        }
//    }
    
    fileprivate static func regexMatches(_ pattern: String, stringToMatch: String) -> Bool {
        do {
            let matches = try NSRegularExpression(pattern: pattern, options: []).matches(in: stringToMatch, options: [], range: NSRange(location: 0, length: stringToMatch.count))
            if matches.count > 0 {
                return true
            }
        } catch {
            return false
        }
        return false
    }
    
    fileprivate static func matches(_ regex: String, stringToMatch: String) -> Bool {
        let confirmation = NSPredicate(format: "SELF MATCHES %@", regex)
        return confirmation.evaluate(with: stringToMatch)
    }
    
//    static func getLocalizedPriceFromProduct(_ item: ProductModelCV1) -> String {
//        let won = ResourceDataStore.strings().STRING_CURRENCY
//        let percent = "%"
//        let price = (CalculationUtility.convertPointIntoDecimalStringFormat(item.price))
//        let salePrice = (CalculationUtility.convertPointIntoDecimalStringFormat(item.sale_price))
//        if item.sale_percent == 0 {
//            return "\(salePrice)\(won)"
//        } else {
//            return "\(price)\(won) -> \(salePrice)\(won)(\(item.sale_percent)\(percent))"
//        }
//    }
//
//    static func getLocalizedPriceFromProduct(_ item: ProductModelCV1) -> NSAttributedString {
//        return self.getLocalizedPriceFromProduct(item, includeDeletedPrice: true, includePercent: true, deletedPriceColor: UIColor.black, salePriceColor: ResourceDataStore.colors().COLOR_BRANDI_RED, salePercentColor: ResourceDataStore.colors().COLOR_BRANDI_RED)
//    }
//
//    static func getLocalizedPriceFromProduct(_ item: ProductModelCV1, includeDeletedPrice: Bool, includePercent: Bool, deletedPriceColor: UIColor, salePriceColor: UIColor, salePercentColor: UIColor) -> NSAttributedString {
//        let won = ResourceDataStore.strings().STRING_CURRENCY
//        let percent = "%"
//        let price = (CalculationUtility.convertPointIntoDecimalStringFormat(item.price))
//        let salePrice = (CalculationUtility.convertPointIntoDecimalStringFormat(item.sale_price))
//        if item.sale_percent == 0 {
//            let source = "\(salePrice)\(won)"
//            let output = NSMutableAttributedString(string: source)
//            return output
//        } else {
//            let priceString = NSAttributedString(string: "\(price)\(won)", attributes: [NSAttributedString.Key.foregroundColor: deletedPriceColor, NSAttributedString.Key.strikethroughStyle: 1])
//            let salePriceString = NSAttributedString(string: "\(salePrice)\(won)", attributes: [NSAttributedString.Key.foregroundColor: salePriceColor])
//            let salePercentString = NSAttributedString(string: "(\(item.sale_percent)\(percent))", attributes: [NSAttributedString.Key.foregroundColor: salePercentColor])
//            let output = NSMutableAttributedString(string: "")
//            if includeDeletedPrice {
//                output.append(priceString)
//                output.append(NSAttributedString(string: "  "))
//            }
//            output.append(salePriceString)
//            if includePercent {
//                output.append(salePercentString)
//            }
//            return output
//        }
//    }
//
//    static func getLocalizedPriceFromProductWithoutWonForTagZoningProducts(_ item: ProductModelCV1, includeDeletedPrice: Bool, includePercent: Bool, deletedPriceColor: UIColor, salePriceColor: UIColor, salePercentColor: UIColor) -> NSAttributedString {
//        let percent = "%"
//        let price = (CalculationUtility.convertPointIntoDecimalStringFormat(item.price))
//        let salePrice = (CalculationUtility.convertPointIntoDecimalStringFormat(item.sale_price))
//        if item.sale_percent == 0 {
//            let source = "\(salePrice)"
//            let output = NSMutableAttributedString(string: source)
//            return output
//        } else {
//            let priceString = NSAttributedString(string: "\(price)", attributes: [NSAttributedString.Key.foregroundColor: deletedPriceColor, NSAttributedString.Key.strikethroughStyle: 1])
//            let salePriceString = NSAttributedString(string: "\(salePrice)", attributes: [NSAttributedString.Key.foregroundColor: salePriceColor])
//            let salePercentString = NSAttributedString(string: "(\(item.sale_percent)\(percent))", attributes: [NSAttributedString.Key.foregroundColor: salePercentColor])
//            let output = NSMutableAttributedString(string: "")
//            if includeDeletedPrice {
//                output.append(priceString)
//                output.append(NSAttributedString(string: "  "))
//            }
//            output.append(salePriceString)
//            if includePercent {
//                output.append(salePercentString)
//            }
//            return output
//        }
//    }
//
//    static func getLocalizedPriceFromProductV2(_ item: ProductModelCV1, includePercent: Bool, salePriceFontSize: CGFloat, discountPriceFontSize: CGFloat) -> NSAttributedString {
////        let won = ResourceDataStore.strings().STRING_CURRENCY
//        let percent = "%"
//        let price = (CalculationUtility.convertPointIntoDecimalStringFormat(item.price))
//        let salePrice = (CalculationUtility.convertPointIntoDecimalStringFormat(item.sale_price))
//        if item.sale_percent == 0 {
//            let source = "\(salePrice)"
//            let output = NSMutableAttributedString(string: source)
//            return output
//        } else {
//            let salePercentString = NSAttributedString(string: "\(item.sale_percent)\(percent)", attributes: [NSAttributedString.Key.foregroundColor: ResourceDataStore.colors().COLOR_BRANDI_RED, NSAttributedString.Key.font: UIFont.systemFont(ofSize: salePriceFontSize, weight: .medium)])
//            let salePriceString = NSAttributedString(string: "\(salePrice)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: salePriceFontSize, weight: .medium)])
//            let priceString = NSAttributedString(string: "\(price)", attributes: [NSAttributedString.Key.foregroundColor: ResourceDataStore.colors().COLOR_BRANDI_BDBDBD, NSAttributedString.Key.strikethroughStyle: 1, NSAttributedString.Key.font: UIFont.systemFont(ofSize: discountPriceFontSize, weight: .medium)])
//            let output = NSMutableAttributedString(string: "")
//            if includePercent {
//                output.append(salePercentString)
//                output.append(NSAttributedString(string: " "))
//            }
//            output.append(salePriceString)
//            output.append(NSAttributedString(string: " "))
//            output.append(priceString)
//            return output
//        }
//    }
//
//    static func getLocalizedPriceFromProductV3(_ item: ProductModelCV1, includePercent: Bool, salePriceFontSize: CGFloat, discountPriceFontSize: CGFloat) -> NSAttributedString {
//        let percent = "%"
//        let price = (CalculationUtility.convertPointIntoDecimalStringFormat(item.price))
//        let salePrice = (CalculationUtility.convertPointIntoDecimalStringFormat(item.sale_price))
//        if item.sale_percent == 0 {
//            let source = "\(salePrice)"
//            let output = NSMutableAttributedString(string: source)
//            return output
//        } else {
//            let salePercentString = NSAttributedString(string: "\(item.sale_percent)\(percent)", attributes: [NSAttributedString.Key.foregroundColor: ResourceDataStore.colors().COLOR_BRANDI_PRIMARY, NSAttributedString.Key.font: UIFont.systemFont(ofSize: salePriceFontSize, weight: .bold)])
//            let salePriceString = NSAttributedString(string: "\(salePrice)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: salePriceFontSize, weight: .bold)])
//            let priceString = NSAttributedString(string: "\(price)", attributes: [NSAttributedString.Key.foregroundColor: Asset.Colors.g500.color, NSAttributedString.Key.strikethroughStyle: 1, NSAttributedString.Key.font: UIFont.systemFont(ofSize: discountPriceFontSize, weight: .medium)])
//            let output = NSMutableAttributedString(string: "")
//            if includePercent {
//                output.append(salePercentString)
//                output.append(NSAttributedString(string: " "))
//            }
//            output.append(salePriceString)
//            output.append(NSAttributedString(string: " "))
//            output.append(priceString)
//            return output
//        }
//    }
//
//    static func getLocalizedPriceFromProductV3(_ item: ProductModelCV1, includePercent: Bool, salePercentColor: UIColor = ResourceDataStore.colors().COLOR_BRANDI_PRIMARY, salePercentFontSize: CGFloat, salePercentFontWeight: UIFont.Weight = .bold, salePriceColor: UIColor = .black, salePriceFontSize: CGFloat, salePriceFontWeight: UIFont.Weight = .bold, originalPriceColor: UIColor = ResourceDataStore.colors().COLOR_BRANDI_9E9E9E, originalPriceFontSize: CGFloat, originalPriceFontWeight: UIFont.Weight = .medium) -> NSAttributedString {
//        let percent = "%"
//        let originalPrice = (CalculationUtility.convertPointIntoDecimalStringFormat(item.price))
//        let salePrice = (CalculationUtility.convertPointIntoDecimalStringFormat(item.sale_price))
//        if item.sale_percent == 0 {
//            let salePriceString = "\(salePrice)"
//            let attributes = [NSAttributedString.Key.foregroundColor: salePriceColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: salePriceFontSize, weight: salePriceFontWeight)]
//            let output = NSMutableAttributedString(string: salePriceString, attributes: attributes)
//            return output
//        } else {
//            let salePercentString = NSAttributedString(string: "\(item.sale_percent)\(percent)", attributes: [NSAttributedString.Key.foregroundColor: salePercentColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: salePriceFontSize, weight: salePercentFontWeight)])
//            let salePriceString = NSAttributedString(string: "\(salePrice)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: salePriceFontSize, weight: salePriceFontWeight)])
//            let originalPriceString = NSAttributedString(string: "\(originalPrice)", attributes: [NSAttributedString.Key.foregroundColor: originalPriceColor, NSAttributedString.Key.strikethroughStyle: 1, NSAttributedString.Key.font: UIFont.systemFont(ofSize: originalPriceFontSize, weight: originalPriceFontWeight)])
//            let output = NSMutableAttributedString(string: "")
//            if includePercent {
//                output.append(salePercentString)
//                output.append(NSAttributedString(string: " "))
//            }
//            output.append(salePriceString)
//            output.append(NSAttributedString(string: " "))
//            output.append(originalPriceString)
//            return output
//        }
//    }
//
//    static func getLocalizedPriceFromProductForReviewDetail(_ item: ProductModelCV1, includePercent: Bool, salePriceFontSize: CGFloat, priceFontSize: CGFloat, salePersentFontSize: CGFloat) -> NSAttributedString {
//        let percent = "%"
//        let price = (CalculationUtility.convertPointIntoDecimalStringFormat(item.price))
//        let salePrice = (CalculationUtility.convertPointIntoDecimalStringFormat(item.sale_price))
//        if item.sale_percent == 0 {
//            let source = "\(salePrice)"
//            let output = NSMutableAttributedString(string: source)
//            return output
//        } else {
//            let salePriceString = NSAttributedString(string: "\(salePrice)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: salePriceFontSize, weight: .bold)])
//            let priceString = NSAttributedString(string: "\(price)", attributes: [NSAttributedString.Key.foregroundColor: ResourceDataStore.colors().COLOR_BRANDI_BDBDBD, NSAttributedString.Key.strikethroughStyle: 1, NSAttributedString.Key.font: UIFont.systemFont(ofSize: priceFontSize, weight: .ultraLight)])
//            let salePercentString = NSAttributedString(string: "\(item.sale_percent)\(percent)", attributes: [NSAttributedString.Key.foregroundColor: ResourceDataStore.colors().COLOR_BRANDI_PRIMARY, NSAttributedString.Key.font: UIFont.systemFont(ofSize: salePersentFontSize, weight: .light)])
//            let output = NSMutableAttributedString(string: "")
//            output.append(salePriceString)
//            output.append(NSAttributedString(string: " "))
//            output.append(priceString)
//            if includePercent {
//                output.append(NSAttributedString(string: " "))
//                output.append(salePercentString)
//            }
//            return output
//        }
//    }
//
//    static func getLocalizedPriceFromProduct(_ item: ProductModelCV1, isSaleProduct: Bool, isSoldOut: Bool) -> NSAttributedString {
//        let price = (CalculationUtility.convertPointIntoDecimalStringFormat(item.price))
//        var attributes: [NSAttributedString.Key: Any] = [:]
//        if isSaleProduct {
//            attributes = [NSAttributedString.Key.foregroundColor: ResourceDataStore.colors().COLOR_BRANDI_LIGHTGRAY, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0, weight: .ultraLight), NSAttributedString.Key.strikethroughStyle: 1]
//            let priceString = NSAttributedString(string: "\(price)", attributes: attributes)
//            let output = NSMutableAttributedString(string: "")
//            output.append(priceString)
//            return output
//        } else {
//            if isSoldOut {
//                attributes = [NSAttributedString.Key.foregroundColor: ResourceDataStore.colors().COLOR_BRANDI_LIGHTGRAY, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0, weight: .bold)]
//            } else {
//                attributes = [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13.0, weight: .bold)]
//            }
//            let priceString = NSAttributedString(string: "\(price)", attributes: attributes)
//            let output = NSMutableAttributedString(string: "")
//            output.append(priceString)
//            return output
//        }
//    }
//
//    static func getCommentWithUserName(_ comment: String, userName: String, commentFontSize: CGFloat, userNameFontSize: CGFloat) -> NSAttributedString {
//        let userNameString = NSAttributedString(string: userName, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: userNameFontSize, weight: .bold)])
//        let commentString = NSAttributedString(string: comment, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: commentFontSize, weight: .regular)])
//        let output = NSMutableAttributedString(string: "")
//        output.append(userNameString)
//        output.append(NSAttributedString(string: "  "))
//        output.append(commentString)
//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = 3.0
//        let attributes = [NSAttributedString.Key.paragraphStyle: style]
//        output.addAttributes(attributes, range: output.mutableString.range(of: output.string))
//        return output
//    }
//
//    static func getReplyCommentWithUserName(_ comment: String, userName: String, commentFontSize: CGFloat, userNameFontSize: CGFloat) -> NSAttributedString {
//        let userNameWithAt = "@" + userName
//        let userNameString = NSAttributedString(string: userNameWithAt, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: userNameFontSize, weight: .regular)])
//        let commentString = NSAttributedString(string: comment, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: commentFontSize, weight: .regular)])
//        let output = NSMutableAttributedString(string: "")
//        output.append(userNameString)
//        output.append(NSAttributedString(string: "  "))
//        output.append(commentString)
//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = 3.0
//        let attributes = [NSAttributedString.Key.paragraphStyle: style]
//        output.addAttributes(attributes, range: output.mutableString.range(of: output.string))
//        return output
//    }
//
//    static func getTextAppiedWithLineSpacing(_ text: String, lineSpacingSize: CGFloat) -> NSAttributedString {
//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = lineSpacingSize
//        let attributes = [NSAttributedString.Key.paragraphStyle: style]
//        let output = NSMutableAttributedString(string: text)
//        output.addAttributes(attributes, range: output.mutableString.range(of: output.string))
//        return output
//    }
//
//    static func getPointStatusAndReason(_ pointStatus: String, postponeReason: String?, alignment: NSTextAlignment, bigTitleFontSize: CGFloat, bigTitleFontWeight: UIFont.Weight) -> NSAttributedString {
//        var reasonString = NSAttributedString(string: "")
//        let pointStatusString = NSAttributedString(string: pointStatus, attributes: [NSAttributedString.Key.foregroundColor: ResourceDataStore.colors().COLOR_BRANDI_PRIMARY, NSAttributedString.Key.font: UIFont.systemFont(ofSize: bigTitleFontSize, weight: bigTitleFontWeight)])
//        if let reason = postponeReason {
//            reasonString = NSAttributedString(string: reason, attributes: [NSAttributedString.Key.foregroundColor: ResourceDataStore.colors().COLOR_BRANDI_PRIMARY, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11.0, weight: .regular)])
//        }
//        let style = NSMutableParagraphStyle()
//        style.alignment = alignment
//        let output = NSMutableAttributedString(string: "")
//        output.append(pointStatusString)
//        if postponeReason != nil {
//            output.append(NSMutableAttributedString(string: "\n"))
//            output.append(reasonString)
//            style.lineSpacing = 4
//        }
//        let attributes = [NSAttributedString.Key.paragraphStyle: style]
//        output.addAttributes(attributes, range: output.mutableString.range(of: output.string))
//        return output
//    }
//
//    static func getTagProductZoningTitle(_ name: String, text: String, nameFontSize: CGFloat, textFontSize: CGFloat, nameColor: UIColor, textColor: UIColor) -> NSAttributedString {
//        let tagNameString = NSAttributedString(string: name, attributes: [NSAttributedString.Key.foregroundColor: nameColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: nameFontSize, weight: .bold)])
//        let tagTextString = NSAttributedString(string: "\n\(text)", attributes: [NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: textFontSize, weight: .regular)])
//        let output = NSMutableAttributedString(string: "")
//        output.append(tagNameString)
//        output.append(tagTextString)
//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = 4
//        let attributes = [NSAttributedString.Key.paragraphStyle: style]
//        output.addAttributes(attributes, range: output.mutableString.range(of: output.string))
//        return output
//    }
//
//    static func getTagProductZoningTitleForCategoryTab(_ name: String, text: String, nameFontSize: CGFloat, textFontSize: CGFloat, nameColor: UIColor, textColor: UIColor) -> NSAttributedString {
//        let tagNameString = NSAttributedString(string: name, attributes: [NSAttributedString.Key.foregroundColor: nameColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: nameFontSize, weight: .bold)])
//        let tagTextString = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: textColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: textFontSize, weight: .regular)])
//        let output = NSMutableAttributedString(string: "")
//        output.append(tagNameString)
//        output.append(NSAttributedString(string: "   ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 9, weight: .bold)]))
//        output.append(tagTextString)
//        return output
//    }
    
//    static func getSearchKeywordHeaderTitleForPopular(textFontSize: CGFloat) -> NSAttributedString {
//        let headerTitleFirstTextString = NSAttributedString(string: ResourceDataStore.strings().STRING_SEARCH_HEADER_KEYWORD_POPULAR_FIRST, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: textFontSize, weight: .bold)])
//        let headerTitleSecondTextString = NSAttributedString(string: ResourceDataStore.strings().STRING_SEARCH_HEADER_KEYWORD_POPULAR_SECOND, attributes: [NSAttributedString.Key.foregroundColor: ResourceDataStore.colors().COLOR_BRANDI_PRIMARY, NSAttributedString.Key.font: UIFont.systemFont(ofSize: textFontSize, weight: .bold)])
//        let headerTitleThirdTextString = NSAttributedString(string: ResourceDataStore.strings().STRING_SEARCH_HEADER_KEYWORD_SEARCH_KEYWORD, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: textFontSize, weight: .bold)])
//
//        let output = NSMutableAttributedString(string: "")
//
//        output.append(headerTitleFirstTextString)
//        output.append(NSAttributedString(string: " "))
//        output.append(headerTitleSecondTextString)
//        output.append(NSAttributedString(string: " "))
//        output.append(headerTitleThirdTextString)
//
//        return output
//    }
//
//    static func getSearchKeywordHeaderTitleForRecent(textFontSize: CGFloat) -> NSAttributedString {
//        let headerTitleFirstTextString = NSAttributedString(string: ResourceDataStore.strings().STRING_SEARCH_HEADER_KEYWORD_RECENT_FIRST, attributes: [NSAttributedString.Key.foregroundColor: ResourceDataStore.colors().COLOR_BRANDI_PRIMARY, NSAttributedString.Key.font: UIFont.systemFont(ofSize: textFontSize, weight: .bold)])
//        let headerTitleSecondTextString = NSAttributedString(string: ResourceDataStore.strings().STRING_SEARCH_HEADER_KEYWORD_SEARCH_KEYWORD, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: textFontSize, weight: .bold)])
//
//        let output = NSMutableAttributedString(string: "")
//
//        output.append(headerTitleFirstTextString)
//        output.append(NSAttributedString(string: " "))
//        output.append(headerTitleSecondTextString)
//
//        return output
//    }
//
//    static func getLocalizedPriceFromProduct(_ item: ProductDetailModelCV1) -> String {
//        let product = ProductModelCV1().parseFromObject(item)
//        return self.getLocalizedPriceFromProduct(product)
//    }
//
//    static func getLocalizedPriceFromProduct(_ item: ProductDetailModelCV1) -> NSAttributedString {
//        let product = ProductModelCV1().parseFromObject(item)
//        return self.getLocalizedPriceFromProduct(product)
//    }
//
//    static func getLocalizedPriceFromProductV2(_ item: ProductDetailModelCV1, includePercent: Bool) -> NSAttributedString {
//        let product = ProductModelCV1().parseFromObject(item)
//        return self.getLocalizedPriceFromProductV2(product, includePercent: includePercent, salePriceFontSize: 18.0, discountPriceFontSize: 15.0)
//    }
//
//    static func getLocalizedPriceFromProductV3(_ item: ProductDetailModelCV1, includePercent: Bool) -> NSAttributedString {
//        let product = ProductModelCV1().parseFromObject(item)
//        return self.getLocalizedPriceFromProductV3(product, includePercent: includePercent, salePriceFontSize: 20, discountPriceFontSize: 16)
//    }
//
//    static func getLocalizedPriceFromProductForReviewDetail(_ product: ProductModelCV1, includePercent: Bool) -> NSAttributedString {
//        return self.getLocalizedPriceFromProductForReviewDetail(product, includePercent: includePercent, salePriceFontSize: 13.0, priceFontSize: 10.0, salePersentFontSize: 13.0)
//    }

    static func getCurrentTimeStamp() -> String {
//        let stamp = "\(Date().timeIntervalSince1970)".components(separatedBy: ".").first!
//        Logger.infoLog("created timestamp: \(stamp)")
//        return stamp
        return self.getCurrentTimeStamp(offsetInMills: 0)
    }
    
    static func getCurrentTimeStamp(offsetInMills: TimeInterval) -> String {
        let stamp = "\(Date().timeIntervalSince1970 + offsetInMills)".components(separatedBy: ".").first!
        return stamp
    }
    
    static func getCountStringDividedAlphabetUnit(_ countSource: Int) -> String {
        var countString = "\(countSource)"
        if countSource > 999999 {
            let count: CGFloat = CGFloat(countSource) / 1000000
            countString = String(format: "%.1f", count) + "m"
        } else if countSource > 999 {
            let count: CGFloat = CGFloat(countSource) / 1000
            countString = String(format: "%.1f", count) + "k"
        }
        return countString
    }
    
    static func getNumberOrdinalFormat(_ number: Int) -> String {
        var suffix: String
        let ones: Int = number % 10
        let tens: Int = (number/10) % 10
        if tens == 1 {
            suffix = "th"
        } else if ones == 1 {
            suffix = "st"
        } else if ones == 2 {
            suffix = "nd"
        } else if ones == 3 {
            suffix = "rd"
        } else {
            suffix = "th"
        }
        return "\(self)\(suffix)"
    }
    
    static func getCellNumberParsed(_ cellNumber: String) -> (numHead: String, numBody: String, numTail: String)? {
        let distString = cellNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        if distString.count > 11 || distString.count < 10 { // digits count doesn't matched with cell number format
            return nil
        }
        let startIndex = distString.startIndex
        let head = distString[..<distString.index(startIndex, offsetBy: 3)] // 010, 011, or else..
        if distString.count == 10 { // 000-0000
            let body = distString[distString.index(startIndex, offsetBy: 3)..<distString.index(startIndex, offsetBy: 6)]
            let tail = distString[distString.index(startIndex, offsetBy: 6)...]
            return (numHead: String(head), numBody: String(body), numTail: String(tail))
        } else if distString.count == 11 { // 0000-0000
            let body = distString[distString.index(startIndex, offsetBy: 3)..<distString.index(startIndex, offsetBy: 7)]
            let tail = distString[distString.index(startIndex, offsetBy: 7)...]
            return (numHead: String(head), numBody: String(body), numTail: String(tail))
        } else { // no case at all. exists for later cases
            return nil
        }
    }
    
//    static func getAlarmTypeAttString(head: String?, content: String?) -> NSAttributedString {
//        let text: NSMutableAttributedString = NSMutableAttributedString(string: "")
//        if let heading = head {
//            let att = NSAttributedString(string: heading, attributes: [NSAttributedString.Key.foregroundColor: ResourceDataStore.colors().COLOR_BRANDI_PRIMARY, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12.0, weight: .bold)])
//            text.append(att)
//            if content != nil {
//                text.append(NSAttributedString(string: " "))
//            }
//        }
//        if let desc = content {
//            let attDesc = StringUtility.getAttributedStringFromCommerceContent(desc, fontSize: 12.0, highlightColor: ResourceDataStore.colors().COLOR_BRANDI_RED)
//            text.append(attDesc)
//        }
//        let style = NSMutableParagraphStyle()
//        style.lineSpacing = 3.0
//        let attributes = [NSAttributedString.Key.paragraphStyle: style]
//        text.addAttributes(attributes, range: text.mutableString.range(of: text.string))
//        return text
//    }
//    
//    static func getErrorMessageFrom(_ code: ErrorCode?) -> String {
//        var message = ResourceDataStore.strings().STRING_ALERT_REQUEST_FAILURE
//        if let code = code {
//            switch code {
//            case .COMMON_DATA_REQUIRED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_INCOMPLETE_NECESSARY_DATA
//            case .COMMON_NOT_AUTHORIZED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_NOT_AUTHORIZED
//            case .COMMON_DATA_DUPLICATED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_DATA_DUPLICATED
//            case .COMMON_DATA_USER_IS_GUEST:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_NOT_AUTHORIZED_IS_GUEST
//            case .COMMON_DATA_UNVERIFIED_USER:
//                message = "재입고알림신청은 주문하기 페이지에서 실명인증 진행 후 이용 가능합니다."
//            case .PRODUCT_NOT_EXIST:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_PRODUCT_NOT_EXIST
//            case .PRODUCT_NOT_FOR_SALE:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_PRODUCT_NOT_FOR_SALE
//            case .PRODUCT_SOLD_OUT:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_PRODUCT_SOLD_OUT
//            case .PRODUCT_INAVAILABLE_PRODUCT_INCLUDED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_PRODUCT_INAVAILABLE_PRODUCT_INCLUDED
//            case .PRODUCT_EXCEED_AVAILABLE_QUANTITY:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_PRODUCT_EXCEED_AVAILABLE_QUANTITY
//            case .ORDER_PRICE_NOT_MATCHED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ORDER_PRICE_NOT_MATCHED
//            case .ORDER_POINT_CHECK_FAILURE:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ORDER_POINT_CHECK_FAILURE
//            case .ORDER_POINT_OUT_OF_DEPOSIT:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ORDER_POINT_OUT_OF_DEPOSIT
//            case .ORDER_POINT_OVER_MAX_POINT_GUIDE:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ORDER_POINT_OUT_OF_GUIDE_LIMIT
//            case .ORDER_COUPON_UNDER_AVAILABLE_PRICE:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_COUPON_UNDER_MINIMUM_PRICE
//            case .ORDER_COUPON_INAVAILABLE_TO_PRODUCT:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_COUPON_INAVAILABLE_PRODUCT_TO_USE
//            case .ORDER_COUPON_DISCOUNT_PRICE_NOT_MATCHED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_COUPON_DISCOUNTED_PRICE_UNMATCHED
//            case .ORDER_PRICE_NOT_MATCHED_PRICE_CHANGED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_PRICE_NOT_MATCHED_PRICE_IS_CHANGED
//            case .ORDER_BANK_ACCOUNT_DOES_NOT_EXIST:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_BANK_ACCOUNT_DOES_NOT_EXIST
//            case .ORDER_SHIPPING_INFO_MAX:
//                message = "배송지 입력 가능갯수는 최대 5개입니다."
//            case .ORDER_SHIPPING_INFO_DEFAULT_INMUTABLE:
//                message = "기본 배송지를 해제 할 수 없습니다."
//            case .ORDER_SHIPPING_INFO_INITIAL_NOT_DEFAULT:
//                message = "최초 등록하는 배송지는 기본 배송지로 등록되어야 합니다."
//            case .ORDER_SHIPPING_INFO_NEED_ATLEAST_ONE:
//                message = "삭제할 수 없습니다. 배송지 정보 최소 1개 있어야 합니다."
//            case .ORDER_SHIPPING_INFO_UNAUTHORED:
//                message = "유효하지 않은 배송지 정보입니다."
//            case .ORDRR_SHIPPING_INFO_NOT_VALID:
//                message = "유효하지 않은 배송지 입니다"
//            case .ORDER_FAST_SHIPPING_SERVICE_AREA_UNAVAILABLE:
//                message = "하루배송 서비스 이용 불가 지역"
//            case .ORDER_FAST_SHIPPING_SERVICE_CLOSED:
//                message = "하루배송 서비스 마감으로 이용 불가"
//            case .ORDER_FAST_SHIPPING_SERVICE_UNAVAILABLE:
//                message = "하루배송 서비스 이용 불가 (비회원 또는 잘못된 접근으로 인한 조건 미충족)"
//            case .ORDER_FAST_SHIPPING_PAYMENT_BANK_UNAVAILABLE:
//                message = "하루배송 상품 포함되었을 경우 무통장입금 결제 불가"
//            case .NICKNAME_DUPLICATED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_DUPLICATED_NICKNAME
//            case .NICKNAME_FORMAT_ERROR:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_NICKNAME_FORMAT_ERROR
//            case .EMAIL_FORMAT_ERROR:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_EMAIL_FORMAT_ERROR
//            case .USER_ALREADY_SIGNED_UP_SNS:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_USER_ALREADY_SIGNED_UP_SNS
//            case .VERIFICATION_CODE_NOT_VALID:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_VERIFICATION_CODE_NOT_VALID
//            case .VERIFICATION_CODE_DUPLICATED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_VERIFICATION_CODE_DUPLICATED
//            case .VERIFICATION_CODE_NOT_FOUND:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_VERIFICATION_CODE_NOT_FOUND
//            case .PASSWORD_NOT_MATCH_WITH_PRIOR:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_PASSWORD_NOT_MATCHED_WITH_PRIOR
//            case .PASSWORD_FORMAT_ERROR:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_PASSWORD_FORMAT_ERROR
//            case .USER_STATE_CANNOT_BE_PROCESSED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_CANNOT_BE_PROCEED
//            case .USER_HAS_ORDER_IN_PROGRESS_WITHDRAW_NOT_ALLOWED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_USER_HAS_ORDER_IN_PROGRESS_WITHDRAW_NOT_ALLOWED
//            case .USER_HAS_WITHDRAW_HISTORY_JOIN_NOT_ALLOWED_IN_A_MONTH:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_USER_HAS_WITHDRAW_HISTORY_WITHDRAW_NOT_ALLOWED
//            case .USER_NEED_AGREEMENT_OF_INFORMATION_PROVIDING:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_USER_NEED_AGREEMENT_OF_ACCOUNT_FROM_ANOTHER_SERVICE
//            case .USER_HAS_NO_FACEBOOK_SNS_ID:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_USER_HAS_NO_FACEBOOK_SNS_ID
//            case .EMAIL_NOT_EXIST:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_EMAIL_DOES_NOT_EXIST
//            case .EMAIL_DUPLICATED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_EMAIL_DUPLICATED
//            case .EMAIL_IS_SNS_USER:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_EMAIL_IS_SNS_USER
//            case .POINTCODE_NOT_EXIST:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_POINTCODE_DOES_NOT_EXIST
//            case .POINTCODE_ALREADY_USED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_POINTCODE_ALREADY_USED
//            case .POINTCODE_EXPIRED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_POINTCODE_EXPIRED
//            case .POINTCODE_LIMIT_EXCEEDED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_POINTCODE_LIMIT_EXCEEDED
//            case .POINTCODE_ALREADY_DOWNLOADED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_POINTCODE_ALREADY_DOWNLOADED
//            case .COUPON_NOT_EXIST:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_COUPON_DOES_NOT_EXIST
//            case .COUPON_ALREADY_USED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_COUPON_ALREADY_USED
//            case .COUPON_EXPIRED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_COUPON_EXPIRED
//            case .COUPON_LIMIT_EXCEEDED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_COUPON_LIMIT_EXCEEDED
//            case .COUPON_ALREADY_DOWNLOADED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_COUPON_ALREADY_DOWNLOADED
//            case .COUPON_MULTIPLE_DOWNLOAD_ALL_INVALID:
//                message =  Strings.stringAlertCouponMultipleDownloadAllInvalid
//            case .ORDER_NOT_EXIST:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ORDER_NOT_EXIST
//            case .ORDER_REQUEST_NOT_BELONG:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ORDER_REQUESET_NOT_BELONG_TO_USER
//            case .CHECKOUT_INFO_NOT_EXIST:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_CHECKOUT_INFO_DOES_NOT_EXIST
//            case .DELIVERY_DATE_NOT_EXIST:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_DELIVERY_DATE_DOES_NOT_EXIST
//            case .PENDING_CANCELLATION_3_DAYS:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_PENDING_CANCELLATION_IN_THREE_DAYS
//            case .ORDER_CANCEL_CANNOT_PROCEED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ORDER_CANCEL_CANNOT_PROCEED_IN_CURRENT_STATUS
//            case .ORDER_REFUND_CANNOT_PROCEED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ORDER_REFUND_CANNOT_PROCEED_IN_CURRENT_STATUS
//            case .ORDER_CALCULATION_ERROR:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ORDER_CALCULATION_ERROR
//            case .ORDER_CANCEL_TYPE_NOT_EXIST:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ORDER_CANCEL_TYPE_DOES_NOT_EXIST
//            case .ORDER_CANCEL_INFO_INPUT_ERROR:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ORDER_CANCELLATION_INFO_INPUT_ERROR
//            case .ORDER_DETAIL_CANCEL_INFO_REFRESH_ERROR:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ORDER_DETAIL_CANCELLATION_INFO_REFRESH_ERROR
//            case .CANCEL_INFO_INPUT_ERROR:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ORDER_CANCELLATION_INFO_INPUT_ERROR
//            case .BANKCODE_NOT_CORRECT:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_BANKCODE_NOT_CORRECT
//            case .ACCOUNT_INFO_INPUT_ERROR:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ACCOUNT_INFO_INPUT_ERROR
//            case .CLAIM_INFO_INPUT_ERROR:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_CLAIM_INFO_INPUT_ERROR
//            case .POINT_REFUND_ERROR:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_POINT_REFUND_ERROR
//            case .POINT_REFUND_AMOUNT_NOT_CORRECT_FOR_PAYMENT_METHOD:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_POINT_REFUND_AMOUNT_NOT_CORRECT_FOR_PAYMENT_METHOD
//            case .CANCEL_TYPE_NOT_SUPPORTED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_CANCELLATION_TYPE_NOT_SUPPORTED
//            case .ORDER_CHANGELOG_INPUT_ERROR:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_CHANGELOG_INPUT_ERROR
//            case .ORDER_STATE_CHANGE_ERROR:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ORDER_STATE_CHANGE_ERROR
//            case .PG_INFO_NOT_EXIST:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_PG_INFO_NOT_EXIST
//            case .CANCEL_AMOUNT_NOT_CORRECT:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_CANCELLATION_AMOUNT_NOT_MATCHED
//            case .PG_CANCEL_FAILURE:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_PG_CANCELLATION_FAILURE
//            case .PG_CANCEL_FAILURE_PARTIAL:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_PG_PARTIAL_CANCELLATION_FAILURE
//            case .SERVICE_INFO_GENERATION_FAILURE:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_SERVICE_INFO_GENERATION_FAILURE
//            case .CANCEL_INFO_ACCESS_TYPE_NOT_SUPPORTED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_CANCELLATION_INFO_ACCESS_TYPE_DEOS_NOT_SUPPORTED
//            case .REFUND_INFO_INPUT_ERROR:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_REFUND_INFO_INPUT_ERROR
//            case .REFUND_REASON_NOT_CORRECT:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_REFUND_REASON_CODE_NOT_VALID
//            case .ORDER_REQUEST_CANNOT_PROCEED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ORDER_REQEUST_CANNOT_PROCEED_IN_CURRENT_STATUS
//            case .ORDER_REQUEST_CANNOT_PROCEED_OPTIONAL_PRODUCT_EXIST:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ORDER_REQEUST_CANNOT_PROCEED_OPTIONAL_PRODUCT_EXIST
//            case .ORDER_OPTIONAL_PRE_CANCEL_INAVAILABLE:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ORDER_OPTIONAL_PRODUCT_CANCELLATION_CANNOT_PROCEED_FIRST
//            case .ORDER_ESSENTIAL_PRODUCT_NOT_SELECTED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ORDER_ESSENTIAL_PRODUCT_NOT_SELECTED
//            case .ORDER_ESSENTIAL_PRODUCT_CANNOT_BE_DELETED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_ORDER_ESSENTIAL_PRODUCT_CANNOT_BE_DELETED
//            case .GUEST_ORDER_CANNOT_USE_COUPON_OR_POINT:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_GUEST_ORDER_CANNOT_USE_COUPON_OR_POINT
//            case .GUEST_NO_MATCHING_PURCHASE_DATA:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_GUEST_NO_MATCHING_PURCHASE_DATA
//            case .INVALID_AUTHENTICATION_PHONENUMBER_CODE:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_INVALID_AUTHENTICATION_PHONENUMBER_CODE
//            case .MAX_CART_OVERLOAD:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_MAX_CART_OVERLOAD
//            case .VERIFICATION_APP_SYSTEM_ERROR:
//                fallthrough
//            case .VERIFICATION_ENCODE_DECODE_SYSTEM_ERROR_2:
//                fallthrough
//            case .VERIFICATION_ENCODE_DATA_ERROR:
//                fallthrough
//            case .VERIFICATION_DECODE_PROCESS_ERROR:
//                fallthrough
//            case .VERIFICATION_HASHVALUE_NOT_MATCH:
//                fallthrough
//            case .VERIFICATION_DECODE_DATA_ERROR:
//                fallthrough
//            case .VERIFICATION_INPUT_DATA_ERROR:
//                fallthrough
//            case .VERIFICATION_SITE_PASSWORD_ERROR:
//                fallthrough
//            case .VERIFICATION_NOT_MATCH:
//                fallthrough
//            case .VERIFICATION_ERROR_ELSE:
//                fallthrough
//            case .VERIFICATION_CODE_NOT_MATCH:
//                fallthrough
//            case .VERIFICATION_COMMUNICATION_ERROR:
//                fallthrough
//            case .VERIFICATION_DATABASE_ERROR:
//                fallthrough
//            case .VERIFICATION_CP_CODE_NOT_VALID:
//                fallthrough
//            case .VERIFICATION_CP_CODE_IS_INTURRUPTED:
//                fallthrough
//            case .VERIFICATION_CP_CODE_IS_DISABLED_FOR_CELLPHONE:
//                fallthrough
//            case .VERIFICATION_CP_CODE_NOT_REGISTERED:
//                fallthrough
//            case .VERIFICATION_NO_VALID_HISTORY:
//                fallthrough
//            case .VERIFICATION_IS_ALREADY_COMPLETED:
//                fallthrough
//            case .VERIFICATION_BLOCKED_BY_USER_FROM_CARRIER:
//                fallthrough
//            case .VERIFICATION_SMS_BLOCKED_BY_USER_FROM_CARRIER:
//                fallthrough
//            case .VERIFICATION_BLOCKED_BY_USER_FROM_NICEID_NAME_PROTECTION:
//                fallthrough
//            case .VERIFICATION_BLOCKED_FOR_NEGATIVE_USAGE:
//                fallthrough
//            case .VERIFICATION_APP_NOT_INSTALLED:
//                fallthrough
//            case .VERIFICATION_APP_NOT_COMPLETED:
//                fallthrough
//            case .VERIFICATION_APP_PROCESS_ERROR:
//                fallthrough
//            case .VERIFICATION_APP_NOT_INSTALLED_LGU:
//                fallthrough
//            case .VERIFICATION_APP_REINSTALL_NEEDED:
//                fallthrough
//            case .VERIFICATION_APP_NOT_AVAILABLE_NOT_SMARTPHONE:
//                fallthrough
//            case .VERIFICATION_APP_NOT_INSTALLED_2:
//                fallthrough
//            case .VERIFICATION_SMS_NOT_MATCHED_THREE_TIMES:
//                fallthrough
//            case .VERIFICATION_ERROR_ETC:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_VERIFICATION_ERROR_ETCS
//            case .VERIFICATION_UNDER_AGE_14_ERROR:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_VERIFICATION_UNDER_FOURTEEN
//            case .VERIFICATION_RESULT_STORE_ERROR:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_VERIFICATION_RESULT_STORE_ERROR
//            case .VERIFICATION_REQUEST_INFO_NOT_MATCHED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_VERIFICATION_REQUEST_INFO_DOES_NOT_MATCHED
//            case .REVIEW_EDIT_NOT_ALLOWED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_REVIEW_EDIT_NOT_ALLOWED
//            case .REVIEW_DELETE_NOT_ALLOWED:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_REVIEW_DELETE_NOT_ALLOWED
//            case .REVIEW_DELETED_OR_NOT_VALID:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_REVIEW_DELETED_OR_NOT_VALID
//            case .REVIEW_COMMENT_DELETED_OR_NOT_VALID:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_REVIEW_COMMENT_DELETED_OR_NOT_VALID
//            case .REVIEW_CONTENT_MAX_LENGTH_OVERFLOW:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_REVIEW_MAX_LENGTH_OVERFLOW
//            case .REVIEW_POINT_NOT_ELIGABLE_NOT_DELETABLE:
//                message = ResourceDataStore.strings().STRING_ERRORMESSAGE_REVIEW_DELETE_NOT_ALLOWED
//            case .PRODUCT_NOTICE_RESTOCK_NOT_AVAILABLE:
//                message = "재고 변경으로 재입고 알림 신청이 불가능합니다"
//            case .CART_NO_SOLDOUT_PROUDCT_DELETE_AVAILABLE:
//                message = "품절상품이 없습니다."
//            default:
//                message = ResourceDataStore.strings().STRING_ALERT_REQUEST_FAILURE.appending("\ncode: ").appending(code.rawValue)
//            }
//        }
//        return message
//    }
//    
    static func whichLanguage(_ keyword: String) -> LocaleType {
        let patternEn = "[A-Za-z0-9.]"
        let patternKr = "[ㄱ-힣0-9]"
        let regexKr = try! NSRegularExpression(pattern: patternKr, options: NSRegularExpression.Options())
        let regexEn = try! NSRegularExpression(pattern: patternEn, options: NSRegularExpression.Options())
        var locale: LocaleType = .kor
        if regexKr.firstMatch(in: keyword, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: keyword.count)) != nil {
            locale = .kor
        } else if regexEn.firstMatch(in: keyword, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: keyword.count)) != nil {
            locale = .eng
        }
        Logger.infoLog("keyword \(keyword) is matching with \(locale.rawValue)")
        return locale
    }
    
    static func getCountsOfEachLanguageChars(_ keyword: String) -> [(locale: LocaleType, charCount: Int)] {
        var chars: [(locale: LocaleType, charCount: Int)] = []
        let patternEn = "[A-Za-z0-9. ]"
        let patternKr = "[ㄱ-힣0-9]"
        let regexKr = try! NSRegularExpression(pattern: patternKr, options: NSRegularExpression.Options())
        let regexEn = try! NSRegularExpression(pattern: patternEn, options: NSRegularExpression.Options())
        let krMatches: Int = regexKr.numberOfMatches(in: keyword, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: keyword.count))
        let engMatches: Int = regexEn.numberOfMatches(in: keyword, options: NSRegularExpression.MatchingOptions(), range: NSRange(location: 0, length: keyword.count))
        let totalCount = keyword.count
        let matchSum: Int = krMatches + engMatches
        if matchSum == totalCount {
            // there are no exceptions
            chars.append((locale: LocaleType.kor, charCount: krMatches))
            chars.append((locale: LocaleType.eng, charCount: engMatches))
        } else if matchSum < totalCount {
            // space chars of else language included
            let gap = totalCount - matchSum
            chars.append((locale: LocaleType.kor, charCount: krMatches))
            chars.append((locale: LocaleType.eng, charCount: engMatches + gap))
        } else if matchSum > totalCount {
            // there are multiple matches
            let gap = matchSum - totalCount
            chars.append((locale: LocaleType.kor, charCount: krMatches))
            chars.append((locale: LocaleType.eng, charCount: engMatches - gap))
        }
        return chars
    }
}
