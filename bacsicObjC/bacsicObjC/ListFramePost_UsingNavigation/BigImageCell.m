//
//  ContainerCellTableViewCell.m
//  bacsicObjC
//
//  Created by CPU11606 on 8/22/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "BigImageCell.h"

@implementation BigImageCell


- (void)layoutSubviews {
    self.backgroundColor = [UIColor whiteColor];
    self.thumbnailImg.frame = CGRectMake(PADDING, PADDING, SCREEN_MAIN_WIDTH - PADDING * 2, (CELL_HEIGHT_BIG_IMG / 3) * 2);
    self.titleLab.frame = CGRectMake(PADDING * 2 , self.thumbnailImg.frame.origin.y + self.thumbnailImg.frame.size.height + PADDING , CELL_WIDTH - 2 * PADDING ,((CELL_HEIGHT_BIG_IMG / 3) / 3) * 2);
    [self.titleLab setNumberOfLines:2];
    [self.titleLab sizeToFit];
    self.timeStampLab.frame = CGRectMake(self.titleLab.frame.origin.x, self.titleLab.frame.origin.y + self.titleLab.frame.size.height + 15 , CELL_WIDTH / 2 , (CELL_HEIGHT_BIG_IMG / 3) / 3);
    [self.timeStampLab setNumberOfLines:2];
    [self.timeStampLab sizeToFit];
   
}






@end
