//
//  HomePageScene.m
//  KeepUp
//
//  Created by Arsalan Vakili on 2015-08-31.
//  Copyright (c) 2015 Arsalan Vakili. All rights reserved.
//

#import "HomePageScene.h"
#import "GameScene.h"
#import <AVFoundation/AVFoundation.h>

@interface HomePageScene ()

@property(nonatomic) AVAudioPlayer *backgroundMusic;
@property(nonatomic,strong) SKLabelNode *startLabel;

@end

@implementation HomePageScene

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"football"];
        background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        [self addChild:background];
        
        SKLabelNode *welcomeLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        welcomeLabel.text = @"KeepUp";
        welcomeLabel.fontSize = 20;
        welcomeLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                            CGRectGetMaxY(self.frame) - 40);
        
        [self addChild:welcomeLabel];
        
        SKLabelNode *startLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        startLabel.text = @"Start Game";
        startLabel.fontSize = 35;
        
        startLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        self.startLabel = startLabel;
        
        [self addChild:startLabel];
        
        
        
        
        NSURL *url = [[NSBundle mainBundle]URLForResource:@"backgroundMusic" withExtension:@"wav"];
        NSError *error = nil;
        
        self.backgroundMusic = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
        self.backgroundMusic.numberOfLoops = INFINITY;
        [self.backgroundMusic prepareToPlay];
        
    }
    return self;
}

-(void)didMoveToView:(SKView *)view{
    
    SKLabelNode *highScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger retrievedScore  = [defaults integerForKey:@"highScore"];
    
    self.highScore = retrievedScore;
    
    
    highScoreLabel.text = [NSString stringWithFormat:@"Highscore: %ld",(long)self.highScore];
    highScoreLabel.fontSize = 30;
    highScoreLabel.fontColor = [UIColor redColor];
    
    highScoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 80);
    
    [self addChild:highScoreLabel];
    
    [self.backgroundMusic play];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    
    CGPoint position = [touch locationInNode:self];
    
    if ([self.startLabel containsPoint:position]) {
        GameScene *scene = [[GameScene alloc]initWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithColor:[UIColor redColor] duration:0.2];
        
        [self.backgroundMusic stop];
        
        [self.view presentScene:scene transition:transition];
        
        
    }
    
    
    
}

@end
