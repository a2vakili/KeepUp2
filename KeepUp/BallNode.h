//
//  BallNode.h
//  KeepUp
//
//  Created by Arsalan Vakili on 2015-08-31.
//  Copyright (c) 2015 Arsalan Vakili. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface BallNode : SKSpriteNode

+(instancetype)ballAtPosition:(CGPoint)position;

-(void)moveTowardPosition: (CGPoint) position;

@end
