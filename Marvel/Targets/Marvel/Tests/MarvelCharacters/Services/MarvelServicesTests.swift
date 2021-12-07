import Foundation
import XCTest
@testable import Marvel

final class MarvelServicesTests: XCTestCase {
  func test_successParseResponseWithParseHelper_MarvelCharacters() {
    //given
    let fileName = "marvelCharacters"
    //when
    let response: Result<MarvelCharactersResponse,NetworkError> = TestUtils.loadLocalJson(fileName: fileName)
    //then
    switch response {
    case .success(let result):
      XCTAssertNotNil(result.data.results)
    case .failure(let error):
      XCTFail("Error decoding Object: \(error)")
    }
  }

  func test_successParseResponseWithParseHelper_MarvelCharacterDetail() {
    //given
    let fileName = "marvelCharacterDetail"
    //when
    let response: Result<MarvelCharactersResponse,NetworkError> = TestUtils.loadLocalJson(fileName: fileName)
    //then
    switch response {
    case .success(let result):
      XCTAssertNotNil(result.data.results)
    case .failure(let error):
      XCTFail("Error decoding Object: \(error)")
    }
  }

  // MARK: - Network dependency
  func test_succesGettingMarvelCharacters() {
    //given
    let network = MarvelCharactersServicesManager()
    //when
    network.marvelCharacters { result in
      //then
      switch result {
      case .success(let response):
        XCTAssertNotNil(response?.data.results)
      case .failure(let error):
        XCTFail("Error decoding Object: \(error)")
      }
    }
  }

  func test_succesGettingMarvelCharacterDetail() {
    //given
    let characterId = "1011334" //3-D MAN
    let network = MarvelCharactersServicesManager()
    //when
    network.marvelCharacterDetail(id: characterId) { result in
      //then
      switch result {
      case .success(let response):
        XCTAssertNotNil(response?.data.results)
      case .failure(let error):
        XCTFail("Error decoding Object: \(error)")
      }
    }
  }

}
