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


- (void)layoutSubviews {
    [super layoutSubviews];
    self.thumbnailImg.frame = CGRectMake(PADDING , PADDING, SCREEN_MAIN_WIDTH - 2 * PADDING, CELL_HEIGHT_BIG_IMG);
    self.titleLab.frame = CGRectMake(self.thumbnailImg.frame.origin.x * 2 , self.thumbnailImg.frame.origin.y + self.thumbnailImg.frame.size.height + PADDING, CELL_WIDTH - 2 * PADDING ,0);
    [self.titleLab setNumberOfLines:3];
    [self.titleLab sizeToFit];
    self.timeStampLab.frame = CGRectMake(self.titleLab.frame.origin.x, self.titleLab.frame.origin.y + self.titleLab.frame.size.height + self.spaceOfTitle  , CELL_WIDTH / 2 , 10);
    NSLog(@"height of self : %f", self.frame.size.height);

    

   
}

@end
