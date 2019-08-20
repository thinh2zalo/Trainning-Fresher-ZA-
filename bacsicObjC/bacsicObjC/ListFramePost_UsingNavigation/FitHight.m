//
//  FitHight.m
//  bacsicObjC
//
//  Created by CPU11606 on 8/20/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "FitHight.h"

@implementation FitHight
- (CGSize)sizeThatFits:(CGSize)size
{
    CGSize res = [super sizeThatFits:size];
    
    return CGSizeMake(size.width, res.height);
}
@end
