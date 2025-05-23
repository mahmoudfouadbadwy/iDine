//
//  Helper.swift
//  A small collection of quick helpers to avoid repeating the same old code.
//
//  Created by Paul Hudson on 23/06/2019.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String) async throws -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            throw("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            throw("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()

        guard let loaded = try? decoder.decode(T.self, from: data) else {
            throw("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
}

extension String: @retroactive Error {}
