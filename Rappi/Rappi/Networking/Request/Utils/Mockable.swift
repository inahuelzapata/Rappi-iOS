//
//  Mockable.swift
//  Rappi
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Alamofire
import Foundation

 protocol FileBundle {
    var filename: String { get }
}

 protocol Mockable {
    var mockData: Data { get }

    var shouldSucceed: Bool { get }

    var dataResponse: DataResponse<Any> { get }

    func stubJSONData(file: FileBundle, bundle: Bundle) throws -> Data
}

 extension Mockable {
    var dataResponse: DataResponse<Any> {
        return DataResponse<Any>(request: nil,
                                 response: nil,
                                 data: self.mockData,
                                 result: self.shouldSucceed ? .success(self.mockData.encodeToDict())
                                    : .failure(NetworkingError.parsing))
    }

    func stubJSONData(file: FileBundle, bundle: Bundle = .main) throws -> Data {
        do {
            guard let jsonFileURL = bundle.url(forResource: file.filename, withExtension: "json") else {
                NSLog("No JSON file found for \(file.filename)")
                throw NetworkingError.unwrap
            }

            let data = try Data(contentsOf: jsonFileURL)

            return data
        } catch {
            throw error
        }
    }
}
