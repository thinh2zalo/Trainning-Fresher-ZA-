//
//  UILabel+UtilOfLabel.m
//  bacsicObjC
//
//  Created by CPU11606 on 8/20/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "UILabel+UtilOfLabel.h"

@implementation UILabel (UtilOfLabel)
- (void)heightToFit {
    
    CGSize maxSize = CGSizeMake(self.frame.size.width, CGFLOAT_MAX);
    CGSize textSize = [self.text sizeWithFont:self.font constrainedToSize:maxSize lineBreakMode:self.lineBreakMode];
    
    CGRect labelRect = self.frame;
    labelRect.size.height = textSize.height;
    [self setFrame:labelRect];
}
@end
