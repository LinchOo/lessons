//
//  Proxy.swift
//  Proxy
//
//  Created by Олег Коваленко on 20.01.2023.
//

import Foundation

var cacheData: Data?

class Proxy: LoadServiceProtocol {
    private var service: LoadServiceProtocol
    init(service: LoadServiceProtocol) {
        self.service = service
    }
    func loadImage(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        if cacheData == nil {
            service.loadImage(url: url) { data, response, error in
                cacheData = data
                completion(data, response, error)
            }
        }else {
            completion(cacheData, nil, nil)
        }
    }
}
