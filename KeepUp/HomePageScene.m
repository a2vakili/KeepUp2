//
//  HomePageScene.m
//  KeepUp
//
//  Created by Arsalan Vakili on 2015-08-31.
//  Copyright (c) 2015 Arsalan Vakili. All rights reserved.
//

#import "HomePageScene.h"
#import "GameScene.h"

@interface HomePageScene ()

@property(nonatomic,strong) SKLabelNode *startLabel;

@end

@implementation HomePageScene

-(void)didMoveToView:(SKView *)view{
    
    
    
    
    
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"football"];
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:background];
    
    
    
    SKLabelNode *welcomeLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    welcomeLabel.text = @"Welcome to keep Up Game";
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
    
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    scoreLabel.text = @"Score History";
    scoreLabel.fontSize = 35;
    
    scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame) + 80);
    
    [self addChild:scoreLabel];
    

    
   
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint position = [touch locationInNode:self];
    
    if ([self.startLabel containsPoint:position]) {
        GameScene *scene = [[GameScene alloc]initWithSize:self.frame.size];
        SKTransition *transition = [SKTransition fadeWithColor:[UIColor redColor] duration:0.2];
        [self.view presentScene:scene transition:transition];
    }
  
}

@end
