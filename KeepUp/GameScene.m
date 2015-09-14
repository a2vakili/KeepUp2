//
//  GameScene.m
//  KeepUp
//
//  Created by Arsalan Vakili on 2015-08-31.
//  Copyright (c) 2015 Arsalan Vakili. All rights reserved.
//

#import "GameScene.h"
#import "GroundNode.h"
#import "BallNode.h"
#import "HeadNode.h"
#import "HomePageScene.h"
#import "PhysicsWorldConstants.h"

@interface GameScene ()

@property(nonatomic, strong)HeadNode *head;
@property(nonatomic,strong) BallNode *ball;
@property(nonatomic, strong)GroundNode *ground;
@property(nonatomic, strong) SKLabelNode *restartLabel;
@property(nonatomic,assign) int score;
@property(nonatomic,strong) SKLabelNode *scoreLabel;
@property(nonatomic,strong) SKLabelNode *highScoreLabel;
@property(nonatomic,strong) SKLabelNode *homePageLabel;


@end

@implementation GameScene

-(id)initWithSize:(CGSize)size{
    self = [super initWithSize:size];
    
    self.score = 0;
    
    SKSpriteNode *gameBackGroundImage = [SKSpriteNode spriteNodeWithImageNamed:@"goal"];
    gameBackGroundImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    gameBackGroundImage.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    gameBackGroundImage.zPosition = 0.0;
    [self addChild:gameBackGroundImage];
    
    self.ground = [GroundNode groundWithSize:CGSizeMake(self.frame.size.width, 5)];
    [self addChild:self.ground];
    
    
    SKLabelNode *restartLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    restartLabel.text = @"Restart";
    restartLabel.fontSize = 15;
    restartLabel.position = CGPointMake(self.frame.size.width * 0.9 , self.frame.size.height* 0.9);
    restartLabel.alpha = 0;
    restartLabel.zPosition = 2.0;
    self.restartLabel = restartLabel;
    [self addChild:restartLabel];
    
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    scoreLabel.fontSize = 15;
    scoreLabel.position = CGPointMake(self.frame.size.width/10, self.frame.size.height* 0.9);
    scoreLabel.zPosition = 2.0;
    self.scoreLabel = scoreLabel;
    [self addChild:scoreLabel];
    
    SKLabelNode *pageLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    pageLabel.text = @"Home Page";
    pageLabel.fontSize = 15;
    pageLabel.position = CGPointMake(self.frame.size.width *0.9, self.frame.size.height * 0.8);
    pageLabel.zPosition = 2.0;
    pageLabel.hidden = YES;
    self.homePageLabel = pageLabel;
    [self addChild:pageLabel];
    
    SKLabelNode *highScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    highScoreLabel.fontSize = 15;
    highScoreLabel.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    highScoreLabel.zPosition = 1.0;
    highScoreLabel.hidden = NO;
    self.highScoreLabel = highScoreLabel;
    [self addChild:highScoreLabel];
    

    
    
    return self;
    
}


-(void)didMoveToView:(SKView *)view{
    
    
    self.ball = [BallNode ballAtPosition:CGPointMake(self.frame.size.width/2 ,self.frame.size.height)];
    
    self.ball.zPosition = 1.0;
    [self addChild:self.ball];
    [self didMakeHead];
    self.physicsWorld.gravity = CGVectorMake(0, -1.8);
    [self endGame];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint position = [touch locationInNode:self];
    
    
    if ([self.restartLabel containsPoint:position]) {
        [self restartGame];
        
    }
    else if ([self.homePageLabel containsPoint:position]) {
        HomePageScene *homepage = [[HomePageScene alloc]initWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithDuration:1.0];
        [self.view presentScene:homepage transition:transition];
    }
    
    NSLog(@"x: %f y: %f",position.x,position.y);
    [self setUpImpusle];
    
}



// setting up the range and impulses and gravity due to different position there are different impulses
// but the gravity increases as the ball goes higher to accelerate at first pace.

-(void)setUpImpusle {
    
    
    
    if (self.ball.position.y >= minPosition1 && self.ball.position.y < maxPosition1 ) {
        
        [self.ball.physicsBody applyImpulse:CGVectorMake(0, 40)];
        
        if (self.ball.position.y > self.frame.size.height/2 && self.ball.position.y <= self.frame.size.height * 0.60) {
            self.physicsWorld.gravity = CGVectorMake(0.0, -3.5);
        }
        self.score+= 1;
        [self.head setUpAnimations];
    }
    
    
    else if (self.ball.position.y > maxPosition1 && self.ball.position.y < maxPosition2){
        [self.ball.physicsBody applyImpulse:CGVectorMake(0, 100)];
        
            
            if (self.ball.position.y > self.frame.size.height) {
                self.physicsWorld.gravity = CGVectorMake(0, -9.8);
        }
        self.score+= 3;
        [self.head setUpAnimations];
        
    }
    
    
    else if (self.ball.position.y >= maxPosition2 && self.ball.position.y < maxPosition3 ) {
        [self.ball.physicsBody applyImpulse:CGVectorMake(0, 80)];
        
        if (self.ball.position.y > self.frame.size.height * 0.90 && self.ball.position.y <= self.frame.size.height) {
            self.physicsWorld.gravity = CGVectorMake(0, -8.8);
            self.score+= 2;
        }
        
        [self.head setUpAnimations];
       
    }
    
  
    
    else if (self.ball.position.y >= maxPosition3 && self.ball.position.y < maxPosition4 ) {
        [self.ball.physicsBody applyImpulse:CGVectorMake(0, 60)];
        if (self.ball.position.y > self.frame.size.height * 0.80 && self.ball.position.y <= self.frame.size.height * 0.90) {
            self.physicsWorld.gravity = CGVectorMake(0, -6);
        }
        self.score++;
        [self.head setUpAnimations];
    }
    else if (self.ball.position.y >= maxPosition4 && self.ball.position.y < maxPosition5){
        [self.ball.physicsBody applyImpulse:CGVectorMake(0, 55)];
        
      
        if (self.ball.position.y > self.frame.size.height * 0.70 && self.ball.position.y <= self.frame.size.height * 0.80) {
            self.physicsWorld.gravity = CGVectorMake(0, -5);}
        self.score++;
        [self.head setUpAnimations];
    }
    
    
}

-(void)didMakeHead{
    self.head = [HeadNode headAtPosition:CGPointMake(self.frame.size.width/2, 15)];
    self.head.size = CGSizeMake(120 , 120);
    [self addChild:self.head];
    self.head.zPosition = 1.0;
}



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    if (self.ball.position.y < 36.0) {
        [self endGame];
      
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score:%d",self.score];
}

- (void) endGame;
{
    self.restartLabel.alpha = 1.0;
    self.homePageLabel.hidden = NO;
    self.highScoreLabel.hidden = NO;
    // Get the score
    
    
      NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger retrievedScore  = [defaults integerForKey:@"highScore"];
    self.retrieveScore = retrievedScore;
    
    if (self.score < retrievedScore) {
        self.highScoreLabel.text = [NSString stringWithFormat:@"highScore:%ld",(long)retrievedScore];
    }
    else if (self.score > retrievedScore){
       
        [defaults setInteger:self.score forKey:@"highScore"];
        self.highScoreLabel.text = [NSString stringWithFormat:@"highScore:%d",self.score];
    }
}

// ???: how does this get called?
- (void) restartGame;
{
    self.restartLabel.alpha = 0.0;
    self.homePageLabel.hidden = YES;
    self.highScoreLabel.hidden = YES;
    self.ball.position = CGPointMake(self.frame.size.width/2, self.frame.size.height);
    self.score = 0;
    
    NSLog(@"TODO: restart game!");
}


@end
