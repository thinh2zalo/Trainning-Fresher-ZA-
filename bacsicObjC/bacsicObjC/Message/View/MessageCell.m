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
@property (nonatomic, strong) UIView * textBubbleView;
@property (nonatomic, strong) UIImageView * avatar;

@end

@implementation MessageCell
- (void)layoutSubviews {
     self.contentMess.frame = CGRectMake(20, 0, self.frame.size.width, self.frame.size.height);
    self.textBubbleView.frame = CGRectMake(10, 0, [MessageCell widthOfLabel:self.contentMess.text] + 16, self.frame.size.height);
   
}


- (void) updateDataForCell:(Message *) message {
    self.contentMess.text  = message.contentMessage;
}


- (UIView *)textBubbleView {
    if (!_textBubbleView) {
        _textBubbleView = UIView.new;
        _textBubbleView.backgroundColor = [UIColor lightGrayColor];
        _textBubbleView.layer.cornerRadius = 15;
        _textBubbleView.layer.masksToBounds = true;
        [self addSubview:_textBubbleView];
    }
    return _textBubbleView;
}

- (UILabel *)contentMess {
    if (!_contentMess) {
        _contentMess =  UILabel.new;
        _contentMess.textColor = [UIColor blackColor];
        [_contentMess setNumberOfLines:0];
        [_contentMess setFont:[UIFont boldSystemFontOfSize:20]];
        [self.textBubbleView addSubview: _contentMess];
    }
    return  _contentMess;
    
}
+ (CGFloat) heightOfLabel:(NSString *)lableText{
    CGSize maxSize = CGSizeMake( (SCREEN_MAIN_WIDTH / 3) * 2 - 20 , FLT_MAX);
    return [self heightForText:lableText WithFontSize:16 maxSize:maxSize].height;
    
}
+ (CGFloat) widthOfLabel:(NSString *)lableText{
    CGSize maxSize = CGSizeMake( (SCREEN_MAIN_WIDTH / 3) * 2 - 20 , FLT_MAX);
    return [self heightForText:lableText WithFontSize:16 maxSize:maxSize].width;
}


+ (CGSize) heightForText:(NSString*)string WithFontSize:(CGFloat) fontSize maxSize:(CGSize) maxSize {
    if (![string isKindOfClass:NSString.class]) {
        string = @"";
    }
    
    if (![string isEqualToString:@""]) {
        
        UIFont* font = [UIFont systemFontOfSize:fontSize];
        NSDictionary* attribute = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        NSAttributedString* attributeString = [[NSAttributedString alloc] initWithString:string attributes:attribute];
        CGRect textRect = [attributeString boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
       return textRect.size;
    } else return CGSizeZero;
    
}

@end
