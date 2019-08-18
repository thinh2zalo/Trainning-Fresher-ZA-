//
//  UILabel+TopAlignedLabel.m
//  bacsicObjC
//
//  Created by CPU11606 on 8/16/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "UILabel+TopAlignedLabel.h"

@implementation UILabel (TopAlignedLabel)
- (void)drawTextInRect:(CGRect)rect {
    if (self.text) {
        CGSize labelStringSize = [self.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame), CGFLOAT_MAX)
                                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                      attributes:@{NSFontAttributeName:self.font}
                                                         context:nil].size;
    }
}

@end
