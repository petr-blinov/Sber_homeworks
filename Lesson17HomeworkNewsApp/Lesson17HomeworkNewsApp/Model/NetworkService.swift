//
//  NetworkService.swift
//  Lesson17HomeworkNewsApp
//
//  Created by Петр Блинов on 04.06.2021.
//

import Foundation

class NetworkService {
    
    private let session: URLSession = .shared
    
    private let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
//         добавляем конвертацию из снейк кейса - в нашем API она не нужна, это чтобы запомнить как это работает
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    // Лайфхак - добавляем деинит чтобы проверить не создали ли мы случайно retain cycle
    deinit {
        print("deinit NetworkService")
    }
}

extension NetworkService: NetworkServiceProtocol {
   
    typealias Handler = (Data?, URLResponse?, Error?) -> Void
    
    
    // MARK: - Загружаем статью
    func getArticles(completion: @escaping (GetAPIResponse) -> Void) {
        
        // URL request
        
//        var components = URLComponents(string: Constants.APIMethods.getTopHeadlines)
//        components?.queryItems = [URLQueryItem(name: "country", value: "us")]
//
//        guard let url = components?.url
//        else { completion(.failure(.network)); return }
//
       
        guard let url = URL(string: "\(Constants.APIMethods.getTopHeadlines)?country=us&apiKey=\(Constants.Authorization.apiKey)")
        else { completion(.failure(.unknown)); return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
//        request.addValue(Constants.Authorization.apiKey, forHTTPHeaderField: "X-Api-Key")
//        request.addValue(Constants.Authorization.apiKey, forHTTPHeaderField: "Authorization")
        
        
//         Completion hadler
        let handler: Handler = { rawData, response, taskError in
            do {
                let data = try self.httpResponse(data: rawData, response: response)
                print(data)
                let response = try
                    self.decoder.decode(Get1Response.self, from: data)
                completion(.success(response))
                print("Данные успешно раскодированы")

                
            } catch let error as NetworkServiceError {
                completion(.failure(error))
                print("Ошибка нетворк сервиса")

            } catch {
                completion(.failure(.unknown))
                print("В хэндлере ловится unknown ошибка")
            }
        }
        // call
        session.dataTask(with: request, completionHandler: handler).resume()
        
    }
    
    // MARK: - Загружаем картинку
    func loadImage(with model: Get2ArticleDataResponse, completion: @escaping (Data?) -> Void) {
        
        // request
        if let imageUrl = model.urlToImage {
            let imageUrlWithSize = imageUrl.replacingOccurrences(of: "{width}x{height}", with: "300x200")
            let url = URL(string: imageUrlWithSize)
            let request = URLRequest(url: url!, cachePolicy: .returnCacheDataElseLoad)
            
        // handler
            let dataTask = session.dataTask(with: request) { (data, responce, error) in
              do {
                let data = try self.httpResponse(data: data, response: responce)
                completion(data)
              } catch {
                completion(nil)
              }
            }.resume()
        } else {
            completion(nil); return}
    }
    

//  Добавляем проверку на то какой пришел статус код: если в диапазоне 200-300, то все ок; если вне этого диапазона, то ошибка.
    private func httpResponse(data: Data?, response: URLResponse?) throws -> Data {
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode),
              let data = data else {
            throw NetworkServiceError.network
        }
        return data
    }
}
