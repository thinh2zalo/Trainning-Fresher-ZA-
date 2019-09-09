//
//  threeImageCell.m
//  bacsicObjC
//
//  Created by CPU11606 on 8/22/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "ThreeImageCell.h"

@interface ThreeImageCell ()

@end

@implementation ThreeImageCell


- (void)layoutSubviews {
    [super  layoutSubviews];
    
    self.titleLab.frame = CGRectMake(0 , 0, self.frame.size.width - 2 * ALIGN_LEFT,   [ParentsCell heightOfLabel:self.titleLab.text]);
        
    float thumbnailWidth = (self.frame.size.width - 2 * ALIGN_LEFT - SPACE_THUMBNAIL_LABEL * 2) / 3;
    float thumbnailHeight  = (thumbnailWidth / 4) * 3;

    self.thumbnailImg.frame = CGRectMake(0, self.titleLab.frame.origin.y + self.titleLab.frame.size.height +  self.spaceBetweentElement, thumbnailWidth , thumbnailHeight);
    
    float thumbnailImgY = self.thumbnailImg.frame.origin.y;
    float thumbnailImgX = self.thumbnailImg.frame.origin.x;

    self.centerImg.frame = CGRectMake(thumbnailImgX + thumbnailWidth + SPACE_BETWEEN_THREE_IMG, thumbnailImgY,  thumbnailWidth,  thumbnailHeight);
    
    self.rightImg.frame = CGRectMake(thumbnailImgX + 2 * thumbnailWidth + 2 * SPACE_BETWEEN_THREE_IMG, thumbnailImgY,  thumbnailWidth,  thumbnailHeight);
    
    self.timeStampLab.frame = CGRectMake(thumbnailImgX, thumbnailImgY + thumbnailHeight + ALIGN_TOP, 100 , HEIGHT_TIMESTAMP);
}


- (void)updateContentInsideCell:(Content *)content {
    [super updateContentInsideCell:content];
    self.centerImg.backgroundColor = [self randomColor];
    self.rightImg.backgroundColor = [self randomColor];
    
}

-(UIImageView *)rightImg{
    if (!_rightImg){
        _rightImg = UIImageView.new;
        _rightImg.layer.borderColor = [UIColor whiteColor].CGColor;
        _rightImg.layer.masksToBounds = true;
        _rightImg.layer.borderWidth = 2.0f;
        _rightImg.layer.cornerRadius = 6.0f;
        
        _rightImg.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_rightImg];
    }
    return _rightImg;
}

-(UIImageView *)centerImg{
    if (!_centerImg){
        _centerImg = UIImageView.new;
        _centerImg.layer.borderColor = [UIColor whiteColor].CGColor;
        _centerImg.layer.masksToBounds = true;
        _centerImg.layer.borderWidth = 2.0f;
        _centerImg.layer.cornerRadius = 6.0f;
        
        _centerImg.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_centerImg];
    }
    return _centerImg;
}


+ (float) heightOfCell:(NSString *)labelText {
    if ([labelText isKindOfClass:NSString.class]) {
    float thumbnailWidth = (SCREEN_MAIN_WIDTH - 2 * ALIGN_LEFT - SPACE_THUMBNAIL_LABEL * 2) / 3;
    float thumbnailHeight  = (thumbnailWidth / 4) * 3;
    float heightOfLabel = [ParentsCell heightOfLabel:labelText];
    float heightOfCell = thumbnailHeight + HEIGHT_TIMESTAMP + ALIGN_TOP * 1;
    if (heightOfLabel != 0) {
        return heightOfCell + heightOfLabel + ALIGN_TOP ;
    }
    return heightOfCell;
    } else return 0;
    
}

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}




@end
