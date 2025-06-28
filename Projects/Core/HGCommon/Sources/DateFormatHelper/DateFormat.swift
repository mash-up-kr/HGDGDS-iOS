//
//  DateFormat.swift
//  HGCommon
//
//  Created by iOS신상우 on 5/26/25.
//

import Foundation

public enum DateFormat: String {
    /// 년.월.일
    case yyyyMMdd = "yyyy.MM.dd"
    
    /// 년-월-일
    case yyyyMMddDash = "yyyy-MM-dd"

    /// 한국어 년월일 (yyyy년 MM월 dd일)
    case yyyyMMddKorean = "yyyy년 MM월 dd일"
    
    /// 한국어 년월일요일 (yyyy년 MM월 dd일 (EE))
    case yyyyMMddEEKorean = "yyyy년 MM월 dd일 (EE)"

    /// 한국어 년월일 (yyyy년 M월 d일)
    case yyyyMdKorean = "yyyy년 M월 d일"
    
    /// 한국어 년월일 | 오전/오후 시분 (yyyy년 MM월 dd일 | 오후 HH시 mm분)
    case yyyyMMddHHmmKorean = "yyyy년 MM월 dd일 | a HH시 mm분"
    
    /// 한국어 년월일 | 오전/오후 시 (yyyy년 MM월 dd일 | 오후 HH시)
    case yyyyMMddHHKorean = "yyyy년 MM월 dd일 | a HH시"

    /// 한국어 월일 (MM월 dd일)
    case MMddKorean = "MM월 dd일"
    
    /// 년.월
    case yyyyMM = "yyyy.MM"

    /// 월.일
    case MMdd = "MM.dd"
    
    /// 월.일
    case Mdd = "M.dd"
    
    /// 시
    case HH = "HH"

    /// 년.월.일 시:분:초
    case dateTime = "yyyy.MM.dd HH:mm:ss"

    /// 년.월.일 시:분
    case yyyyMMddHHmm = "yyyy.MM.dd HH:mm"
    
    /// 년-월-일 시:분
    case yyyyMMddHHmmDash = "yyyy-MM-dd HH:mm"

    /// 년.월.일 오전/오후 시:분
    case yyyyMMddahhmm = "yyyy.MM.dd a hh:mm"

    /// 년.월.일 오전/오후 시(24):분
    case yyyyMMddaHHmm = "yyyy.MM.dd a HH:mm"

    /// 시:분:초
    case HHmmss = "HH:mm:ss"

    /// 시:분
    case HHmm = "HH:mm"

    /// 오전/오후 시:분
    case ahhmm = "a hh:mm"
    
    /// 오전/오후 hh시 mm분
    case ahhmmKorean = "a hh시 mm분"

    /// 축약 요일 (월, 화)
    case ee = "EE"

    /// 서버 날짜, 시간 (년-월-일 시:분:초)
    case serverDateTime = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
    
    case iso8601ms = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    case iso8601 = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    /// 월-일 시:분
    case MMddaHHmm = "MM.dd a HH:mm"
}
