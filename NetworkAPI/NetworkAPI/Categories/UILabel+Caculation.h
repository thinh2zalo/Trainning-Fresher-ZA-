//
//  UILabel+Caculation.h
//  NetworkAPI
//
//  Created by Steve on 10/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN

@interface UILabel (Caculation)
+ (CGFloat)heightOfLableWithMaxLine:(UILabel *)label numberLine:(NSUInteger) numberLine withBoundingRect:(CGSize)maxSize;
+ (CGFloat) heightOf1LineWithFrontSize:(UILabel *) label;
+ (CGFloat) heightOfLabel:(UILabel *)label withBoundingRect:(CGSize)maxSize;
+ (CGFloat)heightForText:(NSString*)string WithFontSize:(CGFloat) fontSize fontName:(NSString *)fontName maxSize:(CGSize) maxSize;

@end

NS_ASSUME_NONNULL_END
