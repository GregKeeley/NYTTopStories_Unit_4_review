//
//  NYTTopStoriesAPIClient.swift
//  NYTTopStories_Unit_4_review
//
//  Created by Gregory Keeley on 2/6/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import Foundation
import NetworkHelper

struct NYTTopStoriesAPIClient {
    static func fetchTopStories(for section: String, completion: @escaping (Result<[Article], AppError>) -> ()) {
        let endpoint = "https://api.nytimes.com/svc/topstories/v2/nyregion.json?api-key=\(Config.apiKey)"
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL(endpoint)))
            return
        }
        let request = URLRequest(url: url)
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let articleData):
                do {
                    let topStories = try JSONDecoder().decode(TopStories.self, from: articleData)
                    completion(.success(topStories.results))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
