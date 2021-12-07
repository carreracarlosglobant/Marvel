//
//  MarvelCharacters.swift
//  Marvel
//
//  Created by Juan Carlos  Carrera on 02/12/21.
//  Copyright © 2021 tuist.io. All rights reserved.
//

import Foundation


struct MarvelCharactersResponse: Decodable {
  let code: Int?
  let status: String?
  let copyright: String?
  let attributionText: String?
  let attributionHTML: String?
  let etag: String?
  let data: InfoData
}

struct InfoData: Decodable {
  let offset: Int
  let limit: Int
  let total: Int
  let count: Int
  let results: [MarvelCharacter]
}

struct MarvelCharacter: Decodable {
  let id: Int
  let name: String
  let description: String
  let modified: String
  let thumbnail: Thumbnail
  let resourceURI: String
  let comics: Resources
  let series: Resources
  let stories: Resources
  let events: Resources
  let urls: [UrlData]
}

struct Thumbnail: Decodable {
  let path: String
  let extensionString: String

  enum CodingKeys: String, CodingKey {
    case path
    case extensionString = "extension"
  }
}

struct Resources: Decodable {
  let available: Int
  let collectionURI: String
  let items: [Item]
  let returned: Int?
}

struct Item: Decodable {
  let resourceURI: String
  let name: String
  let type: String?
}

struct UrlData: Decodable {
  let type: String
  let url: String
}


