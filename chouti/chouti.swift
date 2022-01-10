#!/usr/bin/swift
//  chouti
//  Created by pqso on 2022/1/6.
//  Copyright © 2022 pqso. All rights reserved.

import Foundation

struct Response: Codable {
    let data: [Entry]
}

struct  Entry: Codable {
  let title: String
  let originalUrl: String
  let sectionImgUrl: String?
  let sectionName: String?
}

let sectionImgUrl = "https://dig.chouti.com/images/logo-c30a1a3941.png"
let sectionName = "抽屉挂了吗"

var sema = DispatchSemaphore( value: 0 )

if let url = URL(string: "https://m.chouti.com/api/m/link/hot?afterTime=0") {
    URLSession.shared.dataTask(with: url) { data, response, error in
        var array: [[String : String]] = []
        if let data = data {
            let jsonDecoder = JSONDecoder()
            do {
                let res = try jsonDecoder.decode(Response.self, from: data)
                res.data.forEach { entry in
                    array.append([
                        "title": entry.title,
                        "subtitle": entry.sectionName ?? sectionName,
                        "icon": entry.sectionImgUrl ?? sectionImgUrl
                    ])
                }
                
                let items = ["items": array]
                let resultData = try JSONSerialization.data(withJSONObject: items, options: .prettyPrinted)
                print(String(data: resultData, encoding: .utf8)!)
                
            }catch{
                let items = ["items": ["title": error.localizedDescription]]
                print(items)
            }
        }
        sema.signal()
    }.resume()
}

sema.wait()
