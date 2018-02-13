//
//  PersonalInfo.swift
//  KUSBF
//
//  Created by 김지우 on 2017. 12. 29..
//  Copyright © 2017년 jiwoo. All rights reserved.
//

import Foundation

struct TotalInfo : Codable {
    let main_info : MainInfo
    let kusbf : KusbfInfo
}

struct MainInfo : Codable {
    let info : PersonalInfo
    let my_rank : MyRankInfo
    let iin : InInfo
    let out : OutInfo
}

struct PersonalInfo : Codable {
    let my_name : String
    let photo : String
    let my_score : Int
    let my_univ : String
    let fboard : String
    let lboard : String
}

struct MyRankInfo : Codable {
    let all : Double
    let sexual : Double
    let agial : Double
}

struct InInfo : Codable {
    let inrank : Int
    let inun : String
    let inus : Int
    let indn : String
    let inds : Int
}

struct OutInfo : Codable {
    let outrank : Int
    let outun : String
    let outusn : String
    let outus : Int
    let outdn : String
    let outdsn : String
    let outds : Int
}

struct KusbfInfo : Codable {
    let total_score : Int
    let top10 : Top10Info
    let univ_rank : UnivRankInfo
}

struct Top10Info : Codable {
    let names : [String]
    let froms : [String]
}
struct UnivRankInfo :Codable {
    let names : [String]
    let scores : [String]
}
