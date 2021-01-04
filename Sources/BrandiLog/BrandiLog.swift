//
//  BrandiLog.swift
//  BrandiLog
//
//  Created by Ryan Lee on 29/06/2018.
//  Copyright © 2018 Brandi. All rights reserved.
//

import Foundation

open class BrandiLog {
    
    /// 디버그모드 선언. 로그를 출력하고자 하는 경우 true, 로그를 출력하지 않고자 하는 경우 false로 지정
    private static var isDebugMode: Bool = true
    
    /**
     logLevel
     
     - VERBOSE: 일반 레벨
     - INFO:    정보 레벨
     - WARNING: 경고 레벨
     - ERROR:   에러 레벨
     */
    public enum LOG_LEVEL: String {
        case VERBOSE = "###_BRANDI_LOG_###"
        case INFO = "###_BRANDI_INFO_###"
        case WARNING = "###_BRANDI_WARNING_###"
        case ERROR = "###_BRANDI_ERROR_###"
        case RAW = "###_BRANDI_RAW_OBJECT_###"
    }
    
    public static let STRING_LOG_EMPTYSPACE = " "
    public static let STRING_LOG_TAG_MESSAGE = "MESSAGE:"
    
    public static func setDebugMode(_ isDebugMode: Bool) {
        self.isDebugMode = isDebugMode
    }
    
    /**
     일반 로그를 출력한다
     
     - parameter logString: 로그내용
     */
    public static func verboseLog(_ logString: String) {
        let verboseLogString: String = String(LOG_LEVEL.VERBOSE.rawValue) + makeLogString(logString)
        self.printLog(verboseLogString)
    }
    
    /**
     정보 로그를 출력한다
     
     - parameter logString: 로그내용
     */
    public static func infoLog(_ logString: String) {
        let infoLogString: String = String(LOG_LEVEL.INFO.rawValue) + makeLogString(logString)
        self.printLog(infoLogString)
    }
    
    /**
     경고 로그를 출력한다
     
     - parameter logString: 로그내용
     */
    public static func warningLog(_ logString: String) {
        let warningLogString: String = String(LOG_LEVEL.WARNING.rawValue) + makeLogString(logString)
        self.printLog(warningLogString)
    }
    
    /**
     에러 로그를 출력한다
     
     - parameter logString: 로그내용
     */
    public static func errorLog(_ logString: String) {
        let errorLogString: String = String(LOG_LEVEL.ERROR.rawValue) + makeLogString(logString)
        self.printLog(errorLogString)
    }
    
    /**
     에러 로그를 발생 위치와 함께 출력한다
     
     - parameter logString:    로그내용
     - parameter fileName:     에러가 발생한 파일 이름 (__FILE__ || #file)
     - parameter functionName: 에러가 발생한 Function 이름 (__FUNCTION__ || #function)
     - parameter line:         에러가 발생한 코드 라인 ( __LINE__ || #line)
     */
    public static func errorLogWithLocation(_ logString: String, fileName: String, functionName: String, line: Int) {
        let errorLogString: String = String(LOG_LEVEL.ERROR.rawValue) + makeLogString(logString) + "@@FUNCTION: \(functionName), @@LINE: \(line), @@FILE: \(fileName)"
        self.printLog(errorLogString)
    }
    
    /**
     각 로그레벨에 맞는 로그를 출력한다
     
     - parameter logLevel:  로그레벨 (LOG_LEVEL)
     - parameter logString: 로그내용
     */
    public static func printLog(_ logLevel: LOG_LEVEL, logString: String) {
        if self.isDebugMode {
            switch logLevel {
            case .VERBOSE:
                verboseLog(logString)
            case .INFO:
                infoLog(logString)
            case .WARNING:
                warningLog(logString)
            case .ERROR:
                errorLog(logString)
            case .RAW:
                infoLog(logString)
            }
        }
    }
    
    /**
     로그스트링 조합 Function
     
     - parameter logString: 로그내용
     
     - returns: 조합된 로그 String
     */
    private static func makeLogString(_ logString: String) -> String {
        let log: String = STRING_LOG_EMPTYSPACE + STRING_LOG_TAG_MESSAGE + STRING_LOG_EMPTYSPACE + logString + STRING_LOG_EMPTYSPACE
        return log
    }
    
    /**
     로그를 출력한다
     
     - parameter logString: 로그내용
     */
    private static func printLog(_ string: String) {
        if isDebugMode {
            print(string)
        }
    }
}
