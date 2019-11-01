//
//  ParentCell.m
//  NetworkAPI
//
//  Created by Steve on 10/29/19.
//  Copyright © 2019 Steve. All rights reserved.
//

#import "ParentCell.h"
#import "../Categories/NSString+CompareTimeStamp.h"


@implementation ParentCell

+ (ParentCell *)shareInstance {
    static ParentCell * cell = nil;
    if (!cell) {
        cell = ParentCell.new;
    }
    return  cell;
}


- (void)updateContentInsideCell:(Content *)contentToUpdate {
    NSString * time = [NSString convertTimestamp:contentToUpdate.date];
    self.timestampAndPublisherLable.text = [NSString stringWithFormat:@"%@ + %@", contentToUpdate.publicsherName, time];
    self.titleLabel.text = contentToUpdate.title;
}


- (CGFloat)thumbnailWidth {
     _thumbnailWidth = (SCREEN_MAIN_WIDTH - 4 * MARGIN ) / 3;
    return _thumbnailWidth;
}

- (CGFloat)thumbnailHeight {
     _thumbnailHeight = (self.thumbnailWidth * 3) /  4 ;
    return _thumbnailHeight;
    
}



- (UILabel *)timestampAndPublisherLable{
    if (!_timestampAndPublisherLable) {
        _timestampAndPublisherLable = UILabel.new;
        _timestampAndPublisherLable.textColor = RGB(212, 212, 212);
        [_timestampAndPublisherLable setFont:[UIFont systemFontOfSize:13]];
        [self addSubview:_timestampAndPublisherLable];
    }
    return _timestampAndPublisherLable;
    
}



-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = UILabel.new;
        [_titleLabel setNumberOfLines:3];
        
        _titleLabel.textColor = [UIColor whiteColor];
        [_titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self addSubview:_titleLabel];
        
    }
    return _titleLabel;
}





@end
