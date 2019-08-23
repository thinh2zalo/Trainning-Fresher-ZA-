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
    
    _contentID = content.contentId;
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        
        NSURL *url = content.avatarURL;
        NSData * data = [[NSData alloc] initWithContentsOfURL:url];
        if (data == nil){
            
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

-(UILabel *)titleLab{
    if (!_titleLab){
        _titleLab = UILabel.new;
        _titleLab.textColor = [UIColor blackColor];
        [_titleLab setNumberOfLines:3];
        [self addSubview:_titleLab];
        
    }
    return _titleLab;
}

-(UIImageView *)thumbnailImg{
    if (!_thumbnailImg){
        _thumbnailImg = UIImageView.new;
        _thumbnailImg.layer.borderColor = [UIColor whiteColor].CGColor;
        _thumbnailImg.layer.masksToBounds = true;
        _thumbnailImg.layer.borderWidth = 2.0f;
        _thumbnailImg.layer.cornerRadius = 6.0f;
        
        _thumbnailImg.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_thumbnailImg];
    }
    return _thumbnailImg;
}


@end
