//
//  HeadNode.h
//  KeepUp
//
//  Created by Arsalan Vakili on 2015-09-01.
//  Copyright (c) 2015 Arsalan Vakili. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface HeadNode : SKSpriteNode

+(instancetype)headAtPosition:(CGPoint)position;


-(void)setUpAnimations;


@end
