//
//  UIView+Padding.m
//  bacsicObjC
//
//  Created by Steve on 9/23/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "UIView+Padding.h"

@implementation UIView (Padding)

- (void) paddingLeftAndRight:(CGFloat) constant {
    [self.leftAnchor constraintEqualToAnchor:self.superview.leftAnchor constant:constant].active = true;
    [self.rightAnchor constraintEqualToAnchor:self.superview.rightAnchor constant: - constant].active = true;
}

- (void) paddingTopAndBotton:(CGFloat) constant {
    [self.topAnchor constraintEqualToAnchor:self.superview.topAnchor constant:constant].active = true;
    [self.bottomAnchor constraintEqualToAnchor:self.superview.bottomAnchor constant: - constant].active = true;
}

@end
