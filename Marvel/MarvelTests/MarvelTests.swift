//
//  MarvelTests.swift
//  MarvelTests
//
//  Created by Vinicius Minozzi on 03/07/2018.
//  Copyright © 2018 Vinicius Minozzi. All rights reserved.
//

import XCTest
@testable import Marvel

class MarvelTests: XCTestCase {
    
    let presenter = HomePresenter(interactor: MockedHomeInteractor())
    
    override func setUp() {
        super.setUp()
        presenter.contentType = .home
        presenter.load()
    }
    
    func testShouldValidateNumberOfSections() {
        XCTAssertEqual(presenter.numberOfSections(), 1)
    }
    
    func testShouldValidateNumberOfItems() {
        XCTAssertEqual(presenter.numberOfItems(), presenter.interactor.characters.count)
    }
    
    func testShouldValidateCharacterDTO() {
        XCTAssertEqual(presenter.getCharacterDTO(index: 0).id, 1011334)
        XCTAssertEqual(presenter.getCharacterDTO(index: 0).name, "3-D Man")
        XCTAssertEqual(presenter.getCharacterDTO(index: 0).thumbnail, "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")
    }
    
    func testShouldValidateFavoriteCharacter() {
        presenter.didFavorite(characterId: 1011334)
        presenter.contentType = .favorites
        XCTAssertEqual(presenter.getCharacterDTO(index: 0).name, "3-D Man")
        XCTAssertEqual(presenter.getCharacterDTO(index: 0).name, "3-D Man")
        XCTAssertEqual(presenter.getCharacterDTO(index: 0).thumbnail, "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784.jpg")
    }
    
    func testShouldValidateUnfavoriteCharacter() {
        presenter.contentType = .favorites
        presenter.didFavorite(characterId: 1011334)
        XCTAssertEqual(presenter.numberOfItems(), 0)
    }
}
