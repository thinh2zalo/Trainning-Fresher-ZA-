//
//  Contrainner.m
//  CreateUIDemo
//
//  Created by CPU11606 on 8/15/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//



#import "SingleImageCell.h"

@implementation SingleImageCell


- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.thumbnailImg.frame = CGRectMake(PADDING, PADDING, WITDTH_IMG, HEIGHT_IMG);
    NSInteger originXOftimeStamp = self.thumbnailImg.frame.origin.x + 10 + self.thumbnailImg.bounds.size.width;
    self.timeStampLab.frame = CGRectMake(originXOftimeStamp, HEIGHT_VIEW - 30, WIDTH_TIMESTAMP, HEIGHT_TIMESTAMP);
    float originXOfLabel = self.thumbnailImg.frame.origin.x + 10 + self.thumbnailImg.bounds.size.width;
    self.titleLab.frame = CGRectMake(originXOfLabel , self.thumbnailImg.frame.origin.y, self.frame.size.width - originXOfLabel - 10 , HEIGHT_LAB);
    [self.titleLab setNumberOfLines:3];
    [self.titleLab sizeToFit];
}

@end
