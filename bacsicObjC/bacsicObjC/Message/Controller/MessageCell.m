//
//  MessageCell.m
//  bacsicObjC
//
//  Created by Steve on 9/16/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//
#define ALIGN_LEFT 20
#import "MessageCell.h"


@interface MessageCell()

@property (nonatomic, strong) UILabel * contentMess;

@end

@implementation MessageCell
- (void)layoutSubviews {
    self.backgroundColor = [UIColor lightGrayColor];
}
+ (CGFloat) heightOfLabel:(NSString *)lableText{
    NSString *string = @"aLine";
    CGSize maxSize = CGSizeMake((SCREEN_MAIN_WIDTH - 2 * ALIGN_LEFT) , FLT_MAX);
    CGFloat heightOfEachLine  = [self heightForText:string WithFontSize:16 maxSize:maxSize];
    CGFloat heightOfLabel = [self heightForText:lableText WithFontSize:16 maxSize:maxSize];
    
    return MIN(heightOfEachLine * 3  , heightOfLabel);
    
}
- (UILabel *)contentMess {
    if (_contentMess) {
        _contentMess = UILabel.new;
        _contentMess.textColor = [UIColor clearColor];
        [_contentMess setFont:[UIFont systemFontOfSize:16]];
        [self addSubview:_contentMess];
        
    }
    return _contentMess;
}

+ (CGFloat) heightForText:(NSString*)string WithFontSize:(CGFloat) fontSize maxSize:(CGSize) maxSize {
    if (![string isKindOfClass:NSString.class]) {
        string = @"";
    }
    CGFloat textHeight = 0;
    if (![string isEqualToString:@""]) {
        
        UIFont* font = [UIFont systemFontOfSize:fontSize];
        NSDictionary* attribute = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        NSAttributedString* attributeString = [[NSAttributedString alloc] initWithString:string attributes:attribute];
        CGRect textRect = [attributeString boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        textHeight = textRect.size.height;
    }
    return textHeight;
}

@end
