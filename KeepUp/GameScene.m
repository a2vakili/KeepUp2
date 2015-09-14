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
#import <AVFoundation/AVFoundation.h>

@interface GameScene ()

@property(nonatomic, strong)HeadNode *head;
@property(nonatomic,strong) BallNode *ball;
@property(nonatomic, strong)GroundNode *ground;
@property(nonatomic, strong) SKLabelNode *restartLabel;
@property(nonatomic,assign) int score;
@property(nonatomic,strong) SKLabelNode *scoreLabel;
@property(nonatomic,strong) SKLabelNode *homePageLabel;
@property(nonatomic,assign) BOOL didScorePoint;
@property(nonatomic,assign) int highScore;
@property(nonatomic) SKAction *booSound;
@property(nonatomic) SKAction *cheerSound;
@property(nonatomic) SKAction *hitSound;
@property(nonatomic,assign) BOOL didGameEnd;
@property(nonatomic) AVAudioPlayer *gameMusic;

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
    restartLabel.fontSize = 20;
    restartLabel.position = CGPointMake(self.frame.size.width * 0.9 , self.frame.size.height* 0.9);
    restartLabel.alpha = 0;
    restartLabel.zPosition = 2.0;
    self.restartLabel = restartLabel;
    [self addChild:restartLabel];
    
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    scoreLabel.text = @"Score: ";
    scoreLabel.fontSize = 20;
    scoreLabel.position = CGPointMake(self.frame.size.width/10, self.frame.size.height* 0.9);
    scoreLabel.zPosition = 2.0;
    self.scoreLabel = scoreLabel;
    [self addChild:scoreLabel];
    
    SKLabelNode *pageLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    pageLabel.text = @"Home Page";
    pageLabel.fontSize = 20;
    pageLabel.position = CGPointMake(self.frame.size.width *0.5, self.frame.size.height * 0.9);
    pageLabel.zPosition = 2.0;
    pageLabel.hidden = YES;
    self.homePageLabel = pageLabel;
    [self addChild:pageLabel];
    
    NSURL *url = [[NSBundle mainBundle]URLForResource:@"gameSong" withExtension:@"mp3"];
    NSError *error = nil;
    
    self.gameMusic = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
    self.gameMusic.numberOfLoops = INFINITY;
    [self.gameMusic prepareToPlay];
    
    [self setUpSound];
    
    return self;
    
}


-(void)setUpSound{
    self.booSound = [SKAction playSoundFileNamed:@"boo.wav" waitForCompletion:NO];
    self.cheerSound = [SKAction playSoundFileNamed:@"cheer.wav" waitForCompletion:NO];
    self.hitSound = [SKAction playSoundFileNamed:@"hit.caf" waitForCompletion:NO];
}

-(void)didMoveToView:(SKView *)view{
    
    
    self.ball = [BallNode ballAtPosition:CGPointMake(self.frame.size.width/2 ,self.frame.size.height)];
    
    self.ball.zPosition = 1.0;
    [self addChild:self.ball];
    [self didMakeHead];
    self.physicsWorld.gravity = CGVectorMake(0, -2.2);
    self.didScorePoint = YES;
    self.didGameEnd = NO;
    [self.gameMusic play];
    
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
    
    [self setUpImpulse];
    
    NSLog(@"x: %f y: %f",self.ball.position.x,self.ball.position.y);
    
    
}



// setting up the range and impulses and gravity due to different position there are different impulses
// but the gravity increases as the ball goes higher to accelerate at first pace.

-(void)setUpImpulse {
    
    if (self.ball.position.y >= minPosition1 && self.ball.position.y < maxPosition1) {
        [self.ball.physicsBody applyImpulse:CGVectorMake(0, yDirectionImpulse1)];
        [self runAction:self.hitSound];
        [self.gameMusic play];
        self.didScorePoint = NO;
        self.score ++;
        [self.head setUpAnimations];
    }
    
    
    else if (self.ball.position.y > maxPosition1 && self.ball.position.y < maxPosition2){
        [self.ball.physicsBody applyImpulse:CGVectorMake(0, yDirectionImpulse2)];
        
        [self runAction:self.hitSound];
        [self.gameMusic play];
        self.didScorePoint = NO;
        self.score +=1;
        [self.head setUpAnimations];
        
    }
    
    
    else if (self.ball.position.y >= maxPosition2 && self.ball.position.y < maxPosition3 ) {
        [self.ball.physicsBody applyImpulse:CGVectorMake(0, yDirectionImpulse3)];
        [self runAction:self.hitSound];
        [self.gameMusic play];
        self.didScorePoint = NO;
        self.score ++;
        [self.head setUpAnimations];
    }
    
    
    else if (self.ball.position.y >= maxPosition3 && self.ball.position.y < maxPosition4 ) {
        [self.ball.physicsBody applyImpulse:CGVectorMake(0, yDirectionImpulse3)];
        [self runAction:self.hitSound];
        [self.gameMusic play];
        self.didScorePoint = NO;
        self.score++;
        [self.head setUpAnimations];
    }
    
    else if (self.ball.position.y >= maxPosition4 && self.ball.position.y < maxPosition5)
    {
        [self.ball.physicsBody applyImpulse:CGVectorMake(0, yDirectionImpulse4)];
        [self runAction:self.hitSound];
        [self.gameMusic play];
        self.didScorePoint = NO;
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
    
    if (self.ball.position.y >= self.frame.size.height && self.didScorePoint == NO) {
        self.didScorePoint = YES;
        self.score +=1;
        [self.gameMusic stop];
        [self runAction:self.cheerSound];
    }
    if (self.ball.position.y < 36.0 &&  self.didGameEnd == NO) {
        [self endGame];
        self.didGameEnd = YES;
        
        
        [self runAction:self.booSound];
        
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score:%d",self.score];
}

- (void) endGame;
{
    NSLog(@"Game ended");
    self.restartLabel.alpha = 1.0;
    self.homePageLabel.hidden = NO;
    self.didGameEnd = YES;
    self.head.hidden = YES;
    self.ball.physicsBody.restitution = 0.2;
    [self.gameMusic stop];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger retrievedScore  = [defaults integerForKey:@"highScore"];
    
    
    if (self.score < retrievedScore) {
        self.highScore = (int)retrievedScore;
    }
    else if (self.score > retrievedScore){
        [defaults setInteger:self.score forKey:@"highScore"];
        self.highScore = self.score;
    }
    
}




- (void) restartGame;
{
    self.restartLabel.alpha = 0.0;
    self.homePageLabel.hidden = YES;
    self.head.hidden = NO;
    self.ball.position = CGPointMake(self.frame.size.width/2, self.frame.size.height);
    self.score = 0;
    self.didScorePoint = YES;
    self.didGameEnd = NO;
    [self.gameMusic play];
    
    NSLog(@"TODO: restart game!");
}




@end
