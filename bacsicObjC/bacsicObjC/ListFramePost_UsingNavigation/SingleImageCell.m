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
    float thumbnailImgWidth = (SCREEN_MAIN_WIDTH - 2 * ALIGN_LEFT - SPACE_THUMBNAIL_LABEL * 2) / 3;
    float thumbnailImgHeight  = (thumbnailImgWidth / 4) * 3;
 
    self.thumbnailImg.frame = CGRectMake(ALIGN_LEFT, ALIGN_TOP, thumbnailImgWidth, thumbnailImgHeight);
    float thumbnailImgX = self.thumbnailImg.frame.origin.x;
    float thumbnailImgY = self.thumbnailImg.frame.origin.y;
    
    float originXOftimeStamp = thumbnailImgX + thumbnailImgWidth + SPACE_THUMBNAIL_LABEL;

    self.timeStampLab.frame = CGRectMake(originXOftimeStamp, thumbnailImgY + thumbnailImgHeight - 2 * HEIGHT_TIMESTAMP , WIDTH_TIMESTAMP, HEIGHT_TIMESTAMP);
    
    self.titleLab.frame = CGRectMake(originXOftimeStamp, thumbnailImgY, SCREEN_MAIN_WIDTH - self.timeStampLab.frame.origin.x - 10 , thumbnailImgHeight);
    [self.titleLab sizeToFit];

    
}
+ (float)heightOfCell {
    float thumbnailImgWidth = (SCREEN_MAIN_WIDTH - 2 * ALIGN_LEFT - SPACE_THUMBNAIL_LABEL * 2) / 3;
    float thumbnailImgHeight  = (thumbnailImgWidth / 4) * 3;
    return thumbnailImgHeight + 2 * ALIGN_TOP ;
}
@end
