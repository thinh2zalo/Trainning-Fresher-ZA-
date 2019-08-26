//
//  Contrainner.m
//  CreateUIDemo
//
//  Created by CPU11606 on 8/15/19.
//  Copyright © 2019 CPU11606. All rights reserved.
//

#import "ParentsCell.h"






@implementation ParentsCell
- (void)layoutSubviews {
    [super layoutSubviews];
 
  
}


- (void)updateContentInsideCell:(Content *)content{
    self.titleLab.text = content.title;
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        NSURL *url = content.avatarURL;
        NSData * data = [[NSData alloc] initWithContentsOfURL:url];
        if (data == nil){
            NSLog(@"data is null");
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            self.thumbnailImg.image = [UIImage imageWithData: data];
        });
        
    });
    self.timeStampLab.text = [NSString compareTimeStamp:content.date];
    
}

- (UILabel *)timeStampLab{
    if (!_timeStampLab) {
        _timeStampLab = UILabel.new;
        [_timeStampLab setFont:[UIFont systemFontOfSize:13]];
        
        [self addSubview:_timeStampLab];
    }
    return _timeStampLab;
    
}

- (float)spaceBetweentElement {
    if (![self.titleLab.text isEqualToString:@""]) {
        return ALIGN_TOP;
    }
    return 0;
}

-(UILabel *)titleLab{
    if (!_titleLab){
        _titleLab = UILabel.new;
        [_titleLab setNumberOfLines:3];
        _titleLab.textColor = [UIColor blackColor];
        [_titleLab setFont:[UIFont systemFontOfSize:16]];
        [self addSubview:_titleLab];
        
    }
    return _titleLab;
}

-(UIImageView *)thumbnailImg{
    if (!_thumbnailImg){
        _thumbnailImg = UIImageView.new;
        _thumbnailImg.layer.masksToBounds = true;
        _thumbnailImg.layer.borderWidth = 2.0f;
        _thumbnailImg.layer.cornerRadius = 6.0f;
        _thumbnailImg.layer.borderColor = [UIColor whiteColor].CGColor;
        _thumbnailImg.contentMode = UIViewContentModeScaleAspectFill;
        [self  addSubview:_thumbnailImg];
    }
    return _thumbnailImg;
}


+ (CGFloat) heightOfLabel:(NSString *)lableText{
    NSString *string = @"aLine";
    CGSize maxSize = CGSizeMake((SCREEN_MAIN_WIDTH - 2 * ALIGN_LEFT) , FLT_MAX);
    CGFloat heightOfEachLine  = [self heightForText:string WithFontSize:16 maxSize:maxSize];
    CGFloat heightOfLabel = [self heightForText:lableText WithFontSize:16 maxSize:maxSize];
    
    return MIN(heightOfEachLine * 3  , heightOfLabel);
    
}

+ (CGFloat) heightForText:(NSString*)string WithFontSize:(CGFloat) fontSize maxSize:(CGSize) maxSize {
    
    CGFloat textHeight = - ALIGN_TOP;
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
