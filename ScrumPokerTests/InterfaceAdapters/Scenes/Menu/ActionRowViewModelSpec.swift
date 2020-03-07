//
//  ActionRowViewModelSpec.swift
//  ScrumPokerTests
//
//  Created by Rogelio Kobashi on 2020/03/08.
//  Copyright © 2020 rgkobashi. All rights reserved.
//

@testable import ScrumPoker
import Quick
import Nimble
import UIKit

class ActionRowViewModelSpec: QuickSpec {
    override func spec() {
        var image: UIImage!
        var sut: ActionRowViewModel<UIViewController>!
        
        describe("type") {
            context("when has image") {
                beforeEach {
                    image = UIImage(named: "closeIcon")
                    sut = ActionRowViewModel(text: "text", image: image, action: { _ in })
                }
                it("returns unspecified with the image") {
                    expect {
                        switch sut.type {
                        case .unspecified(let value):
                            return value
                        default:
                            return nil
                        }
                    } == image
                }
            }
            context("when does not have image") {
                beforeEach {
                    sut = ActionRowViewModel(text: "text", image: nil, action: { _ in })
                }
                it("returns unspecified with nil") {
                    expect { () -> UIImage? in
                        switch sut.type {
                        case .unspecified(let value):
                            return value
                        default:
                            fatalError("not supported")
                        }
                    }.to(beNil())
                }
            }
            
        }
    }
}

