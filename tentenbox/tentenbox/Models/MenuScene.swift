//
//  MenuScene.swift
//  tentenbox
//
//  Created by Mikhail Kuzmenko on 3/23/18.
//  Copyright © 2018 Mikhail Kuzmenko. All rights reserved.
//

import SpriteKit
import GameplayKit
import FontAwesomeKit

protocol MenuSceneDelegate: class {
    func playGamePressed()
}

class MenuScene: SKScene {

    weak var sceneDelegate: MenuSceneDelegate?

    let playButtonTex = SKTexture(image: FAKFontAwesome.playIcon(withSize: 60).image(with: CGSize(width: 60, height: 60)))
    lazy var playButton: SKSpriteNode = {
        let node = SKSpriteNode(texture: playButtonTex)
        node.position = CGPoint(x: frame.midX, y: frame.midY)
        return node
    }()

    override func didMove(to view: SKView) {
        backgroundColor = .brown
        addChild(playButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = atPoint(location)
        if node == playButton {
            sceneDelegate?.playGamePressed()
        }
    }
}
