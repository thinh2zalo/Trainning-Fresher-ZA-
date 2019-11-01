//
//  UILabel+Caculation.m
//  NetworkAPI
//
//  Created by Steve on 10/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "UILabel+Caculation.h"


@implementation UILabel (Caculation)
+ (CGFloat) heightOf1LineWithFrontSize:(UILabel *) label {
    return [UILabel heightForText:@"aLine" WithFontSize:label.font.pointSize fontName:label.font.fontName maxSize:CGSizeMake(FLT_MAX, FLT_MAX)];
}

+ (CGFloat)heightForText:(NSString*)string WithFontSize:(CGFloat) fontSize fontName:(NSString *)fontName maxSize:(CGSize) maxSize  {
    if (![string isKindOfClass:NSString.class]) {
        string = @"";
    }
    CGFloat textHeight = 0;
    if (![string isEqualToString:@""]) {
        UIFont* font = [UIFont fontWithName:fontName size:fontSize];
        NSDictionary* attribute = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        NSAttributedString* attributeString = [[NSAttributedString alloc] initWithString:string attributes:attribute];
        CGRect textRect = [attributeString boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        textHeight = textRect.size.height;
    }
    return textHeight;
}

+ (CGFloat)heightOfLableWithMaxLine:(UILabel *)label numberLine:(NSUInteger) numberLine withBoundingRect:(CGSize)maxSize {
    
    CGFloat heightOfEachLine = [UILabel heightOf1LineWithFrontSize:label];
    CGFloat heightOfLabel = [UILabel heightOfLabel:label withBoundingRect:maxSize];
    
    return MIN(heightOfEachLine * numberLine  , heightOfLabel);
}

+ (CGFloat) heightOfLabel:(UILabel *)label withBoundingRect:(CGSize)maxSize{
   
   return [UILabel heightForText:label.text WithFontSize:label.font.pointSize fontName:label.font.fontName maxSize:maxSize];
    
}

@end
