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
    
    self.titleLab.frame = CGRectMake(PADDING , PADDING, SCREEN_MAIN_WIDTH - 2 * PADDING, HEIGHT_LAB);
    [self.titleLab setNumberOfLines:3];
    [self.titleLab sizeToFit];
    float spaceBetweenThumbnail = ( SCREEN_MAIN_WIDTH - 2 * PADDING - 3 * WITDTH_IMG ) / 2;
    
 
    self.thumbnailImg.frame = CGRectMake(PADDING, self.titleLab.frame.origin.y + self.titleLab.frame.size.height +  self.spaceOfTitle, WITDTH_IMG , HEIGHT_IMG);
    
    self.centerImg.frame = CGRectMake(self.thumbnailImg.frame.origin.x + self.thumbnailImg.frame.size.width + spaceBetweenThumbnail, self.thumbnailImg.frame.origin.y,  self.thumbnailImg.frame.size.width,  self.thumbnailImg.frame.size.height);
    
    self.rightImg.frame = CGRectMake(self.centerImg.frame.origin.x + self.thumbnailImg.frame.size.width + spaceBetweenThumbnail, self.thumbnailImg.frame.origin.y,  self.thumbnailImg.frame.size.width,  self.thumbnailImg.frame.size.height);
    
    self.timeStampLab.frame = CGRectMake(PADDING, self.thumbnailImg.frame.origin.y + self.thumbnailImg.frame.size.height + PADDING,100 , HEIGHT_TIMESTAMP);
    


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

- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}




@end
