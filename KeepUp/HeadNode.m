//
//  HeadNode.m
//  KeepUp
//
//  Created by Arsalan Vakili on 2015-09-01.
//  Copyright (c) 2015 Arsalan Vakili. All rights reserved.
//

#import "HeadNode.h"

@interface HeadNode ()


@end

@implementation HeadNode


+(instancetype)headAtPosition:(CGPoint)position{
    
    HeadNode *head = [HeadNode spriteNodeWithImageNamed:@"zidane1"];
    head.position = position;
    head.name = @"Zidane";
    return head;
}


//+(instancetype)head2AtPosition:(CGPoint)position{
//    HeadNode *head = [HeadNode spriteNodeWithImageNamed:@"zidane2"];
//    head.position = position;
//    head.name = @"Zidane2";
//    return head;
//}
-(void)setUpAnimations{
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"zidane2"],
                          [SKTexture textureWithImageNamed:@"zidane1"]];
    
    SKAction *faceAction = [SKAction animateWithTextures:textures timePerFrame:0.5];
    SKAction *animateFace =  [SKAction repeatAction:faceAction count:1];
    [self runAction:animateFace];
}

@end
