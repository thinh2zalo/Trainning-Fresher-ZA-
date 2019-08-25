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

- (float)spaceOfTitle {
    _spaceOfTitle = 0;
    if (self.titleLab.frame.size.height != 0) {
        _spaceOfTitle = PADDING;
    }
    return _spaceOfTitle;
}

-(UILabel *)titleLab{
    if (!_titleLab){
        _titleLab = UILabel.new;
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
        _thumbnailImg.contentMode = UIViewContentModeScaleToFill;
        [self  addSubview:_thumbnailImg];
    }
    return _thumbnailImg;
}


+ (CGFloat) heightOfLabel:(NSString *)lableText{
    NSString *string = @"aLine";
    CGSize maxSize = CGSizeMake(CELL_WIDTH - 2 * PADDING, FLT_MAX);
    CGFloat heightOfEachLine  = [self heightForText:string WithFontSize:16 maxSize:maxSize];
    CGFloat heightOfLabel = [self heightForText:lableText WithFontSize:16 maxSize:maxSize];
    
    return MIN(heightOfEachLine * 3  , heightOfLabel);
    
}

+ (CGFloat) heightForText:(NSString*)string WithFontSize:(CGFloat) fontSize maxSize:(CGSize) maxSize {
    
    CGFloat textHeight = - SPACE;
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
