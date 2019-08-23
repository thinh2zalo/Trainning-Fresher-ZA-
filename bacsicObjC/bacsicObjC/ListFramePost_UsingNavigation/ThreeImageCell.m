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
    [self updateUIForThreeImageCell];
    self.titleLab.frame = CGRectMake(PADDING , PADDING, SCREEN_MAIN_WIDTH - 2 * PADDING, HEIGHT_LAB);
    [self.titleLab setNumberOfLines:3];
    [self.titleLab sizeToFit];
    float spaceBetweenThumbnail = ( SCREEN_MAIN_WIDTH - 2 * PADDING - 3 * WITDTH_IMG ) / 2;
    self.thumbnailImg.frame = CGRectMake(PADDING,self.titleLab.frame.origin.y + self.titleLab.frame.size.height +  PADDING, WITDTH_IMG , HEIGHT_IMG);
    
    self.centerImg.frame = CGRectMake(self.thumbnailImg.frame.origin.x + self.thumbnailImg.frame.size.width + spaceBetweenThumbnail, self.frame.origin.y,  self.thumbnailImg.frame.size.width,  self.thumbnailImg.frame.size.height);
    
    self.rightImg.frame = CGRectMake(self.centerImg.frame.origin.x + self.thumbnailImg.frame.size.width + spaceBetweenThumbnail, self.thumbnailImg.frame.origin.y,  self.thumbnailImg.frame.size.width,  self.thumbnailImg.frame.size.height);
    
    self.timeStampLab.frame = CGRectMake(PADDING, self.thumbnailImg.frame.origin.y + self.thumbnailImg.frame.size.height + PADDING,self.titleLab.frame.size.width , HEIGHT_TIMESTAMP);

}

- (void)updateUIForThreeImageCell {
    NSLog(@"do you jump in ");
    self.centerImg.backgroundColor = [self randomColor];
    self.rightImg.backgroundColor = [self randomColor];
    
}


- (UIColor *)randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    UIColor *color = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    return color;
}




@end
