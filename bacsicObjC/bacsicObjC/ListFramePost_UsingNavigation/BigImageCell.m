//
//  ContainerCellTableViewCell.m
//  bacsicObjC
//
//  Created by CPU11606 on 8/22/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "BigImageCell.h"
@interface BigImageCell ()


    
@end

@implementation BigImageCell
float widthCell;

- (void)layoutSubviews {
    [super layoutSubviews];
    
    float thumbnailImgWidth = self.frame.size.width - 2 * ALIGN_LEFT;
    float thumbnailImgHeight  = (thumbnailImgWidth / 16) * 9;
   
    widthCell = self.frame.size.width ;
    self.thumbnailImg.frame = CGRectMake(0, 0,thumbnailImgWidth , thumbnailImgHeight);
    float thumbnailImgX = self.thumbnailImg.frame.origin.x;
    float thumbnailImgY = self.thumbnailImg.frame.origin.y;
    
    self.titleLab.frame = CGRectMake(thumbnailImgX  , thumbnailImgY + thumbnailImgHeight + ALIGN_TOP,  thumbnailImgWidth , [ParentsCell heightOfLabel:self.titleLab.text]);
  
    self.timeStampLab.frame = CGRectMake(thumbnailImgX, self.titleLab.frame.origin.y + self.titleLab.frame.size.height + self.spaceBetweentElement  , WIDTH_TIMESTAMP , HEIGHT_TIMESTAMP);
}
+ (float)heightOfCellLandscape:(NSString *) labelText {
    float heightOfLabel = [ParentsCell heightOfLabel:labelText];
    float heightOfCell = ((((SCREEN_MAIN_WIDTH - 2 * ALIGN_LEFT - ALIGN_TOP * 2 - 25 ) / 2 ) /  16) * 9) + HEIGHT_TIMESTAMP + ALIGN_TOP * 2;
    
    if (heightOfLabel != 0) {
        return heightOfCell + heightOfLabel + ALIGN_TOP ;
    }
    return heightOfCell;
}

+ (float) heightOfCell:(NSString *) labelText {
    float heightOfLabel = [ParentsCell heightOfLabel:labelText];
    float heightOfCell = (((SCREEN_MAIN_WIDTH - 2 * ALIGN_LEFT) / 16) * 9) + HEIGHT_TIMESTAMP + ALIGN_TOP * 1;
    
    if (heightOfLabel != 0) {
        return heightOfCell + heightOfLabel + ALIGN_TOP ;
    }
    return heightOfCell;
}
@end
