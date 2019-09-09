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
    float thumbnailImgWidth = (self.frame.size.width - 2 * ALIGN_LEFT - SPACE_THUMBNAIL_LABEL * 2) / 3;
    float thumbnailImgHeight  = (thumbnailImgWidth / 4) * 3;
 
    self.thumbnailImg.frame = CGRectMake(0, 0, thumbnailImgWidth, thumbnailImgHeight);
    float thumbnailImgX = self.thumbnailImg.frame.origin.x;
    float thumbnailImgY = self.thumbnailImg.frame.origin.y;
    
    float originXOftimeStamp = thumbnailImgX + thumbnailImgWidth + SPACE_THUMBNAIL_LABEL;

    self.timeStampLab.frame = CGRectMake(originXOftimeStamp, thumbnailImgY + thumbnailImgHeight - 2 * HEIGHT_TIMESTAMP , WIDTH_TIMESTAMP, HEIGHT_TIMESTAMP);
    NSLog(@"self.frame.size.width : %f", self.frame.size.width);
    self.titleLab.frame = CGRectMake(originXOftimeStamp, thumbnailImgY, self.frame.size.width - ALIGN_LEFT - self.timeStampLab.frame.origin.x - 10 , thumbnailImgHeight);
    [self.titleLab sizeToFit];

    
}

+ (float)heightOfCell {
    
    float thumbnailImgWidth = (SCREEN_MAIN_WIDTH - 2 * ALIGN_LEFT - SPACE_THUMBNAIL_LABEL * 2) / 3;
    float thumbnailImgHeight  = (thumbnailImgWidth / 4) * 3;
    return thumbnailImgHeight ;
   
}
@end
