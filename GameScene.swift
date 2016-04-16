//
//  GameScene.swift
//  FlapFlappyFlap
//
//  Created by Notorious MAC on 12/13/15.
//  Copyright (c) 2015 Notorious MAC. All rights reserved.
//

//
//  GameScene.swift
//  FlapFlappyFlap
//
//  Created by Notorious MAC on 12/13/15.
//  Copyright © 2015 Notorious MAC. All rights reserved.
//

//
//  GameScene.swift
//  FlapFlap
//
//  Created by Notorious MAC on 12/13/15.
//  Copyright © 2015 Notorious MAC. All rights reserved.
//

import SpriteKit

struct PhysicsCatagory {
    static let Ghost : UInt32 = 0x1 << 1
    static let Ground : UInt32 = 0x1 << 2
    static let Wall : UInt32 = 0x1 << 3
    
    // bitmask
    static let Score : UInt32 = 0x1<<4
    
    
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var Ground = SKSpriteNode()
    var Ghost = SKSpriteNode()
    var wallPair = SKNode()
    var moveAndRemove = SKAction()
    var gameStarted = Bool() // it will be a true or false statement
    var score = Int()
    let scorelabel = SKLabelNode()
    var death = Bool()
    var restartBtn = SKSpriteNode()
    var x: Double = 2.0
    
    
    
    
    
    func restartGame (){
        
        self.removeAllChildren()
        self.removeAllActions()
        death = false
        gameStarted = false
        score = 0
        createSeene()
        
        
    }
    
    func createSeene(){
        
        
         // print(UIFont.familyNames()) - prints all font names available
        
        
        self.physicsWorld.contactDelegate = self
        
        for i in 0..<99 {        // creates for loop
            let background = SKSpriteNode(imageNamed: "background")
            background.anchorPoint = CGPointZero
            background.position = CGPointMake(CGFloat(i) * self.frame.width, 0)
            background.name = "background"
            background.size = CGSize(width: 1080, height: 800) // fit in 1080X1920 image perfectly
            background.zPosition = 1
            self.addChild(background)
            
            
        }
        
        scorelabel.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2 + self.frame.height/2.5)
        scorelabel.text = "\(score)"
        
        scorelabel.zPosition = 5
        scorelabel.fontName = "04b_19"
        scorelabel.fontSize = 60
        
        
        self.addChild(scorelabel)
        
        
        
        
        Ghost = SKSpriteNode(imageNamed: "Ghost")
        Ghost.size = CGSize(width: 50, height: 60)
        Ghost.position = CGPointMake(self.frame.width / 2 - Ghost.frame.width , self.frame.height / 2)
        Ghost.physicsBody = SKPhysicsBody(circleOfRadius: Ghost.frame.height / 2)
        Ghost.physicsBody?.categoryBitMask = PhysicsCatagory.Ghost
        Ghost.physicsBody?.collisionBitMask = PhysicsCatagory.Ground | PhysicsCatagory.Wall
        Ghost.physicsBody?.contactTestBitMask = PhysicsCatagory.Ground | PhysicsCatagory.Wall | PhysicsCatagory.Score
        Ghost.physicsBody?.affectedByGravity = false
        Ghost.physicsBody?.dynamic = true
        Ghost.zPosition = 3
        
        
        self.addChild(Ghost)
        
        
        
        
        
        Ground = SKSpriteNode(imageNamed: "Ground")
        Ground.setScale(0.5)
        Ground.position = CGPoint(x:self.frame.width / 2 , y: 0 + Ground.frame.height / 2 )
        Ground.physicsBody = SKPhysicsBody(rectangleOfSize: Ground.size)
        Ground.physicsBody?.categoryBitMask = PhysicsCatagory.Ground
        Ground.physicsBody?.collisionBitMask = PhysicsCatagory.Ghost
        Ground.physicsBody?.contactTestBitMask = PhysicsCatagory.Ghost
        Ground.physicsBody?.affectedByGravity = false
        Ground.physicsBody?.dynamic = false
        Ground.zPosition = 7
        
        
        self.addChild(Ground)
        
    }
    
    override func didMoveToView(view: SKView) {
        
        createSeene()
        
        /*
        
        self.physicsWorld.contactDelegate = self
        
        scorelabel.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2 + self.frame.height/2.5)
        scorelabel.text = "\(score)"
        
        scorelabel.zPosition = 5
        scorelabel.color = UIColor.blueColor()
    
        self.addChild(scorelabel)
        
        
        
        
        Ghost = SKSpriteNode(imageNamed: "Ghost")
        Ghost.size = CGSize(width: 60, height: 70)
        Ghost.position = CGPointMake(self.frame.width / 2 - Ghost.frame.width , self.frame.height / 2)
        Ghost.physicsBody = SKPhysicsBody(circleOfRadius: Ghost.frame.height / 2)
        Ghost.physicsBody?.categoryBitMask = PhysicsCatagory.Ghost
        Ghost.physicsBody?.collisionBitMask = PhysicsCatagory.Ground | PhysicsCatagory.Wall
        Ghost.physicsBody?.contactTestBitMask = PhysicsCatagory.Ground | PhysicsCatagory.Wall | PhysicsCatagory.Score
        Ghost.physicsBody?.affectedByGravity = true
        Ghost.physicsBody?.dynamic = true
        Ghost.zPosition = 2
        
        
        
        self.addChild(Ghost)
        
        
        
        
        
        Ground = SKSpriteNode(imageNamed: "Ground")
        Ground.setScale(0.5)
        Ground.position = CGPoint(x:self.frame.width / 2 , y: 0 + Ground.frame.height / 2 )
        Ground.physicsBody = SKPhysicsBody(rectangleOfSize: Ground.size)
        Ground.physicsBody?.categoryBitMask = PhysicsCatagory.Ground
        Ground.physicsBody?.collisionBitMask = PhysicsCatagory.Ghost
        Ground.physicsBody?.contactTestBitMask = PhysicsCatagory.Ghost
        Ground.physicsBody?.affectedByGravity = false
        Ground.physicsBody?.dynamic = false
        Ground.zPosition = 3
        
        
        self.addChild(Ground)
        
        
        */
        
        
    }
    
    func createWalls(){
        
        
        let scoreNode = SKSpriteNode(imageNamed: "Coin")
        scoreNode.size = CGSize(width: 50, height:50)
        scoreNode.position = CGPoint(x: self.frame.width, y: self.frame.height/2)
        scoreNode.physicsBody = SKPhysicsBody(rectangleOfSize: scoreNode.size)
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.dynamic = false
        scoreNode.physicsBody?.categoryBitMask = PhysicsCatagory.Score
        scoreNode.physicsBody?.collisionBitMask = 0
        scoreNode.physicsBody?.contactTestBitMask = PhysicsCatagory.Ghost
        scoreNode.color = SKColor.redColor()
        
        
        
        wallPair = SKNode()
        wallPair.name = "wallPair"
        
        
        let topWall = SKSpriteNode(imageNamed: "Wall")
        let bottomWall = SKSpriteNode(imageNamed: "Wall")
        
        topWall.position = CGPoint(x: self.frame.width , y: self.frame.height / 2 + 350) //350
        bottomWall.position = CGPoint(x: self.frame.width , y: self.frame.height / 2 - 350)
        
        topWall.setScale(0.5)
        bottomWall.setScale(0.5)
        
        topWall.physicsBody = SKPhysicsBody(rectangleOfSize: topWall.size)
        topWall.physicsBody?.categoryBitMask = PhysicsCatagory.Wall
        topWall.physicsBody?.collisionBitMask = PhysicsCatagory.Ghost
        topWall.physicsBody?.contactTestBitMask = PhysicsCatagory.Ghost
        topWall.physicsBody?.affectedByGravity = false
        topWall.physicsBody?.dynamic = false
        
        
        // do the same for bottom wall
        
        bottomWall.physicsBody = SKPhysicsBody(rectangleOfSize: bottomWall.size)
        bottomWall.physicsBody?.categoryBitMask = PhysicsCatagory.Wall
        bottomWall.physicsBody?.collisionBitMask = PhysicsCatagory.Ghost
        bottomWall.physicsBody?.contactTestBitMask = PhysicsCatagory.Ghost
        bottomWall.physicsBody?.affectedByGravity = false
        bottomWall.physicsBody?.dynamic = false
        
        
        topWall.zRotation = CGFloat(M_PI) // rotates top wall by 180 degrees
        
        
        wallPair.addChild(topWall)
        wallPair.addChild(bottomWall)
        
        wallPair.zPosition = 2 // places wall at the back most part of screen display
        
        var randomPosition = CGFloat.random(min: -200, max: 200)
        wallPair.position.y = wallPair.position.y + randomPosition
        wallPair.addChild(scoreNode)
        wallPair.runAction(moveAndRemove)
        
                self.addChild(wallPair)
        
        
    }
    
    
    func createBtn (){
        restartBtn = SKSpriteNode(imageNamed: "restart.png")
        restartBtn.size = CGSize(width: 200, height: 100)
        restartBtn.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        restartBtn.zPosition = 6
        restartBtn.setScale(0)
        
        
        self.addChild(restartBtn)
        restartBtn.runAction(SKAction.scaleTo(1.0, duration: 0.3))
        
        
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let firstBody  = contact.bodyA
        let secondBody = contact.bodyB
        
        
        
        // collision of Ghost and wall ends game
        if firstBody.categoryBitMask == PhysicsCatagory.Ghost && secondBody.categoryBitMask == PhysicsCatagory.Wall || firstBody.categoryBitMask == PhysicsCatagory.Wall && secondBody.categoryBitMask == PhysicsCatagory.Ghost {
            
            
            
            enumerateChildNodesWithName("wallPair", usingBlock: {
                (node, error) in
                node.speed = 0
                self.removeAllActions()
                
            })
            
            if death ==  false{
                death = true
                createBtn()
            }
        }
        
        // collision of Ghost with Ground ends game
        
        
        if firstBody.categoryBitMask == PhysicsCatagory.Ghost && secondBody.categoryBitMask == PhysicsCatagory.Ground || firstBody.categoryBitMask == PhysicsCatagory.Ground && secondBody.categoryBitMask == PhysicsCatagory.Ghost {
            
            
            
            enumerateChildNodesWithName("wallPair", usingBlock: {
                (node, error) in
                node.speed = 0
                self.removeAllActions()
                
            })
            
            if death ==  false{
                death = true
                createBtn()
            }
        }
        

        
        
        // collision of ghost and scoreNode increments the score
        
        if firstBody.categoryBitMask == PhysicsCatagory.Score && secondBody.categoryBitMask == PhysicsCatagory.Ghost{
            score++
            scorelabel.text = "\(score)"
            firstBody.node?.removeFromParent()

            
            
        }else if  firstBody.categoryBitMask == PhysicsCatagory.Ghost && secondBody.categoryBitMask == PhysicsCatagory.Score {
            
            
            score++
            scorelabel.text = "\(score)"
            secondBody.node?.removeFromParent()
            
            
        }
        
        
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if gameStarted == false {
            
            gameStarted = true
            Ground.physicsBody?.affectedByGravity = true
            Ghost.physicsBody?.affectedByGravity = true
            
            
            let spwan = SKAction.runBlock({
                () in
                self.createWalls()
            })
            
            
            let delay = SKAction.waitForDuration(1.8)

            
            // action = spawn(creates wall) then delay
            
            // reapeats action forever REPEATs spwandelay
            
            let spwanDelay = SKAction.sequence([spwan, delay])
            let spwanDelayForever = SKAction.repeatActionForever(spwanDelay)
            self.runAction(spwanDelayForever)
            
            
            var distance = CGFloat(self.frame.width + wallPair.frame.width)
            let movePipes = SKAction.moveByX(-distance, y: 0.0, duration: NSTimeInterval(0.01 * distance))
            let removePipes = SKAction.removeFromParent() // removes pipes
            
            moveAndRemove = SKAction.sequence([movePipes,removePipes])
            
            
           
            Ghost.physicsBody?.velocity = CGVectorMake(0, 0) // doesn't apply velocity to ghost
            Ghost.physicsBody?.applyImpulse(CGVectorMake(0, 35)) // moves by 60 pixels in y axis
            
            
        }else{
            
            if death == true {
                
            }
            else {
            Ghost.physicsBody?.velocity = CGVectorMake(0, 0) // doesn't apply velocity to ghost
            Ghost.physicsBody?.applyImpulse(CGVectorMake(0, 50)) // moves by 60 pixels in y axis
            }
            
        }
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            if death == true {
                
                if restartBtn .containsPoint(location){
                    restartGame()
                }
                
            }
        }
        
        
        
        
    }
    
    override func update(currentTime: NSTimeInterval) {
        
       
        
        if gameStarted == true{
            if death == false {
                enumerateChildNodesWithName("background", usingBlock:({
                    (node,error) in
                    var bg = node as! SKSpriteNode
                    
                    if (self.score) >= 0  {
                        bg.position = CGPoint(x: bg.position.x - 0, y: bg.position.y)
                       
                    }
                   
                    
                   /* if (self.score) >= 15 {
                
                        bg.position = CGPoint(x: bg.position.x - 2, y: bg.position.y)
                        
                        
                    }
                    
                    if (self.score) >= 35 {
                        
                        bg.position = CGPoint(x: bg.position.x - 3, y: bg.position.y)
                        
                        
                    } */

                
                    
                    }))
               
            }
            
        }
        
    }
    
    
}

