//
//  UILabel+TopAlign.m
//  bacsicObjC
//
//  Created by CPU11606 on 8/16/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "UILabel+TopAlign.h"

@implementation UILabel (TopAlign)
-(void)textWithTopAlign:(NSString *)text{
    self.text = text;
    [self setNumberOfLines:0];
    [self sizeToFit];
}

@end
