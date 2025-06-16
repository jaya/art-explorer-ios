//
//  ArtExplorerUITests.swift
//  ArtExplorerUITests
//
//  Created by Thalisson Melo on 15/06/25.
//

import XCTest

final class ArtExplorerUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
    }

    func testToggleFavoritesAndBack() throws {
        let navigationTitle = app.navigationBars.firstMatch
        let toggleButton = app.buttons.element(matching: .button, identifier: "Ver Favoritos")

        XCTAssertTrue(navigationTitle.waitForExistence(timeout: 5))
        XCTAssertTrue(navigationTitle.staticTexts["Art Explorer"].exists)

        let firstCell = app.scrollViews.children(matching: .other).element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5))

        toggleButton.tap()

        XCTAssertTrue(navigationTitle.staticTexts["Favoritos"].waitForExistence(timeout: 5))

        app.buttons["Ver Tudo"].tap()
        XCTAssertTrue(navigationTitle.staticTexts["Art Explorer"].waitForExistence(timeout: 5))
    }
    
    func testShowsErrorOnInitialLoadFailure() throws {
        let errorApp = XCUIApplication()
        errorApp.launchArguments = ["--uitesting-error"]
        errorApp.launch()

        let errorText = errorApp.staticTexts["Erro ao carregar obras: Erro simulado"]
        let retryButton = errorApp.buttons["Tentar novamente"]

        XCTAssertTrue(errorText.waitForExistence(timeout: 3), "Mensagem de erro não apareceu na tela")
        XCTAssertTrue(retryButton.exists, "Botão de tentar novamente não apareceu")
    }
    
    func testToggleFavoriteInsideDetail() throws {
        let app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()

        let scroll = app.scrollViews.firstMatch
        XCTAssertTrue(scroll.waitForExistence(timeout: 5))

        let firstCell = scroll.otherElements.children(matching: .other).element(boundBy: 0)
        XCTAssertTrue(firstCell.waitForExistence(timeout: 5), "Primeira célula não apareceu a tempo")

        while !firstCell.isHittable {
            scroll.swipeUp()
            sleep(1)
        }

        firstCell.tap()

        let title = app.staticTexts["detailTitle"]
        XCTAssertTrue(title.waitForExistence(timeout: 5), "Título da obra não apareceu")

        let favoriteButton = app.buttons["favoriteButton"]
        XCTAssertTrue(favoriteButton.waitForExistence(timeout: 5))

        XCTAssertTrue(favoriteButton.label.contains("Adicionar"))
        favoriteButton.tap()
        XCTAssertTrue(favoriteButton.label.contains("Remover"))
        favoriteButton.tap()
        XCTAssertTrue(favoriteButton.label.contains("Adicionar"))

        app.swipeDown()
    }
}
