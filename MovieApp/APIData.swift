//
//  APIData.swift
//  MovieApp
//
//  Created by Nguyen Thanh Duc on 11/7/16.
//  Copyright © 2016 NguyenThanhDuc. All rights reserved.
//

import Foundation

enum APIOption {
  case cinemas
  case moviesList
  case movieDetail
  case movieTrailer
  case scheduleByMovie
  case scheduleByCinema
  case newsList
  case newsDetail
  
  func getPath() -> String {
    switch self {
    case .cinemas:
      return "cinema/list"
    case .moviesList:
      return "film/list"
    case .movieDetail:
      return "film/detail"
    case .movieTrailer:
      return "film/trailer"
    case .scheduleByMovie:
      return "session/cinema"
    case .scheduleByCinema:
      return "session/film"
    case .newsList:
      return "news/list"
    case .newsDetail:
      return "news/detail"
    }
  }
}

class APIData {
  private let md5Code = "GVlRhvnZt0Z4WF4NrfsQXwZh"
  let base: String
  let version: String
  let option: APIOption
  
  init(version: String, option: APIOption) {
    self.base = "http://mapp.123phim.vn/android"
    self.version = version
    self.option = option
  }
  
  func getAPIPath() -> String {
    return "\(base)/\(version)/\(option.getPath())"
  }
  
  func getToken() -> String {
    return "\(getHash()) \(getCurrentUnixTimestamp())"
  }
  
  func getCurrentUnixTimestamp() -> Double {
    return floor(Date().timeIntervalSince1970)
  }
  
  private func getHash() -> String {
    let stringToHash = "\(md5Code)\(getCurrentUnixTimestamp())"
    return md5(stringToHash)
  }
  
  // Convert String to MD5
  // http://stackoverflow.com/questions/32163848/how-to-convert-string-to-md5-hash-using-ios-swift
  func md5(_ string: String) -> String {
    
    let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
    var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
    CC_MD5_Init(context)
    CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
    CC_MD5_Final(&digest, context)
    context.deallocate(capacity: 1)
    var hexString = ""
    for byte in digest {
      hexString += String(format:"%02x", byte)
    }
    
    return hexString
  }
}
