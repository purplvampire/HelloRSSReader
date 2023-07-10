//
//  RSSDownloader.swift
//  HelloRSSReader
//
//  Created by 陳信彰 on 2023/7/10.
//

import Foundation

class RSSDownloader {
    
    func download(rssURL: URL) {
        
        let request = URLRequest(url: rssURL)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                // ...
            }
            
        }
        task.resume()
    }
    
    
}
