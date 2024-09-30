//
//  PickerItems.swift
//  StockWatcherApp
//
//  Created by Nikos Stauropoulos on 02.09.24.
//

import Foundation

// All the picker item enums

enum HotListsPickerItems:String,CaseIterable{
    case mostActivelyTraded = "Most Traded"
    case gainers = "Gainers"
    case losers = "Losers"
    
}

enum DetailsViewPickerItems:String,CaseIterable{
    case profile = "Profile"
    case news = "News"
}

enum ChartTimeframes:String,CaseIterable{
    case oneMinute = "1min"
    case fiveMinutes = "5min"
    case thirtyMinutes = "30min"
    case fifthteenMinutes = "15min"
    case oneHour = "1hour"
    case fourHours = "4hour"
    
    var buttonLabels:String{
        switch self {
        case .oneMinute:
            "1D"
        case .fiveMinutes:
            "1W"
        case .thirtyMinutes:
            "1M"
        case .fifthteenMinutes:
            "3M"
        case .oneHour:
            "4M"
        case .fourHours:
            "6M"
        }
    }
}

enum ProfileIcons:String,CaseIterable{

    case cat
    case dog
    case bug
    case ant
    case fish
    case lizard
    case hare
    case tortoise
    case bird
    case paw
    case teddybear
    
    var iconName:String{
        
        switch self {
        case .cat:
            "cat.fill"
        case .dog:
            "dog.fill"
        case .bug:
            "ladybug.fill"
        case .ant:
            "ant.fill"
        case .fish:
            "fish.fill"
        case .lizard:
            "lizard.fill"
        case .hare:
            "hare.fill"
        case .tortoise:
            "tortoise.fill"
        case .bird:
            "bird.fill"
        case .paw:
            "pawprint.fill"
        case .teddybear:
            "teddybear.fill"
        }
    }    
}

enum StockExchange: String, CaseIterable {
    
    case nyse = "NYSE"
    case nasdaq = "NASDAQ"
    case lse = "LSE"
    case euronext = "EURONEXT"
    case amex = "AMEX"
    case tsx = "TSX"
    case hkse = "HKSE"
    case jpx = "JPX"
    case cboe = "CBOE"
    case ams = "AMS"
    case aqs = "AQS"
    case asx = "ASX"
    case ath = "ATH"
    case ber = "BER"
    case bme = "BME"
    case bru = "BRU"
    case bse = "BSE"
    case bud = "BUD"
    case bue = "BUE"
    case cai = "CAI"
    case cnq = "CNQ"
    case cph = "CPH"
    case dfm = "DFM"
    case doh = "DOH"
    case dus = "DUS"
    case dxe = "DXE"
    case etf = "ETF"
    case ham = "HAM"
    case hel = "HEL"
    case ice = "ICE"
    case iob = "IOB"
    case ist = "IST"
    case jkt = "JKT"
    case jnb = "JNB"
    case kls = "KLS"
    case koe = "KOE"
    case ksc = "KSC"
    case kuw = "KUW"
    case mcx = "MCX"
    case mex = "MEX"
    case mil = "MIL"
    case mun = "MUN"
    case neo = "NEO"
    case nse = "NSE"
    case nze = "NZE"
    case osl = "OSL"
    case otc = "OTC"
    case pnk = "PNK"
    case pra = "PRA"
    case ris = "RIS"
    case sao = "SAO"
    case sau = "SAU"
    case ses = "SES"
    case set = "SET"
    case sgo = "SGO"
    case shh = "SHH"
    case shz = "SHZ"
    case six = "SIX"
    case sto = "STO"
    case stu = "STU"
    case tai = "TAI"
    case tlv = "TLV"
    case tsxv = "TSXV"
    case two = "TWO"
    case vie = "VIE"
    case vse = "VSE"
    case wse = "WSE"
    case xetra = "XETRA"
}
